# Referensi Penelitian Tugas Akhir

Sepuluh paper prioritas untuk penelitian keamanan kode hasil LLM dan gate multi-agen. Nomor berkas mengikuti urutan baca pada daftar awal. Semua paper tersedia sebagai PDF lokal lengkap.

Diunduh pada 18 Oktober 2026. Versi yang disebutkan secara eksplisit pada daftar awal dipertahankan: AutoSafeCoder v1, CyberSecEval v1, VulTrial v2, dan RAG + Multi-Tool Feedback v1. Untuk tautan tanpa versi, PDF diambil dari tautan arXiv tersebut saat pengunduhan.

## Bahan kerja Bab 2

Pada 21 Oktober 2026, nama Bab 2 diubah menjadi **Studi Literatur**. Bagian II.3.4 membandingkan Evidence-Based Arbiter dengan ReasonVul, VulTrial, QASecClaw, Refute-or-Promote, dan AutoSafeCoder. Perbandingan ditempatkan dalam pembahasan arbiter; bagian II.6 dan paragraf Sintesis dan Keterbatasan tetap tidak dimasukkan.

Draf diperbarui pada 20 Oktober 2026. Bab 2 memuat II.1–II.5 dengan sitasi APA dan bibliografi. Seluruh penanda draf telah ditangani melalui pemeriksaan sumber, koreksi, pembatasan klaim, atau pemindahan rancangan ke catatan pribadi. Implementasi dan eksperimen gate belum dijalankan.

- [Draf Bab 2 dalam Typst](../chapters/02-studi-literatur.typ)
- [Pratinjau PDF khusus Bab 2](../output/pdf/bab-2-tinjauan-pustaka.pdf)
- [Daftar pustaka kandidat dan status verifikasi](bab2-daftar-pustaka-kandidat.md)
- [Hasil pemeriksaan V01–V17](bab2-verifikasi.md)
- [Catatan pribadi: bekas 2.6 dan rancangan eksperimen](../notes/bab2-catatan-pribadi.md)
- [Bibliografi yang dipakai naskah](../references.bib)
- [Metadata sumber primer mentah](bab2-metadata-sumber.json)
- [Metadata publikasi setelah pemeriksaan](bab2-metadata-terverifikasi.json)
- [Snapshot penghitungan dataset](bab2-snapshot-dataset.json)
- [Skrip penghitungan dataset](../scripts/audit_bab2_datasets.py)

## Wajib baca penuh: pembanding terdekat

1. **AutoSafeCoder**

   Judul: *AutoSafeCoder: A Multi-Agent Framework for Securing LLM Code Generation through Static Analysis and Fuzz Testing*.

   Rujukan utama gate multi-agen untuk kode LLM; fokus pada integrasi agen pembuat kode, analisis statis, dan fuzz testing.

   [PDF lokal, 10 halaman](01-autosafecoder-2409.10737v1.pdf) | [Sumber: arXiv 2409.10737v1](https://arxiv.org/html/2409.10737v1)

2. **Does Teaming-Up LLMs Improve Secure Code Generation?**

   Judul: *Does Teaming-Up LLMs Improve Secure Code Generation? A Comprehensive Evaluation with Multi-LLMSecCodeEval*.

   Pembanding untuk menilai apakah penggunaan beberapa LLM memperbaiki keamanan kode dibandingkan satu LLM.

   [PDF lokal, 16 halaman](02-teaming-up-llms-2603.22717.pdf) | [Sumber: arXiv 2603.22717](https://arxiv.org/pdf/2603.22717)

## Wajib untuk latar belakang dan dataset

3. **CyberSecEval**

   Judul: *Purple Llama CyberSecEval: A Secure Coding Benchmark for Language Models*.

   Rujukan benchmark untuk latar belakang dan rancangan evaluasi keamanan kode hasil LLM.

   [PDF lokal, 13 halaman](03-cyberseceval-2312.04724v1.pdf) | [Sumber: arXiv 2312.04724v1](https://arxiv.org/abs/2312.04724v1)

4. **Perbandingan tujuh LLM: lebih dari 73% cuplikan kode rentan**

   Judul: *Security of LLM-generated Code: A Comparative Analysis*.

   Data untuk latar belakang masalah. Bagian 4.4 melaporkan lebih dari 73% cuplikan kode yang dihasilkan memiliki setidaknya satu kerentanan dalam eksperimen paper ini.

   [PDF lokal, 22 halaman](04-seven-llms-code-security-2605.23091.pdf) | [Sumber: arXiv 2605.23091](https://arxiv.org/pdf/2605.23091)

## Untuk desain arbiter dan reviewer

5. **ReasonVul**

   Judul: *Three Heads Are Better Than One: A Multi-perspective Reasoning Framework for Enhanced Vulnerability Detection*.

   Rujukan untuk membandingkan voting dan debat dalam menyelesaikan perbedaan penilaian antaragen.

   [PDF lokal, 24 halaman](05-reasonvul-2605.18153.pdf) | [Sumber: arXiv 2605.18153](https://arxiv.org/pdf/2605.18153)

   DOI versi ACM yang dicantumkan pada daftar awal: [10.1145/3808197](https://doi.org/10.1145/3808197). Judul, penulis, dan metadata publikasi DOI ini telah cocok dengan Crossref pada 20 Oktober 2026. Berkas lokal tetap merupakan preprint arXiv, bukan unduhan versi ACM.

6. **VulTrial**

   Judul: *Let the Trial Begin: A Mock-Court Approach to Vulnerability Detection using LLM-Based Agents*.

   Contoh pembagian peran dalam proses penilaian kerentanan, dengan pendekatan persidangan yang melibatkan penuntut, pembela, hakim, dan juri.

   [PDF lokal, 13 halaman](06-vultrial-2505.10961v2.pdf) | [Sumber: arXiv 2505.10961v2](https://arxiv.org/html/2505.10961v2)

## Untuk agen analisis statis

7. **SAST-Genius**

   Judul: *LLM-Driven SAST-Genius: A Hybrid Static Analysis Framework for Comprehensive and Actionable Security*.

   Rujukan penggabungan SAST dan LLM untuk menekan false positive serta memperjelas konteks temuan keamanan.

   [PDF lokal, 6 halaman](07-sast-genius-2509.15433.pdf) | [Sumber: arXiv 2509.15433](https://arxiv.org/pdf/2509.15433)

## Untuk fixer

8. **RAG + Multi-Tool Feedback**

   Judul: *Improving LLM-Assisted Secure Code Generation through Retrieval-Augmented-Generation and Multi-Tool Feedback*.

   Rujukan loop perbaikan kode yang menggunakan retrieval dan umpan balik beberapa alat, termasuk CodeQL.

   [PDF lokal, 5 halaman](08-rag-multi-tool-feedback-2601.00509v1.pdf) | [Sumber: arXiv 2601.00509v1](https://arxiv.org/abs/2601.00509v1)

## Untuk ketahanan gate

9. **Adversarial Attacks on LLM-as-a-Judge**

   Judul: *Adversarial Attacks on LLM-as-a-Judge Systems: Insights from Prompt Injections*.

   Dasar untuk merancang pengujian ketahanan reviewer terhadap prompt injection dan manipulasi penilaian.

   [PDF lokal, 12 halaman](09-adversarial-llm-as-a-judge-2504.18333.pdf) | [Sumber: arXiv 2504.18333](https://arxiv.org/abs/2504.18333)

10. **LLM Code Reviewers Are Harder to Fool**

    Judul pada halaman pertama PDF: *LLM Code Reviewers Are Harder to Fool Than You Think*, dengan subjudul *Adversarial Comments Fail Where Vulnerability Patterns Succeed*. Metadata PDF menggunakan judul *Can Adversarial Code Comments Fool AI Security Reviewers -- Large-Scale Empirical Study of Comment-Based Attacks and Defenses Against LLM Code Analysis*.

    Rujukan serangan berbasis komentar kode terhadap reviewer LLM dan evaluasi pertahanannya.

    [PDF lokal, 19 halaman](10-llm-code-reviewer-attacks-2602.16741.pdf) | [Sumber: arXiv 2602.16741](https://arxiv.org/pdf/2602.16741)

## Gaya bibliografi

[apa.csl](apa.csl) diadaptasi dari [APA Style 7th edition pada repositori Citation Style Language](https://github.com/citation-style-language/styles/blob/master/apa.csl), versi 7 Februari 2026, karya Brenton M. Wiernik, Andrew Dunning, dan kontributor yang tercantum dalam berkas. Lisensi [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/) tetap berlaku untuk adaptasi ini.

Perubahan lokal pada 20 Oktober 2026 menggunakan akhiran tahun (misalnya 2026a/2026b) untuk label singkat yang bertabrakan. Perluasan nama dalam proses disambiguasi dinonaktifkan karena pada Typst 0.15.0 membuat beberapa nama dalam bibliografi menjadi singkatan. Metadata nama lengkap tetap disimpan pada `references.bib`. Ini penyesuaian tampilan, bukan perubahan penulis atau tahun publikasi.
