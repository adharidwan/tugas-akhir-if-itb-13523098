# Catatan Pribadi: Perbandingan dan Posisi Penelitian

Dipindahkan dari subbab 2.6 pada 20 Oktober 2026. Dokumen ini merupakan bahan kerja pribadi dan tidak dimasukkan ke PDF Bab 2.

## Perbandingan penelitian terdahulu

| Studi | Pendekatan | Dataset / objek | Hasil utama | Keterbatasan |
|---|---|---|---|---|
| AutoSafeCoder; Nunez dkk. (2024) | Coding, reviewer LLM, fuzzing; iteratif | SecurityEval; HumanEval; GPT-4o | Kode rentan 59/121 menjadi 44/121; pass@1 sedikit turun | Reviewer statis berbasis LLM; Bandit sebagai penilai eksperimen. Ketahanan reviewer belum menjadi evaluasi utama. |
| Teaming-Up LLMs; Sabir dkk. (2026) | Beberapa model, CodeQL, pemeriksaan dan perbaikan kode | SecLLMEval dan SecLLMHolmes; C/Python | Hibrida dilaporkan lebih konsisten dari kolaborasi LLM saja | Sudah mencakup pembuatan sampai perbaikan kode. Hasil model besar dan model lebih kecil dipisahkan; angka lintas-konfigurasi tidak digabung. |
| ReasonVul; Peng dkk. (2026) | Tiga gaya penalaran dan debat | PrimeVul; JITVUL; model berbeda | 389/542 konflik diselesaikan benar pada analisis PrimeVul | Berfokus pada deteksi kode rentan dan perbaikannya; belum menilai keputusan penerimaan kode oleh gate. |
| VulTrial; Widyasari dkk. (2025) | Pembagian peran seperti ruang sidang | Benchmark deteksi; antara lain GPT-4o | Perbaikan deteksi pada konfigurasi penulis | Tugas hakim dan juri perlu dibandingkan dengan aturan pass/revise/block pada gate. |
| MAVUL; Y. Li dkk. (2025) | Pemeriksaan konteks kode dan diskusi antaragen | Dataset kerentanan berpasangan | Peningkatan dilaporkan; angka rinci tidak dikutip | Metode dan kode evaluasi diperiksa: agen evaluasi memakai ground truth. Perannya berbeda dari arbiter saat penggunaan gate. |
| QASecClaw; Ameen dkk. (2026) | Semgrep, penyaringan LLM, penggabungan bukti | OWASP v1.2; 2.740 kasus Java; Qwen 3.5 Plus | False positive 560 menjadi 64 | Recall ikut turun. Pengujian dinamis tidak dijalankan dalam percobaan; fokus pada penyaringan temuan. |
| SAST-Genius; Agrawal dan Ahi (2025) | Semgrep dan analisis LLM | 25 repositori Python/Java/JavaScript; Semgrep 1.97.0; Llama 3 8B fine-tuned | FP 225 menjadi 20 pada laporan penulis | Data pelatihan mencakup data proprietary. Angka campuran bahasa bukan hasil replikasi pada Python. |
| ZeroFalse; Iranmanesh dkk. (2025) | Jejak aliran data dan prompt khusus CWE | OWASP Java Benchmark; OpenVuln | Keseimbangan presisi--recall dilaporkan membaik | Memeriksa peringatan pada kode yang sudah ada; perlu diuji kembali pada kode Python hasil LLM. |
| IRIS; Z. Li dkk. (2025) | LLM membantu pelacakan data dalam CodeQL | 120 kerentanan CWE-Bench-Java; GPT-4 | 55 terdeteksi dibanding 27 pada CodeQL | Menggunakan proyek Java; hasilnya belum tentu sama pada potongan kode Python hasil LLM. |
| FDSP; Alrashedy dkk. (2024) | Umpan balik Bandit untuk patching | PythonSecurity Eval; kode Python hasil LLM | Umpan balik eksternal mendukung perbaikan | Belum membuktikan manfaat model perbaikan yang berbeda; hasil perbaikan perlu diuji kembali. |
| RAG + Multi-Tool; Sriram dkk. (2026) | Retrieval, GCC, CodeQL, KLEE | 3.242 program C/C++; dua model | Pada CodeLlama-7B, cacat keamanan 58,55% menjadi 22,19% | Model memperbaiki kode C/C++ pendek; cara pengujiannya perlu disesuaikan untuk Python. |
| Maloyan dan Namiot (2025) | Prompt injection pada penilai LLM | Beberapa tugas penilaian | Penilaian model dapat dipengaruhi oleh serangan | Tugas penilaian berbeda dari pemeriksaan keamanan kode; hasilnya tidak dapat langsung disamakan. |
| Thornton (2026) | Serangan komentar dan evaluasi pertahanan | 100 sampel rentan; tiga bahasa; delapan model | Pengaruh komentar tidak signifikan pada percobaan berpasangan | Penghapusan komentar dapat menurunkan deteksi. Sampel rentan saja belum cukup untuk menilai false positive. |
| CodeSecEval / SecAwareCoder; J. Wang dkk. (2026) | Pengenalan ancaman dan hasil pengujian kode | v3: 255 tugas Python; 77 CWE | Versi baru menambah dataset dan cara pembuatan kode | Metode dan data primer diperiksa. Dataset dirilis; kode SecAwareCoder dinyatakan belum dirilis per 20 Oktober 2026. Tidak dianggap telah direplikasi. |

## Posisi penelitian

AutoSafeCoder, Multi-LLMSecCodeEval, dan AutoPatch sudah menghubungkan pembuatan, pemeriksaan, atau perbaikan kode. QASecClaw menggabungkan SAST dengan triase LLM. ReasonVul, VulTrial, dan Refute-or-Promote sudah membahas cara menyelesaikan perbedaan pendapat. SecAwareCoder juga menggabungkan pemodelan ancaman dan hasil eksekusi. Karena itu, keberadaan banyak agen, loop perbaikan, atau arbiter saja tidak cukup untuk disebut sebagai kebaruan.

Arah yang diusulkan adalah menguji keputusan gate pada kode Python hasil LLM, termasuk kemungkinan kode rentan diterima, perubahan setelah patch, dan pengaruh komentar serangan. Rancangan berikut merupakan bahan Bab 3. Belum ada implementasi gate, percobaan model, atau hasil efektivitas yang dinyatakan selesai dalam catatan ini.

## Keputusan rancangan awal

### Data dan ruang lingkup

Gunakan snapshot SecurityEval `6f4fb70f782c6d47b02ea24341e8ef8c1eb04a6a` dan LLMSecEval `39e97f046dbb2c4c604d31b86f2a4d3d27827388`. Awali studi kelayakan pada lima CWE: 22 (path traversal), 78 (OS command injection), 89 (SQL injection), 502 (deserialization), dan 798 (hard-coded credentials). Ini pilihan rancangan awal, bukan klaim semua sampelnya sudah dapat dijalankan atau didukung lengkap oleh aturan alat.

Kunci sampel menggunakan nama dataset, commit, dan ID/nomor baris. Pada LLMSecEval, simpan `Filename` bersama `Prompt ID`; dua tabrakan ID tidak dihapus otomatis. Catat hash prompt serta kode. Pisahkan baris yang berulang persis dari tugas yang hanya mirip. Pembagian development/test dilakukan sebelum retrieval dibentuk. Jika asal tugas beririsan, kelompokkan asal yang sama ke split yang sama agar tidak bocor.

Hitungan dasar dan dua tabrakan ID dapat dihitung ulang dengan `python scripts/audit_bab2_datasets.py`. Laporan ada pada [snapshot dataset](../reference/bab2-snapshot-dataset.json). Audit tersebut hanya membaca data, tidak menjalankan kode atau membenarkan label kerentanan secara manual.

### Alur dan kewenangan agen

Generator membuat kode. Sanitizer membuat tampilan masukan khusus reviewer. Analyse menjalankan Semgrep dan Bandit serta mencatat aturan, CWE, severity, lokasi, dan hash kode. Triage memberi penilaian beserta bukti; Testing menyusun usulan pengujian. Program non-LLM menjalankan pengujian dalam lingkungan terisolasi. Validation memeriksa kelengkapan bukti. Arbiter non-LLM menentukan keputusan, dan Fixer menyiapkan revisi jika diperlukan.

Triage tidak berwenang menghapus temuan SAST berkeparahan tinggi dari keputusan akhir. Penutupan temuan memerlukan pemeriksaan ulang pada versi kode terbaru serta alasan yang tercatat. Temuan serupa digabung tanpa menghilangkan identitas aturan sumber. Keluaran JSON agen harus memenuhi skema. Kebijakan YAML diberi nomor versi dan divalidasi sebelum dipakai. Format YAML merupakan pilihan implementasi, bukan kontribusi ilmiah.

### Aturan pass, revise, dan block

- **Pass:** semua pemeriksaan wajib selesai dan tidak ada temuan yang menurut kebijakan masih menghalangi penerimaan. Label Verified hanya berarti lulus pemeriksaan yang tercatat.
- **Revise:** masih ada temuan yang dapat diperbaiki dan kesempatan revisi tersedia. Patch kembali menjalani seluruh pemeriksaan pada hash kode baru.
- **Block:** batas revisi habis, bukti penting bertentangan, respons tidak valid, parsing gagal, layanan gagal setelah satu pengulangan, atau pemeriksaan wajib tidak dapat dijalankan. Block diteruskan untuk tinjauan manusia; tidak otomatis berarti kode terbukti rentan.

Batas awal adalah **dua ronde perbaikan** setelah keluaran pertama. Kode identik dengan versi sebelumnya atau kembali ke hash yang pernah diperiksa menghentikan loop. Dua ronde merupakan batas anggaran awal, bukan hasil optimasi. Pengujian yang tidak berjalan berstatus **tidak teruji**, bukan lulus. Severity alat dinormalisasi dengan tabel yang mencatat nilai asal; severity tidak otomatis ditentukan hanya dari nomor CWE.

### Model dan biaya

Identitas generator, reviewer, dan Fixer diperlakukan sebagai parameter konfigurasi eksperimen. Setiap hasil wajib mencatat ID model yang benar-benar dipanggil, penyedia, tanggal, parameter sampling, seed bila tersedia, batas token, versi prompt, dan batas ronde. Nama produk tanpa ID backend tidak cukup untuk replikasi. Catatan ini tidak mengasumsikan akses model berbayar yang belum dijalankan.

Pembandingan utama menggunakan generator yang sama dan reviewer yang tetap untuk semua kondisi. Fixer berbeda diuji sebagai kondisi tambahan; keluarga model dan ukurannya dicatat terpisah agar manfaat keluarga berbeda tidak tertukar dengan kapasitas. Gunakan tugas dan batas ronde sama, laporkan token serta latensi aktual, dan jelaskan jika anggarannya berbeda. Fokus utama adalah ketepatan keputusan gate dan ketahanannya; remediasi dinilai sebagai keluaran tambahan.

### Knowledge store

Knowledge store dibentuk dari data development saja dan dibekukan sebelum pengujian akhir. Tidak ada pembelajaran daring dari sampel test. Patch hanya masuk setelah pengujian fungsi dan keamanan yang ditentukan selesai, dengan ID asal, hash kode, hasil uji, versi alat, dan waktu pemeriksaan. Kasus gagal, kasus diserang, dan patch sampel test tidak menjadi contoh retrieval. Informasi retrieval diperlakukan sebagai data yang tidak boleh mengubah instruksi sistem atau kebijakan arbiter.

### Testing dan sanitizer

Testing LLM hanya mengusulkan harness serta masukan. Eksekusi, batas waktu, dan pencatatan hasil dilakukan program. Lingkungan tidak membawa kredensial dan akses jaringan dinonaktifkan secara bawaan. Sampel yang memerlukan lingkungan khusus dicatat terpisah; keluarnya sampel harus memiliki alasan. Crash bukan ukuran semua CWE, dan ketiadaan crash tidak membuktikan keamanan. Pengujian fungsi tidak boleh hanya mengikuti perubahan perilaku yang dibuat Fixer.

Sanitizer tidak mengubah artefak yang dijalankan. Versi awal hanya mengolah token komentar menjadi tampilan untuk reviewer sambil menyimpan pemetaan baris. String program dan docstring dipertahankan karena dapat dipakai saat runtime; dokumentasi Python tentang `__doc__` mendukung pembatasan ini. Periksa kesamaan hash kode asli sebelum dan sesudah proses; untuk tampilan reviewer, catat token yang dihilangkan. Jika pembacaan token gagal, hentikan kondisi tersebut dan catat kegagalan. Manfaatnya tetap harus diuji karena Thornton menemukan penghapusan komentar dapat merugikan deteksi.

### Model ancaman dan ablasi

Serangan utama hanya menyisipkan atau mengubah komentar; penyerang tidak mengubah perintah program, aturan YAML, prompt sistem, keluaran alat, atau knowledge store. Docstring dan keluaran alat ditempatkan sebagai perluasan terpisah jika nanti diuji. Pasangan bersih/diserang harus memiliki struktur program yang sama setelah komentar diabaikan, dan tetap memiliki perilaku rentan yang sama pada pengujian acuan.

Bandingkan LLM tunggal, SAST saja, SAST dengan satu reviewer, serta gate lengkap. Untuk gate lengkap, lakukan ablasi tanpa sanitizer, tanpa triase, dan Fixer sama/berbeda. Terapkan tugas, versi model, serta anggaran yang sebanding. Laporkan juga kegagalan API dan parsing; jangan membuangnya diam-diam dari penyebut.

### Label acuan dan metrik

Label akhir diperiksa terpisah dari alat dalam gate, dengan penjelasan manual dan pengujian keamanan yang sesuai kasus. Label CWE tugas, peringatan SAST, dan bukti eksploitasi disimpan sebagai hal berbeda. Gunakan contoh rentan dan tidak rentan. Contoh perbaikan tidak otomatis aman hanya karena berasal dari dataset; periksa kembali label dan fungsi yang diharapkan.

- Deteksi: precision, recall, dan F1 per CWE beserta jumlah TP/FP/TN/FN. Jika penyebut nol, laporkan tidak terdefinisi, bukan membuat nilai sempurna.
- Kode rentan lolos: jumlah kode rentan yang memperoleh pass dibagi seluruh kode rentan yang dinilai. Laporkan juga cakupan dan jumlah block.
- ASR bersyarat: jumlah pasangan yang semula menahan kode rentan tetapi memberikan pass setelah serangan, dibagi pasangan kode rentan yang semula ditahan. ASR tidak terdefinisi bila tidak ada pasangan yang semula ditahan. Laporkan jumlah rentan yang sudah lolos pada kondisi bersih secara terpisah.
- Patch berhasil: revisi menutup kelemahan acuan dan tetap lulus uji fungsi; bagi dengan seluruh kasus yang masuk remediasi, termasuk kegagalan. Catat regresi keamanan serta fungsi secara terpisah.
- Biaya: total token seluruh panggilan, waktu dinding, jumlah panggilan, kegagalan, dan ronde. Waktu agen paralel tidak dijumlahkan seolah semuanya waktu tunggu pengguna.

Gunakan pasangan sampel yang sama untuk kondisi yang dibandingkan. Laporkan jumlah kasus dan ketidakpastian hasil, termasuk ketika sanitizer atau Fixer berbeda tidak membantu. Rancangan ini belum menghasilkan angka efektivitas gate.

## Bahan penelusuran

Identitas sumber, versi, dan tautan primer tersedia pada [katalog sumber](../reference/bab2-daftar-pustaka-kandidat.md). Penyelesaian seluruh penanda draf dijelaskan satu per satu pada [log pemeriksaan](../reference/bab2-verifikasi.md). Penelusuran dibatasi pada sumber yang berkaitan dengan brief, bukan systematic literature review seluruh bidang.
