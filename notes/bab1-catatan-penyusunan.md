# Catatan Penyusunan Bab I

Tanggal penyusunan: **10 November 2026**. Catatan ini mendampingi [Bab I Pendahuluan](../chapters/01-pendahuluan.typ) dan [PDF khusus Bab I](../output/pdf/bab-1-pendahuluan.pdf). Isi bab merupakan latar belakang dan rencana penelitian; tidak menyatakan implementasi atau eksperimen TA telah selesai.

Pembaruan framing: **21 November 2026**, mengikuti empat pokok arahan pengguna untuk Bab I.

## Dasar penyusunan

- Judul mengikuti `main.typ`: *Perancangan dan Implementasi Multi-Agent Security Gate dengan Evidence-Based Arbiter untuk Verifikasi Keamanan Kode Hasil Large Language Model*.
- Struktur mempertahankan enam bagian template, yaitu I.1 Latar Belakang sampai I.6 Sistematika Pembahasan. Gaya diambil dari pola penjelasan dan struktur Bab I contoh 13522039, dengan isi ditulis untuk topik TA ini.
- Rancangan mengacu pada catatan Bab 2 dan komparasi pribadi yang tersedia di workspace. Perubahan yang sudah ada pada kedua catatan tersebut tidak disunting dalam penyusunan Bab I.
- Evidence-Based Arbiter merupakan nama deskriptif komponen. Kontribusi yang diusulkan berupa kebijakan penerimaan dan evaluasinya ketika bukti tidak lengkap atau bertentangan, setelah patch, serta ketika reviewer menerima komentar manipulatif. Banyaknya agen, format YAML, dan penggunaan bukti sendiri tidak diklaim sebagai kebaruan.

## Framing Bab I: empat pokok argumentasi

Latar belakang ditata sebagai satu alur: **penggunaan LLM untuk kode → risiko keamanan → pembagian peran pemeriksaan → guardrails → keputusan berbasis bukti**. Istilah *multi heads* pada arahan dipahami sebagai beberapa agen dengan peran atau sudut pemeriksaan berbeda. Rancangan tidak mensyaratkan setiap agen memakai model yang berbeda.

| Arahan | Argumentasi dalam Bab I | Hubungan dengan evaluasi |
|---|---|---|
| Current LLM usage for generating code → why it becomes a problem | Penggunaan AI mencakup generasi kode, debugging/refactoring, dan pengujian. Kode yang memenuhi fungsi masih dapat mengandung kelemahan; hasil benchmark keamanan dibatasi pada model dan sampel studi yang dirujuk. | Generator tanpa gate menjadi pembanding untuk melihat keluaran awal dan kebutuhan pemeriksaan. |
| Why multi heads instead of one | Pembagian peran memisahkan analisis temuan, penyiapan pengujian, validasi, dan perbaikan. ReasonVul memberi bukti manfaat pada pengaturannya; Beyond QASecClaw menunjukkan tambahan konteks tidak selalu membantu. | Bandingkan satu reviewer dengan beberapa agen memakai generator, akses alat, aturan arbiter, kesempatan revisi, dan batas total penggunaan model yang sama. Catat token dan waktu aktual. |
| Why guardrails and what benefits we gain | Security gate menetapkan syarat pass/revise/block, mengarahkan perbaikan, dan mencatat alasan penerimaan. Manfaat yang dituju adalah berkurangnya kode rentan yang lolos dengan tetap memperhatikan kode tidak rentan, fungsi, dan biaya. | Unsafe pass, benign pass, cakupan dan block, keberhasilan patch, regresi, token, serta waktu. Menahan semua kode tidak dianggap keberhasilan. |
| Evidence-based mechanism | Pisahkan dugaan reviewer, peringatan alat, dan hasil pengujian. Arbiter non-LLM menerapkan aturan atas bukti yang sesuai dengan versi kode dan ruang lingkup pemeriksaan; bukti wajib yang belum tersedia menghalangi pass. | Uji bukti bertentangan, pemeriksaan gagal/tidak berjalan, respons tidak valid, serta pemeriksaan ulang setelah patch. Jejak keputusan harus menghubungkan versi kode, bukti, dan aturan. |

Sembilan paragraf latar belakang mengembangkan alur tersebut tanpa menambah subbagian baru: penggunaan AI; risiko keamanan; keterbatasan penyaringan; pembagian peran; guardrails dan manfaat; kebutuhan bukti; mekanisme arbiter; manipulasi reviewer; serta usulan dan evaluasi TA. Rumusan masalah dan tujuan diperbarui agar pembagian peran, seluruh pembanding, dan biaya pemeriksaan disebutkan secara eksplisit.

Perbandingan gate lengkap dengan SAST atau SAST dengan satu reviewer menilai paket sistem secara keseluruhan. Kondisi tambahan satu reviewer dengan arbiter dan akses alat yang sama digunakan untuk menilai kontribusi pembagian peran. Perbedaan hasil pada pembanding utama tidak langsung diatribusikan pada jumlah agen. Batas total penggunaan model dan kesempatan revisi ditetapkan sebelum evaluasi; tambahan biaya tidak disembunyikan dalam klaim manfaat.

### Sumber untuk pembaruan 21 November 2026

- [Stack Overflow Developer Survey 2026, bagian AI](https://survey.stackoverflow.co/2026/ai): penggunaan AI untuk menghasilkan kode, debugging/refactoring, dan menulis atau memperbaiki pengujian. Sumber ini menjelaskan penggunaan AI di kalangan responden survei, bukan tingkat kerentanan atau bukti efektivitas gate. Ditambahkan sebagai `stackoverflow2026ai` dalam bibliografi.
- [ReasonVul, bagian 6.3.1 dan Tabel 5](https://arxiv.org/html/2605.18153): konfigurasi penuh dibandingkan dengan konfigurasi satu agen dan penghilangan agen pada PrimeVul. Dipakai sebagai dasar menguji manfaat sudut penalaran berbeda, dengan hasil dibatasi pada pengaturan penelitian itu.
- CyberSecEval, AutoSafeCoder, QASecClaw, Refute-or-Promote, Beyond QASecClaw, dan Thornton diperiksa kembali melalui sumber primer yang ditautkan dalam catatan di bawah. Klaim keamanan saat ini tidak diturunkan dari angka CyberSecEval 2023; hasil tersebut digunakan untuk menunjukkan adanya risiko pada studi yang diuji.

Manfaat gate, manfaat pembagian peran, dan ketahanan sanitizer tetap merupakan sasaran pengujian TA. Belum ada hasil eksperimen TA yang dinyatakan pada pembaruan ini.

### Pemeriksaan hasil pembaruan

Pada 21 November 2026, pratinjau Bab I dan naskah utama dikompilasi dengan Typst 0.15.2. Pratinjau berisi enam halaman isi dan dua halaman daftar pustaka; naskah utama berisi 43 halaman. Sitasi pada sumber Bab I memiliki entri bibliografi yang sesuai. Hasil render Bab I diperiksa untuk penomoran, keterbacaan, pergantian bagian, serta daftar pustaka. Nama pembimbing kedua yang sebelumnya diperbarui menjadi Galuh Dipa Bharata juga sudah tercantum pada PDF naskah utama.

## Penyesuaian gaya terhadap acuan Edbert

Pada 10 November 2026, Bab I dibandingkan kembali dengan Bab I Edbert Eddyson Gunawan (13522039), halaman tercetak 1–5 atau halaman PDF 14–18 pada berkas lokal `13522039-Edbert Eddyson Gunawan.pdf`. Perbandingan membaca seluruh bagian latar belakang sampai sistematika pembahasan. Acuan digunakan untuk alur penjelasan dan bentuk penyajian; isi, data, dan rujukan topik Edbert tidak dipindahkan ke naskah TA ini. Tabel dan jumlah kata pada bagian ini merekam penyesuaian 10 November; pembaruan framing 21 November dijelaskan pada bagian sebelumnya.

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
| RM1: pembagian peran dan mekanisme arbiter yang menghubungkan bukti dengan keputusan, termasuk bukti tidak lengkap/bertentangan | Implementasi peran agen, kebijakan, dan pencatatan keputusan | Skenario bukti bertentangan, temuan belum ditutup, respons tidak valid, pengujian tidak berjalan, serta kesesuaian hash kode dengan bukti. |
| RM2: ketepatan keputusan dan hasil perbaikan dibanding generator tanpa gate, SAST, dan SAST dengan satu reviewer, beserta biaya | Pengukuran penerimaan, deteksi, patch, dan biaya; pengujian kontribusi pembagian peran | Unsafe pass rate, benign pass rate, jumlah pass/revise/block dan tidak-teruji, precision/recall/F1, patch berhasil, regresi, token, dan waktu. Kondisi satu reviewer dengan alat, arbiter, dan anggaran yang sama memisahkan kontribusi pembagian peran dari perubahan paket sistem. |
| RM3: pengaruh sanitizer dan aturan arbiter terhadap ketahanan serta deteksi | Evaluasi berpasangan dengan komponen diaktifkan/dinonaktifkan | Kode rentan yang semula ditahan lalu menjadi pass setelah serangan; hasil pada kode bersih tetap dilaporkan. Kondisi tanpa arbiter mengganti penentu keputusan dengan reviewer sambil mempertahankan alat dan bukti lainnya. |

Pembanding yang direncanakan adalah generator tanpa gate, SAST saja, SAST dengan satu reviewer, dan gate lengkap, disertai kondisi satu reviewer dengan alat serta arbiter yang sama untuk menguji pembagian peran. Tugas, generator, serta kesempatan revisi dipertahankan pada kondisi yang relevan. Pembandingan ini merupakan adaptasi kondisi eksperimen TA, bukan klaim replikasi penuh paper pembanding.

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
