# Daftar Verifikasi Draf Bab 2

Tanggal pemeriksaan: 19 Oktober 2026. Nomor V01–V15 menghubungkan tanda dalam prosa/tabel dengan pekerjaan penulis. V16–V17 mencatat pekerjaan bibliografi dan penyelesaian naskah. Status **terperiksa sebagian** berarti bukti tertentu telah diperiksa, sementara keputusan atau replikasi yang disebutkan masih terbuka.

## Koreksi yang sudah diterapkan

| Pokok | Hasil pemeriksaan primer | Dampak pada draf |
|---|---|---|
| AutoSafeCoder | PDF v1, bagian 3.2, 4.2, dan Tabel 1: Static Analyzer Agent adalah LLM; Bandit digunakan untuk penilaian eksperimen. Dengan GPT-4o, sampel rentan 59/121 menjadi 44/121; pass@1 HumanEval 0,9085 menjadi 0,8780. | Tidak menyamakan reviewer dengan alat SAST. Penurunan kerentanan dihitung sekitar 12,4 poin persentase dari jumlah sampel, bukan 13% relatif. Klaim tanpa penurunan fungsionalitas tidak dipakai. [Sumber](https://arxiv.org/pdf/2409.10737v1) |
| IRIS | PDF prosiding ICLR 2025, Tabel 1: pada CWE-Bench-Java, GPT-4 mendeteksi 55/120 dibanding 27/120 CodeQL; AvgFDR 84,82% dibanding 90,03%. | Memakai versi konferensi; tidak mengutip angka 69 dari versi lama. [Sumber](https://proceedings.iclr.cc/paper_files/paper/2025/file/582d4e27fa24168f3af1f4582655034b-Paper-Conference.pdf) |
| QASecClaw | Bagian III-C menyatakan jalur bukti dinamis tidak aktif pada OWASP Benchmark. Bagian implementasi menyebut Qwen 3.5 Plus. | Memisahkan arsitektur yang ditawarkan dari jalur yang diuji. Tidak menganggap seluruh temuan terbukti melalui exploit. [Sumber](https://arxiv.org/pdf/2605.01885) |
| Pertahanan komentar | Thornton melaporkan efek agregat komentar adversarial tidak signifikan pada pengujian berpasangan; comment stripping dapat merugikan model yang lebih lemah. | Sanitizer menjadi hipotesis yang diuji lewat ablasi, bukan pertahanan yang dijamin efektif. [Sumber](https://arxiv.org/pdf/2602.16741) |
| Jenis kode studi multi-tool | Sriram dkk., bagian 4–6: GCC, CodeQL, KLEE; tugas C/C++ pendek. | Tidak memindahkan perangkat uji atau angka perbaikan langsung ke Python. [Sumber](https://arxiv.org/pdf/2601.00509v1) |
| CodeSecEval | v2 2024 berbeda dari v3 September 2026, termasuk judul, penulis, jumlah tugas/CWE, dan penambahan SecAwareCoder. | Kedua versi dicatat terpisah; revisi baru diperlakukan sebagai pembanding yang perlu diaudit. [v2](https://arxiv.org/abs/2407.02395v2), [v3](https://arxiv.org/abs/2407.02395v3) |
| AutoPatch | Abstrak revisi membedakan F1 verifikasi dari accuracy patching. | Angka patching tidak disebut F1 dan tidak dipakai sebagai perbandingan langsung. [Sumber](https://arxiv.org/abs/2505.04195) |
| Kebaruan gerbang | Multi-LLMSecCodeEval mencakup generasi–deteksi–patching; Refute-or-Promote sudah membahas review dengan gerbang bertahap. | Tidak menyebut pipeline atau keberadaan gerbang sebagai kebaruan tersendiri. [Multi-LLMSecCodeEval](https://arxiv.org/abs/2603.22717), [Refute-or-Promote](https://arxiv.org/abs/2604.19049) |

## Pekerjaan yang masih harus diselesaikan

### [VERIFIKASI V01] Bekukan versi SecurityEval dan seleksi sampel

**Status: snapshot terhitung; subset eksperimen belum ditetapkan.** `dataset.jsonl` pada commit `6f4fb70f782c6d47b02ea24341e8ef8c1eb04a6a` berisi **121 baris JSON** dan **69 label CWE unik** berdasarkan awalan kolom `ID`. Penyebutan CWE dalam teks/kode tidak dihitung sebagai label tambahan. Angka 130/75 pada brief tidak dipakai sebagai ukuran snapshot ini.

Penulis perlu menetapkan versi eksperimen, kriteria inklusi, keterjalanan kode, dan label hasil generasi. Catat sampel yang dikeluarkan beserta alasannya. Hitungan ini belum merupakan validasi manual seluruh label.

[Berkas primer pada commit](https://github.com/s2e-lab/SecurityEval/blob/6f4fb70f782c6d47b02ea24341e8ef8c1eb04a6a/dataset.jsonl).

### [VERIFIKASI V02] Pilih CWE dan subset Python LLMSecEval

**Status: snapshot terhitung; pilihan CWE penelitian belum ditetapkan.** Pada commit `39e97f046dbb2c4c604d31b86f2a4d3d27827388`, `Dataset/LLMSecEval-Prompts_dataset.json` berisi **150 prompt**, **18 label CWE** berdasarkan `Prompt ID`, dan distribusi `Language` **67 C / 83 Python**. Subset berlabel Python mencakup **12 CWE**.

Irisan label Python dengan SecurityEval adalah CWE-20, 22, 78, 79, 89, 200, 306, 434, 502, 522, 732, dan 798. Ini bukan rekomendasi final seluruh kategori. Pilih lima sampai delapan kategori berdasarkan dukungan aturan, jumlah kasus, dan kelayakan pengujian; periksa duplikasi dan jangan menjumlahkan kedua dataset seolah semuanya sampel Python unik.

[Berkas primer pada commit](https://github.com/tuhh-softsec/LLMSecEval/blob/39e97f046dbb2c4c604d31b86f2a4d3d27827388/Dataset/LLMSecEval-Prompts_dataset.json).

### [VERIFIKASI V03] Rekonsiliasi 81 prompt studi tujuh LLM dengan 83 label Python

**Status: perbedaan ditemukan; penyebab belum ditentukan.** Morkonda dkk. bagian 3.2 dan Tabel 1 menyebut subset **81 prompt Python**. Snapshot resmi saat pemeriksaan memiliki **83** entri berlabel Python. Jangan menyimpulkan dua entri merupakan kesalahan atau duplikasi tanpa membandingkan ID, commit, dan aturan seleksi studi tersebut. Nama produk LLM tidak selalu mengidentifikasi versi model backend; keterbatasan ini juga perlu dicatat bila mereplikasi.

### [VERIFIKASI V04] Audit CodeSecEval / SecAwareCoder dan ketersediaan pengujian

**Status: metadata/abstrak kedua versi diperiksa; artefak dan isi lengkap revisi belum diaudit.** v2 melaporkan 180 sampel/44 jenis kerentanan; v3 melaporkan 255 tugas Python/77 CWE dan memperkenalkan SecAwareCoder. Baca metode, uji fungsional serta keamanan, pemodelan ancaman, komponen agen, dan evaluasi ketahanannya. Periksa repositori, lisensi, serta kontaminasi dengan dua dataset utama. Jangan memakai hitungan v2 sambil menyitir judul atau hasil v3.

### [VERIFIKASI V05] Rekonsiliasi hasil Multi-LLMSecCodeEval

**Status: metode dan bagian hasil dibaca; angka rinci ditahan.** Periksa kembali konfigurasi P10, teks hasil/Fig. 8, Tabel 4, serta penamaan SecLLMHolmes/SecHolmesEval. Persentase secure pada satu bagian tidak langsung menjadi komplemen angka insecure pada bagian lain tanpa memastikan model dan konfigurasi sama. Bedakan peningkatan relatif, selisih poin persentase, dan rata-rata lintas-model. Periksa pula bagaimana CodeQL yang digunakan dalam pipeline berhubungan dengan penilaian akhirnya. Draf hanya memakai kesimpulan kualitatif yang sesuai cakupan sumber.

### [VERIFIKASI V06] Audit angka dan konfigurasi SAST-Genius

**Status: teks primer ditemukan; rincian evaluasi belum teridentifikasi memadai.** Angka false positive 225 menjadi 20 tetap berstatus laporan penulis, bukan hasil yang telah direplikasi; angka ini tidak digunakan dalam prosa atau tabel Bab 2. Identifikasi dataset, jumlah sampel, konfigurasi/model LLM, aturan Semgrep, label acuan, pemisahan train/test, dan satuan waktu triase sebelum memakai hasil numeriknya. Jika konteks ini tidak dapat dipastikan, pertahankan pembahasan kualitatif. Jangan memakai InfoWorld atau materi promosi untuk mengisi metadata eksperimen yang hilang.

### [VERIFIKASI V07] Tetapkan kebijakan arbiter dan tingkat keparahan

**Status: keputusan rancangan belum difinalkan.** Tentukan prioritas bukti SAST/dinamis/LLM, pemetaan severity ke aturan, kewenangan Triage, serta transisi pass/revise/block. Nyatakan tindakan ketika parsing gagal, API timeout, pengujian tidak berjalan, bukti bertentangan, atau anggaran habis. Temuan SAST tinggi tidak boleh dibatalkan oleh Triage sendiri menurut brief. Aturan YAML perlu memiliki versi, validasi skema, dan pencatatan alasan keputusan. Penggunaan YAML sendiri tidak dianggap kontribusi ilmiah.

### [VERIFIKASI V08] Selesaikan identitas kandidat yang belum terkonfirmasi

**Status: belum selesai; sumber tidak dipakai sebagai bukti dalam prosa.** Tindak lanjuti LLM4SA, studi Semgrep*, Du dkk. tentang debat, Greshake dkk. 2023, Liu dkk. 2024, Pearce dkk. tentang Copilot, Chen dkk. tentang Self-Debugging, Olausson dkk. tentang Self-Repair, serta judul parsial *Talk Isn't Always Cheap*, *More Rounds, More Noise*, dan *When Collaboration Fails*. Periksa juga identitas skripsi *Communicative agents for code security*. Sumber primer paket halusinasi USENIX 2025 diperlukan hanya bila agen dependensi ditambahkan.

MAVUL dan Your AI, My Shell sudah ditemukan pada sumber primer, sehingga keduanya tidak lagi bergantung pada EmergentMind. CodeSecEval juga sudah ditemukan pada arXiv. Lihat status masing-masing pada daftar pustaka kandidat. Jangan mengisi penulis/tahun/DOI kandidat lain melalui dugaan atau menyitir ringkasan sekunder sebagai hasil primer.

### [VERIFIKASI V09] Tentukan model, jumlah iterasi, dan fokus akhir

**Status: belum diputuskan.** Pilih generator, reviewer, dan Fixer; tetapkan apakah model berbeda berarti keluarga berbeda atau hanya ukuran/versi berbeda. Tentukan batas N, kriteria kemajuan, jumlah ronde perbaikan, anggaran token, serta fokus utama deteksi atau remediasi dan ketahanan. Rencana awal 1–2 ronde tidak ditulis sebagai hasil optimasi. Jika LangGraph dipilih, dokumentasikan versi dan mekanisme orkestrasi pada bab perancangan; draf Bab 2 belum memuat klaim kemampuan library yang tidak bersumber.

### [VERIFIKASI V10] Bandingkan artefak pembanding terdekat

**Status: pemeriksaan bervariasi antarstudi.** Audit kode dan protokol MAVUL, VulTrial, QASecClaw, AutoSafeCoder, Multi-LLMSecCodeEval, AutoPatch, Refute-or-Promote, dan revisi SecAwareCoder. Periksa fungsi hakim/evaluation agent, batas iterasi, keluaran keputusan, jalur dinamis, sanitasi masukan, dan pengujian serangan. Kata “belum dievaluasi” pada tabel berarti tidak tampak pada bagian yang ditinjau; bukan bukti ketiadaan di seluruh artefak. Penelusuran ini bukan systematic literature review menyeluruh.

### [VERIFIKASI V11] Definisikan knowledge store dan hindari kebocoran evaluasi

**Status: rancangan belum difinalkan.** Tetapkan bukti minimal agar Validation boleh menyimpan pola/patch, pemisahan data train/development/test, urutan eksperimen, dan perlakuan terhadap entri yang berasal dari kasus diserang. Tautkan setiap entri ke versi artefak serta hasil uji. Jangan memasukkan patch sampel uji ke retrieval untuk sampel uji yang sama tanpa protokol adaptasi yang eksplisit. Uji risiko instruksi manipulatif pada pengetahuan dan keluaran alat.

### [VERIFIKASI V12] Tetapkan peran Testing LLM dan kelayakan pengujian dinamis

**Status: belum diputuskan.** Bedakan pembuatan exploit/fuzz harness, eksekusi alat non-LLM, dan penafsiran hasil. Uji apakah cuplikan dapat dijalankan dalam sandbox dan apakah kebutuhan lingkungan dapat direpresentasikan. DAST aplikasi utuh tidak diasumsikan tersedia untuk semua fungsi/snippet. Crash tidak identik dengan setiap jenis kerentanan; ketiadaan crash atau timeout bukan bukti keamanan. Nyatakan cakupan uji, batas sumber daya, serta status tidak-teruji.

### [VERIFIKASI V13] Tetapkan model ancaman dan protokol serangan

**Status: rancangan eksperimen belum difinalkan.** Tentukan akses penyerang terhadap komentar, docstring, string, prompt, keluaran alat, serta knowledge store; pisahkan vektor-vektor tersebut. Aturan arbiter dan keluaran alat tidak otomatis boleh diubah penyerang. Pastikan pasangan bersih/diserang mempertahankan perilaku rentan yang sama. Definisikan keberhasilan manipulasi keputusan gate, bukan hanya perubahan teks jawaban reviewer. Agen dependensi/slopsquatting berada di luar cakupan saat ini.

### [VERIFIKASI V14] Validasi efek sanitizer pada semantik dan deteksi

**Status: hipotesis, belum diuji.** Tentukan apakah sanitizer menghasilkan proyeksi khusus reviewer atau mengubah artefak eksekusi. Docstring, string program, komentar penanda alat, serta pemetaan baris perlu ditangani secara sadar. Uji perubahan perilaku, kehilangan konteks, recall, false positive, dan penerimaan kode rentan. Ablasi harus memuat sampel bersih serta sampel diserang, dan memungkinkan hasil negatif. Jika uraian teori Python memerlukan rujukan tambahan, tandai `[SUMBER BARU, BELUM DIVERIFIKASI]` sampai dokumentasi primernya diperiksa.

### [VERIFIKASI V15] Tetapkan ground truth dan metrik gate

**Status: protokol belum difinalkan.** Siapkan contoh rentan dan tidak rentan agar precision/recall/F1 dapat diinterpretasikan. Pisahkan label CWE tugas, temuan alat, eksploitasi, dan label manual. Hindari penilaian akhir yang semata-mata mengulang alat di dalam gate. Laporkan ASR beserta penyebutnya, tingkat kode rentan yang lolos, keberhasilan revisi, regresi fungsional/keamanan, token, latensi, dan jumlah kegagalan. Bandingkan baseline dengan tugas serta anggaran sebanding; bedakan waktu paralel dari konsumsi total sumber daya.

### [VERIFIKASI V16] Cocokkan metadata publikasi dan format sitasi

**Status: metadata primer tersedia untuk 40 entri; beberapa rincian terbuka.** DOI ACM ReasonVul `10.1145/3808197` dari brief belum terkonfirmasi, sehingga tidak digunakan sebagai venue terverifikasi. Nama beberapa penulis pada metadata arXiv AutoSafeCoder berbeda bentuknya dari PDF v1; daftar kandidat memakai nama pada PDF. VulTrial memakai tahun versi preprint v2 2025. FDSP memakai revisi 2024, DevGPT jurnal 2026, dan WildCode revisi 2026. LLMLOOP diunggah ke arXiv 2026 tetapi metadata memuat DOI ICSME 2025; cocokkan publikasi final sebelum mengubah tahun sitasi. Putuskan APA/IEEE, lalu migrasikan placeholder ke sitasi Typst dan berkas bibliografi yang benar.

### [VERIFIKASI V17] Lengkapi sumber teori dan hapus sisa template saat finalisasi

**Status: pekerjaan naskah lanjutan.** Bagian 2.0 pada brief bersifat opsional dan tidak dimasukkan sebagai subbab tersendiri agar penomoran inti tetap 2.1–2.6. Jika definisi CWE/CVE, OWASP Top 10, SAST/DAST/fuzzing, agen, atau LangGraph diperluas, lengkapi sumber primer dan tandai sumber tambahan sesuai aturan brief. `references.bib`, bab lain, judul, dan metadata pengesahan masih memuat materi template yang tidak termasuk penyusunan Bab 2 ini. Jangan memperlakukan daftar pustaka template sebagai bibliografi Bab 2 yang telah valid.
