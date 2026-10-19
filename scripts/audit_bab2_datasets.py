"""Count pinned dataset records without executing any dataset code.

Usage: python scripts/audit_bab2_datasets.py --source-dir <cached-files>
Omit --source-dir to download the two public, commit-pinned files.
Counts describe records and labels, not verified vulnerabilities or test results.
"""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import re
from urllib.request import urlopen

SOURCES = {
    "securityeval": (
        "6f4fb70f782c6d47b02ea24341e8ef8c1eb04a6a",
        "securityeval-dataset.jsonl",
        "https://raw.githubusercontent.com/s2e-lab/SecurityEval/{}/dataset.jsonl",
    ),
    "llmseceval": (
        "39e97f046dbb2c4c604d31b86f2a4d3d27827388",
        "llmseceval-dataset.json",
        "https://raw.githubusercontent.com/tuhh-softsec/LLMSecEval/{}/Dataset/LLMSecEval-Prompts_dataset.json",
    ),
}


def cwe(identifier):
    return int(re.match(r"CWE-(\d+)", identifier).group(1))


def duplicates(values):
    return {key: count for key, count in sorted(Counter(values).items()) if count > 1}


def audit(source_dir=None):
    reports, records = {}, {}
    for name, (commit, filename, template) in SOURCES.items():
        url = template.format(commit)
        if source_dir:
            data = (source_dir / filename).read_bytes()
        else:
            with urlopen(url, timeout=60) as response:
                data = response.read()
        text = data.decode("utf-8-sig")
        rows = [json.loads(line) for line in text.splitlines() if line.strip()] if filename.endswith("jsonl") else json.loads(text)
        key = "ID" if name == "securityeval" else "Prompt ID"
        reports[name] = {
            "commit": commit, "source_url": url,
            "sha256": hashlib.sha256(data).hexdigest(),
            "samples": len(rows), "cwe_count": len({cwe(row[key]) for row in rows}),
        }
        records[name] = rows
    py = [row for row in records["llmseceval"] if row["Language"].lower() == "python"]
    ids = [row["Prompt ID"] for row in py]
    reports["llmseceval"].update({
        "languages": dict(sorted(Counter(row["Language"] for row in records["llmseceval"]).items())),
        "python_samples": len(py), "python_unique_prompt_ids": len(set(ids)),
        "python_cwe_count": len({cwe(value) for value in ids}),
        "python_duplicate_prompt_ids": duplicates(ids),
        "python_duplicate_filenames": duplicates(row["Filename"] for row in py),
        "python_duplicate_manual_prompts": duplicates(row["Manually-fixed NL Prompt"] for row in py),
        "python_rows_per_cwe": dict(sorted(Counter(cwe(value) for value in ids).items())),
        "python_unique_ids_per_cwe": dict(sorted(Counter(cwe(value) for value in set(ids)).items())),
        "python_non_py_filenames": [row["Filename"] for row in py if not row["Filename"].endswith(".py")],
        "id_collisions": [{"prompt_id": value, "filenames": [row["Filename"] for row in py if row["Prompt ID"] == value]}
                          for value in duplicates(ids)],
    })
    reports["shared_python_cwes"] = sorted({cwe(row["ID"]) for row in records["securityeval"]} & {cwe(value) for value in ids})
    reports["checked_on"] = "2026-10-20"
    reports["method"] = "Count records and integer CWE prefixes; Python filter uses Language.lower(). Duplicate IDs are not assumed to be identical tasks. No code execution, manual label validation, or experiment-subset selection."
    return reports


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source-dir", type=Path)
    parser.add_argument("--output", type=Path, default=Path("reference/bab2-snapshot-dataset.json"))
    args = parser.parse_args()
    report = audit(args.source_dir)
    args.output.write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(json.dumps({name: {k: v for k, v in item.items() if k in {"samples", "cwe_count", "python_samples", "python_unique_prompt_ids"}}
                      for name, item in report.items() if isinstance(item, dict)}))
