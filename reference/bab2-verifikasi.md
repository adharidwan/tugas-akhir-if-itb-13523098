# Hasil Pemeriksaan Draf Bab 2

Tanggal: **20 Oktober 2026**. Seluruh 17 penanda pekerjaan pada draf telah ditangani. Bab 2 kini berisi 2.1–2.5. Tabel pembanding dan posisi penelitian yang sebelumnya berada pada 2.6 dipindahkan ke [catatan pribadi](../notes/bab2-catatan-pribadi.md).

**Arti penyelesaian:** klaim literatur diperiksa, dikoreksi, atau dibatasi; angka yang tidak dapat dibandingkan dikeluarkan dari perbandingan; keputusan rancangan dipindahkan ke catatan pribadi. Ini bukan pernyataan bahwa implementasi atau eksperimen gate telah selesai. Hasil paper tetap merupakan laporan penulis, bukan hasil replikasi sendiri.

## V01 — Snapshot SecurityEval

**Selesai: hitungan sumber primer dikonfirmasi.** Pada commit `6f4fb70f782c6d47b02ea24341e8ef8c1eb04a6a`, terdapat 121 baris dan 69 CWE unik berdasarkan awalan `ID`. Angka 130/75 dari brief tidak digunakan. Versi ini dibekukan sebagai sumber rancangan awal. Hitungan isi dataset dibedakan dari jumlah percobaan dan validasi label manual.

[Sumber pada commit](https://github.com/s2e-lab/SecurityEval/blob/6f4fb70f782c6d47b02ea24341e8ef8c1eb04a6a/dataset.jsonl). [Skrip penghitungan](../scripts/audit_bab2_datasets.py), [hasil dan SHA-256](bab2-snapshot-dataset.json).

## V02 — Subset Python dan CWE LLMSecEval

**Selesai: satuan hitung dan cakupan diperjelas.** Commit `39e97f046dbb2c4c604d31b86f2a4d3d27827388` memuat 150 baris, 18 CWE, 67 baris C, serta 83 baris Python dengan 12 CWE. Seluruh nama berkas pada subset berlabel Python berakhiran `.py`. Irisan CWE Python dengan SecurityEval adalah 20, 22, 78, 79, 89, 200, 306, 434, 502, 522, 732, dan 798.

Lima kategori untuk studi kelayakan awal (22, 78, 89, 502, 798) dicatat sebagai keputusan rancangan pribadi. Bab 2 tidak mengklaim sudah ada subset final yang seluruh kodenya dapat dieksekusi.

[Data primer](https://github.com/tuhh-softsec/LLMSecEval/blob/39e97f046dbb2c4c604d31b86f2a4d3d27827388/Dataset/LLMSecEval-Prompts_dataset.json).

## V03 — 83 baris dibanding 81 Prompt ID

**Selesai: perbedaan hitungan diterangkan tanpa mengarang seleksi penulis.** Pada 83 baris Python terdapat 81 `Prompt ID` unik. `CWE-20_IIV-2b` dan `CWE-522_IPC-3a` masing-masing muncul dua kali. Semua Filename dan prompt yang telah diperbaiki secara manual pada subset itu berbeda. Jadi, tabrakan ID bukan bukti dua tugas identik.

Jumlah ID unik per CWE cocok dengan distribusi 81 prompt pada Tabel 1 Morkonda dkk. Ini menjelaskan perbedaan satuan hitung, tetapi tidak membuktikan penulis menggunakan aturan deduplikasi tertentu atau snapshot yang sama. Draf mempertahankan batas tersebut. Nama produk juga tidak dianggap sebagai ID backend model untuk replikasi.

[Morkonda dkk., bagian 3.2 dan Tabel 1](https://arxiv.org/pdf/2605.23091), [audit yang dapat dihitung ulang](bab2-snapshot-dataset.json).

## V04 — CodeSecEval dan SecAwareCoder

**Selesai: metode, perubahan versi, dan status artefak diperiksa.** v2 2024 menyebut 180 sampel/44 jenis kerentanan. PDF v3 September 2026 menyebut 255 tugas Python/77 CWE dan menghubungkan pemodelan ancaman sesuai tugas, pembuatan kode dengan batasan keamanan, pembuatan pengujian, serta perbaikan berdasarkan eksekusi. Data menyediakan kode rentan, kode perbaikan, serta pengujian fungsi dan keamanan.

Hugging Face menampilkan split 255 baris. Repositori resmi menggunakan lisensi MIT dan secara eksplisit menyatakan kode SecAwareCoder belum dirilis pada tanggal pemeriksaan. Karena itu, ketersediaan dataset tidak disebut sebagai ketersediaan implementasi lengkap. Metode digunakan sebagai pembanding konsep; klaim replikasi, ketiadaan sanitasi/serangan secara menyeluruh, atau perbandingan angka langsung tidak dibuat. Asal tugas yang beririsan harus dikelompokkan sebelum pembagian data jika kelak dipakai bersama dataset lain.

[PDF v2](https://arxiv.org/pdf/2407.02395v2), [PDF v3, metode dan bagian ketersediaan data](https://arxiv.org/pdf/2407.02395v3), [data primer](https://huggingface.co/datasets/JasonWang1/CodeSecEval), [status implementasi](https://github.com/CY-SCUT-MS/CodeSecEval#repository-status).

## V05 — Hasil Multi-LLMSecCodeEval

**Selesai: hasil lintas-konfigurasi tidak digabung.** Bagian hasil P10 menyebut secure 97,32% dan 99,06%, sedangkan Tabel 4 menggunakan kelompok model lebih kecil dan memuat insecure 3,6% serta 1,9%. Konfigurasi tersebut tidak diperlakukan sebagai pasangan persentase yang wajib saling melengkapi. Nama benchmark pada draf diseragamkan menjadi SecLLMEval dan SecLLMHolmes.

Bab 2 hanya memakai kesimpulan kualitatif tentang manfaat penggabungan alat statis dan pemeriksaan lintas-model, dengan batas konteks pengujian. Tidak ada rata-rata gabungan, penurunan relatif, atau angka keunggulan universal yang disimpulkan dari konfigurasi berbeda. CodeQL sebagai komponen alur dan alat penilaian juga tidak dianggap dua bukti independen.

[Paper primer, bagian 5 dan Tabel 4](https://arxiv.org/pdf/2603.22717).

## V06 — SAST-Genius

**Selesai: konteks angka ditemukan pada bagian IV dan Tabel I.** Pengujian meliputi 25 repositori GitHub dengan lebih dari 250 ribu baris Python, Java, dan JavaScript. Label acuan berisi 170 kerentanan yang disusun dari pemeriksaan ahli dan kerentanan publik. Konfigurasi memuat Semgrep 1.97.0, pembanding GPT-4, serta Llama 3 8B yang di-fine-tune untuk SAST-Genius.

Tabel melaporkan Semgrep: 350 temuan, 125 TP, 225 FP; GPT-4: 200 temuan, 131 TP, 69 FP; SAST-Genius: 190 temuan, 170 TP, 20 FP. Pelatihan memuat data terbuka dan proprietary sehingga replikasi lengkap tidak disimpulkan tersedia. Draf memakai penurunan FP dengan konteks ini dan tidak memindahkannya menjadi perkiraan peningkatan Python. Tidak ada klaim waktu triase rinci yang ditambahkan.

[PDF primer](https://arxiv.org/pdf/2509.15433).

## V07 — Kebijakan arbiter

**Selesai untuk draf: dipisahkan sebagai rancangan, bukan temuan pustaka.** Catatan pribadi menetapkan definisi pass/revise/block, syarat pemeriksaan wajib, pembatasan kewenangan Triage, pelacakan hash kode, kegagalan parsing/layanan, serta aturan saat bukti bertentangan. Temuan SAST tinggi tidak dibatalkan oleh Triage sendiri. Severity asal tetap dicatat; nomor CWE bukan severity. Kebijakan YAML berversi dan validasi skema merupakan usulan implementasi. Bab 2 tidak mengklaim kebijakan tersebut terbukti optimal.

[Bukti bahwa triase dapat menurunkan recall: QASecClaw](https://arxiv.org/pdf/2605.01885), [rancangan pribadi](../notes/bab2-catatan-pribadi.md).

## V08 — Identitas 13 kandidat

**Selesai: semua identitas ditautkan ke sumber primer.** Katalog kini memuat judul, penulis, tahun/versi, venue, dan sumber primer LLM4SA (Wen dkk.), Semgrep* (Bennett dkk.), debat Du dkk., Greshake dkk., Liu dkk. USENIX 2024, studi Copilot Pearce dkk., Self-Debugging Chen dkk., Self-Repair Olausson dkk., Talk Isn't Always Cheap (Wynn dkk.), More Rounds, More Noise (Song Tae-Eun), When Collaboration Fails (Kraidia dkk.), skripsi Brnák, dan penelitian paket halusinasi Spracklen dkk.

Tahun preprint Pearce 2021 dibedakan dari tahun konferensi 2022 yang disebut brief. Self-Debugging memakai rekaman ICLR 2024; Self-Repair memakai revisi 2024. Nama Song Tae-Eun tidak dipecah melalui dugaan. Sumber paket halusinasi disimpan sebagai kandidat di luar cakupan. Identitas yang sudah ditemukan tidak otomatis membuat semua angka boleh dikutip.

[Katalog dengan tautan primer per entri](bab2-daftar-pustaka-kandidat.md), [metadata yang dipakai](bab2-metadata-terverifikasi.json).

## V09 — Model dan batas iterasi

**Selesai untuk draf: parameter eksperimen dipisahkan dari fakta literatur.** Batas rancangan awal adalah dua ronde perbaikan; loop berhenti jika kode identik atau mengulang hash sebelumnya. Identitas model menjadi parameter konfigurasi yang wajib dicatat persis saat dijalankan. Tidak ada nama model, ketersediaan layanan, anggaran berbayar, atau hasil optimasi yang dibuat-buat. Kondisi Fixer sama/berbeda dibedakan dari ukuran model, dengan generator dan reviewer yang tetap. Fokus utamanya keputusan gate serta ketahanan. Seluruh rincian ini berada pada catatan pribadi untuk Bab 3.

## V10 — Fungsi pembanding terdekat

**Selesai: fungsi yang dipakai dalam perbandingan diperiksa dan klaim ketiadaan dipersempit.**

| Studi | Hasil pemeriksaan yang relevan | Batas pemakaian |
|---|---|---|
| AutoSafeCoder | Metode 3.2: reviewer statis merupakan LLM. Setup 4.2 dan Tabel 1: Bandit menilai hasil. Pada GPT-4o, rentan 59/121 menjadi 44/121, sedangkan pass@1 0,9085 menjadi 0,8780. | Penurunan rentan sekitar 12,4 poin persentase; tidak disebut 13% relatif atau tanpa penurunan fungsi. |
| MAVUL | Metode serta `evaluation_agent.py`: analis konteks dan arsitek keamanan memakai GPT-4o; evaluasi membandingkan keluaran dengan ground truth. | Evaluation agent saat eksperimen berbeda dari arbiter tanpa label acuan saat penggunaan gate. |
| VulTrial | Peran peneliti keamanan, penulis kode, moderator, dan review board. | Analogi persidangan tidak dianggap identik dengan aturan penerimaan kode hasil generasi. |
| QASecClaw | Bagian III-C: jalur bukti dinamis tidak aktif pada OWASP Benchmark; implementasi menyebut Qwen 3.5 Plus. | Tidak menyebut semua temuan telah terbukti melalui exploit. |
| Multi-LLMSecCodeEval | Sudah menghubungkan generasi, deteksi, serta patching; kelompok model pada percobaan utama dan ablasinya dibedakan. | Pipeline umum bukan kebaruan sendiri; angka lintas-konfigurasi tidak dicampur. |
| AutoPatch | Mengambil informasi CVE dan memperbaiki kode; F1 verifikasi berbeda dari accuracy patching. | Tidak membandingkan accuracy patching langsung dengan F1 deteksi atau menukar versinya. |
| Refute-or-Promote | Metode dan laporan kasus: gerbang bertahap, upaya membantah temuan, kritik lintas-model; repositori memuat catatan metode. | Bukan bukti implementasi otomatis lengkap telah tersedia atau bahwa metode belum pernah memakai gate. |
| SecAwareCoder | Pemodelan ancaman serta pengujian fungsi/keamanan; dataset dirilis, kode metode belum dirilis. | Pembanding konsep, bukan baseline yang sudah direplikasi. |

Sumber: [AutoSafeCoder](https://arxiv.org/pdf/2409.10737v1), [kode MAVUL](https://github.com/youpengl/MAVUL/blob/main/evaluation_agent.py), [VulTrial](https://arxiv.org/pdf/2505.10961v2), [QASecClaw](https://arxiv.org/pdf/2605.01885), [Multi-LLMSecCodeEval](https://arxiv.org/pdf/2603.22717), [AutoPatch](https://arxiv.org/pdf/2505.04195), [Refute-or-Promote](https://arxiv.org/pdf/2604.19049), [repositori Refute-or-Promote](https://github.com/abhinavagarwal07/refute-or-promote), [CodeSecEval](https://github.com/CY-SCUT-MS/CodeSecEval).

Pemeriksaan ini tidak menjalankan repositori dan bukan audit menyeluruh seluruh implementasi. Tabel pribadi tidak lagi menyimpulkan ketiadaan komponen hanya karena tidak tampak pada abstrak.

## V11 — Knowledge store

**Selesai untuk draf: protokol rancangan ditulis di catatan pribadi.** Store berasal dari data development, dibekukan sebelum test, dan tidak menerima patch maupun hasil serangan dari data test. Entri memuat asal, hash, versi alat, dan bukti uji fungsi/keamanan. Retrieval diperlakukan sebagai data tidak tepercaya. Bab 2 menjelaskan konsep retrieval dan risiko kebocoran tanpa mengklaim store telah diterapkan atau terbukti aman.

## V12 — Testing LLM dan pengujian dinamis

**Selesai untuk draf: peran dan status hasil dipisahkan.** LLM mengusulkan harness; program menjalankan pengujian. Tidak-teruji, gagal lingkungan, dan lulus merupakan keadaan berbeda. Catatan pribadi membatasi sumber daya serta lingkungan. Bab 2 menggunakan CodeSecEval sebagai contoh pengujian fungsi/keamanan dan QASecClaw sebagai contoh jalur dinamis yang tidak dijalankan. Pengujian GCC/CodeQL/KLEE Sriram dkk. tetap dibatasi pada program C/C++ pendek; tidak dipindahkan langsung ke Python.

[Sriram dkk., bagian 4–6](https://arxiv.org/pdf/2601.00509v1), [CodeSecEval](https://arxiv.org/pdf/2407.02395v3), [QASecClaw](https://arxiv.org/pdf/2605.01885).

## V13 — Model ancaman

**Selesai untuk draf: akses penyerang ditentukan sebagai rencana eksperimen.** Kondisi utama hanya mengubah komentar dan mempertahankan perintah program. Aturan arbiter, prompt sistem, keluaran alat, dan store tidak dapat diubah penyerang dalam kondisi ini. Docstring dan sumber lain menjadi kondisi terpisah jika ditambahkan. Draf menautkan pembedaan instruksi dan data tidak tepercaya ke sumber primer Greshake serta Liu. Kesimpulan tidak diperluas menjadi ketahanan semua vektor.

[Greshake dkk.](https://arxiv.org/abs/2302.12173), [Liu dkk.](https://www.usenix.org/conference/usenixsecurity24/presentation/liu-yupei).

## V14 — Sanitizer dan semantik Python

**Selesai: klaim mempertahankan semantik dibatasi oleh dokumentasi primer.** `function.__doc__` dapat diakses saat runtime; karena itu, penghapusan docstring tidak selalu mempertahankan perilaku. Sanitizer versi awal pada catatan pribadi hanya membuat tampilan komentar untuk reviewer. Kode asli untuk SAST/eksekusi tetap sama, string/docstring dipertahankan, dan pemetaan baris disimpan. Kegagalan tokenisasi menjadi kegagalan proses, bukan hasil aman.

Thornton melaporkan efek komentar serangan tidak signifikan pada pengujian berpasangan dan penghapusan komentar dapat menurunkan deteksi pada model lebih lemah. Draf karena itu tidak mengklaim sanitizer pasti efektif. Ablasi bersih/diserang dan pengukuran kehilangan deteksi berada pada rancangan eksperimen, belum merupakan hasil.

[Dokumentasi Python 3.11 tentang fungsi](https://docs.python.org/3.11/reference/datamodel.html#user-defined-functions), [tokenize](https://docs.python.org/3.11/library/tokenize.html), [Thornton](https://arxiv.org/pdf/2602.16741).

## V15 — Label acuan dan metrik

**Selesai untuk draf: penyebut dan protokol ditulis di catatan pribadi.** Label akhir dipisahkan dari keputusan alat di dalam gate; contoh rentan dan tidak rentan diperlukan. Precision/recall/F1 per CWE disertai TP/FP/TN/FN. Tingkat rentan lolos memakai seluruh kasus rentan yang dinilai. ASR bersyarat memakai pasangan rentan yang semula ditahan sebagai penyebut. Kegagalan API, block, tidak-teruji, token, serta latensi dicatat. Patch harus menutup kelemahan acuan dan menjaga fungsi. Penyebut nol dilaporkan tidak terdefinisi. Tidak ada angka efektivitas gate yang diisi sebelum eksperimen.

## V16 — Metadata dan sitasi

**Selesai: sitasi native dan bibliografi dipasang.** Placeholder penulis-tahun diganti `cite` Typst. `references.bib` berisi sumber yang benar-benar dikutip dengan dasar gaya APA yang digunakan template. Adaptasi CSL membedakan label penulis-tahun yang sama memakai akhiran tahun agar nama lengkap pada bibliografi tetap tampil pada Typst 0.15.0. PDF Bab 2 mandiri juga memiliki daftar pustaka. Entri contoh bibliografi template yang tidak dipakai diganti.

ReasonVul cocok dengan DOI `10.1145/3808197`, Proceedings of the ACM on Software Engineering 3 (FSE), 4323–4346, publikasi 30 Juni 2026. LLMLOOP cocok dengan DOI `10.1109/ICSME64153.2025.00109`, halaman 930–934, publikasi konferensi 7 September 2025; sitasi diperbaiki menjadi 2025. CodeAgent mengikuti judul final EMNLP dan nama Xunzhu Tang. Nama AutoSafeCoder mengikuti halaman pertama PDF v1, dengan perbedaan metadata arXiv dicatat.

[Metadata DOI ReasonVul](https://api.crossref.org/works/10.1145/3808197), [metadata DOI LLMLOOP](https://api.crossref.org/works/10.1109/ICSME64153.2025.00109), [CodeAgent pada prosiding ACL](https://aclanthology.org/2024.emnlp-main.632/), [metadata terpakai](bab2-metadata-terverifikasi.json).

## V17 — Teori dan batas penyelesaian naskah

**Selesai untuk lingkup Bab 2.** Definisi inti berada pada bagian yang sesuai, tanpa subbab 2.0 tambahan. Tidak ada klaim kemampuan LangGraph atau uraian OWASP/CVE yang diperluas tanpa sumber. Sumber tambahan dokumentasi Python sudah diperiksa. Bab 2 tidak memuat bagian 2.6 atau penanda pekerjaan verifikasi.

Judul, NIP, dan isi bab lain dari template bukan klaim penelitian Bab 2 dan tidak diisi dengan data yang tidak diberikan. Perubahan ini menyelesaikan pemeriksaan draf pustaka, bukan finalisasi keseluruhan skripsi. Tindak lanjut implementasi dan eksperimen tercatat sebagai rancangan pribadi, bukan penanda literatur yang dibiarkan terbuka.
