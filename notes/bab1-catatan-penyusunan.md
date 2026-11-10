# Catatan Penyusunan Bab I

Tanggal penyusunan: **10 November 2026**. Catatan ini mendampingi [Bab I Pendahuluan](../chapters/01-pendahuluan.typ) dan [PDF khusus Bab I](../output/pdf/bab-1-pendahuluan.pdf). Isi bab merupakan latar belakang dan rencana penelitian; tidak menyatakan implementasi atau eksperimen TA telah selesai.

## Dasar penyusunan

- Judul mengikuti `main.typ`: *Perancangan dan Implementasi Multi-Agent Security Gate dengan Evidence-Based Arbiter untuk Verifikasi Keamanan Kode Hasil Large Language Model*.
- Struktur mempertahankan enam bagian template, yaitu I.1 Latar Belakang sampai I.6 Sistematika Pembahasan. Gaya diambil dari pola penjelasan dan struktur Bab I contoh 13522039, dengan isi ditulis untuk topik TA ini.
- Rancangan mengacu pada catatan Bab 2 dan komparasi pribadi yang tersedia di workspace. Perubahan yang sudah ada pada kedua catatan tersebut tidak disunting dalam penyusunan Bab I.
- Evidence-Based Arbiter merupakan nama deskriptif komponen. Kontribusi yang diusulkan berupa kebijakan penerimaan dan evaluasinya ketika bukti tidak lengkap atau bertentangan, setelah patch, serta ketika reviewer menerima komentar manipulatif. Banyaknya agen, format YAML, dan penggunaan bukti sendiri tidak diklaim sebagai kebaruan.

## Penyesuaian gaya terhadap acuan Edbert

Pada 10 November 2026, Bab I dibandingkan kembali dengan Bab I Edbert Eddyson Gunawan (13522039), halaman tercetak 1–5 atau halaman PDF 14–18 pada berkas lokal `13522039-Edbert Eddyson Gunawan.pdf`. Perbandingan membaca seluruh bagian latar belakang sampai sistematika pembahasan. Acuan digunakan untuk alur penjelasan dan bentuk penyajian; isi, data, dan rujukan topik Edbert tidak dipindahkan ke naskah TA ini.

| Aspek | Pola pada tulisan Edbert | Penyesuaian pada Bab I TA ini |
|---|---|---|
| Latar belakang | Masalah umum diperkenalkan, pendekatan yang tersedia dijelaskan, lalu perhatian dipersempit ke persoalan yang dipilih dan usulan sistem. | Enam paragraf mengalir dari risiko kode LLM, pemeriksaan dan multi-agen, persoalan keputusan serta bukti, manipulasi reviewer, hingga usulan gate. |
| Rumusan masalah | Tiga pertanyaan pendek dengan fokus arsitektur, dukungan mekanisme, dan kinerja. | Tiga pertanyaan dipersingkat dengan tetap mempertahankan fokus rancangan, ketepatan keputusan dan patch, serta pengaruh sanitizer/arbiter terhadap ketahanan. |
| Tujuan | Satu paragraf yang menjelaskan hasil sistem dan hubungannya dengan persoalan penelitian. | Tiga tujuan dalam daftar diubah menjadi satu paragraf yang mencakup ketiga rumusan masalah. |
| Batasan masalah | Daftar singkat yang menegaskan ruang lingkup utama. | Daftar dipadatkan menjadi lima poin. Batas Python, lima CWE, model yang tersedia, alat, lingkungan uji, dua ronde patch, serangan komentar, dan pemisahan data tetap dijelaskan. |
| Metodologi | Empat tahap dengan nama dan uraian singkat. | Tahap disusun menjadi studi literatur/perancangan, penyiapan data/skenario, implementasi, serta pengujian/analisis. Tidak menyatakan tahapan implementasi atau pengujian sudah selesai. |
| Sistematika | Uraian pendek per bab dalam bentuk paragraf. | Penjelasan tiap bab ditulis sebagai prosa singkat tanpa mengulang daftar metrik atau rincian rancangan. |

Draf sebelum penyesuaian sekitar 1.600 kata dan sesudahnya sekitar 1.070 kata berdasarkan pemisahan kata pada sumber Typst, termasuk judul dan penanda sitasi. Ukuran ini dipakai untuk meninjau keringkasan, bukan sebagai target panjang yang harus sama dengan dokumen acuan.

Rincian protokol yang diringkas dari prosa Bab I tetap menjadi bahan perancangan dan evaluasi:

- Bekukan versi dataset, knowledge store, kebijakan, dan konfigurasi sebelum pengujian akhir. Catat identitas model, parameter panggilan, versi prompt, alat, serta aturan yang dipakai. Label acuan diperiksa secara terpisah dari alat di dalam gate dan sampel yang dikeluarkan memiliki alasan.
- Pertahankan generator yang sama. Samakan batas revisi pada kondisi yang mendukung perbaikan, lalu catat perbedaan anggaran, token, dan waktu aktual. Baseline generator tanpa gate menilai keluaran awal; tidak dianggap telah menerima bukti perbaikan yang sama.
- Ganti penentu keputusan arbiter dengan reviewer untuk kondisi pembanding tanpa arbiter, sambil mempertahankan bukti alat lainnya. Kasus timeout, respons tidak valid, dan pengujian tidak berjalan tetap dicatat. Block karena gagal pemeriksaan bukan label rentan.
- Laporkan unsafe pass, benign pass, precision/recall/F1, pass/revise/block, cakupan, serta keberhasilan patch yang menjaga fungsi dan tidak menambah kelemahan acuan. ASR bersyarat menghitung perubahan menjadi pass pada kode rentan yang semula ditahan; penyebut nol dilaporkan tidak terdefinisi. Hasil pada kode tanpa serangan tetap dilaporkan untuk melihat kehilangan kemampuan deteksi.

## Hubungan rumusan masalah, tujuan, dan evaluasi

| Rumusan masalah | Tujuan | Bukti evaluasi yang direncanakan |
|---|---|---|
| RM1: rancangan dan implementasi gate dengan tindak lanjut atas bukti tidak lengkap/bertentangan | Implementasi komponen, kebijakan, dan pencatatan keputusan | Skenario bukti bertentangan, temuan belum ditutup, respons tidak valid, pengujian tidak berjalan, serta kesesuaian hash kode dengan bukti. |
| RM2: ketepatan keputusan dan hasil perbaikan dibanding pembanding | Pengukuran penerimaan, deteksi, patch, dan biaya | Unsafe pass rate, benign pass rate, jumlah pass/revise/block dan tidak-teruji, precision/recall/F1, patch berhasil, regresi, token, dan waktu. |
| RM3: pengaruh sanitizer dan aturan arbiter terhadap ketahanan serta deteksi | Evaluasi berpasangan dengan komponen diaktifkan/dinonaktifkan | Kode rentan yang semula ditahan lalu menjadi pass setelah serangan; hasil pada kode bersih tetap dilaporkan. Kondisi tanpa arbiter mengganti penentu keputusan dengan reviewer sambil mempertahankan alat dan bukti lainnya. |

Pembanding yang direncanakan adalah generator tanpa gate, SAST saja, SAST dengan satu reviewer, dan gate lengkap. Tugas, generator, serta kesempatan revisi dipertahankan pada kondisi yang relevan. Pembandingan ini merupakan adaptasi kondisi eksperimen TA, bukan klaim replikasi penuh paper pembanding.

## Batas rancangan yang dipakai

- Python, tugas SecurityEval dan LLMSecEval, serta fokus awal CWE-22/78/89/502/798 mengikuti catatan rancangan yang sudah ada. Ini batas awal eksperimen, bukan klaim seluruh sampel sudah dapat dijalankan atau labelnya telah divalidasi manual.
- Pemilihan sampel dijelaskan lewat kelengkapan label, dukungan alat/pengujian, dan catatan eksklusi. ID bertabrakan tidak otomatis dianggap sebagai tugas yang sama; lihat [audit dataset](../reference/bab2-snapshot-dataset.json).
- Batas awal remediasi dua ronde; model dan aturan alat menjadi konfigurasi yang wajib dicatat. Tidak ada klaim model berbayar telah diakses atau pasangan model telah dioptimalkan.
- Serangan utama mengubah komentar sambil mempertahankan program. Sanitizer menghasilkan tampilan reviewer; artefak eksekusi tidak berubah. Pengujian wajib yang tidak berjalan tidak diperlakukan sebagai lulus.
- Knowledge store, jika digunakan, berasal dari development dan dibekukan sebelum test. Tidak ada retrieval jawaban sampel test untuk sampel yang sama.
- Penurunan unsafe pass harus disertai benign pass, block, cakupan, dan biaya agar sistem yang menahan semua kode tidak dianggap otomatis lebih baik. Block akibat kegagalan pemeriksaan bukan label kerentanan.

## Pemeriksaan sumber primer

Sumber berikut dibaca kembali pada 10 November 2026 untuk klaim yang dipakai dalam latar belakang. Hasil paper merupakan laporan penulis, bukan hasil replikasi TA.

| Sumber | Klaim yang dipakai dan batasnya |
|---|---|
| [CyberSecEval v1, abstrak dan bagian 1.2](https://arxiv.org/html/2312.04724v1) | Rata-rata sekitar 30% saran rentan pada benchmark dan model studi tersebut; bukan seluruh penggunaan LLM. |
| [QASecClaw v1, bagian V dan Tabel III](https://arxiv.org/html/2605.01885v1) | Penurunan false positive disertai kehilangan sebagian temuan benar; tidak disamakan dengan keamanan seluruh kode hasil generasi. |
| [AutoSafeCoder v1, bagian 3](https://arxiv.org/html/2409.10737v1) | Alur Coding, reviewer, dan fuzzing dengan perbaikan berulang sudah ada. Klaim abstrak tentang tidak berkurangnya fungsi tidak dipakai. |
| [Multi-LLMSecCodeEval v1, abstrak dan metode](https://arxiv.org/html/2603.22717v1) | Generasi, deteksi, dan patching sudah diteliti; angka dari konfigurasi berbeda tidak digabung. |
| [Refute-or-Promote v1, abstrak dan kasus kegagalan](https://arxiv.org/html/2604.19049v1) | Bukti pengujian dapat membantah kesepakatan reviewer. Syarat bukti bukan kebaruan tersendiri. |
| [Beyond QASecClaw v1, abstrak, bagian III dan VI](https://arxiv.org/html/2610.36947v1) | Hasil pengaturan Java yang diuji menekankan kesesuaian bukti dan keterbatasan konteks tambahan. Ini studi eksploratif dengan kontrol khusus; tidak membuktikan semua arsitektur multi-agen tidak bermanfaat. |
| [Thornton, abstrak dan bagian 5–6](https://arxiv.org/html/2602.16741) | Efek agregat komentar tidak signifikan pada pengujian berpasangan; penghapusan komentar dapat merugikan model lebih lemah. Efektivitas sanitizer tetap pertanyaan eksperimen. |

Beyond QASecClaw pertama kali diunggah pada 27 Oktober 2026 dan dipakai sebagai preprint v1. Metadata pada [rekaman arXiv](https://arxiv.org/abs/2610.36947v1): S M Abdulla Al Mamun, Akif Islam, dan Mohd. Ruhul Ameen; judul *Beyond QASecClaw: Agent Scaling, Verifier Feedback, and Evidence Reliability in Software Assurance*. Entri baru memakai kunci `almamun2026beyond` dalam bibliografi bersama. Sumber lain menggunakan kunci yang sudah ada.

## Keadaan naskah

Bab I menggantikan teks petunjuk template. Judul, identitas, dan Bab II dipertahankan. Bab III–V dan abstrak masih memerlukan pengerjaan tersendiri. Angka efektivitas TA hanya dapat diisi setelah eksperimen dilakukan.
