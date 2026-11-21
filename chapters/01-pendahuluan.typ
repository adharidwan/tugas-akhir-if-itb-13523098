= Pendahuluan

Bab ini menjelaskan dasar pengerjaan Tugas Akhir, mulai dari latar belakang dan rumusan masalah sampai tujuan, batasan masalah, metodologi, serta sistematika pembahasan.

== Latar Belakang

Pemanfaatan _large language model_ (LLM) dalam pengembangan perangkat lunak mencakup pembuatan kode melalui instruksi bahasa alami, perbaikan kode, dan penyusunan pengujian. Survei Developer Stack Overflow 2026 mencatat penggunaan AI untuk menghasilkan kode pada bidang yang sudah maupun belum dikenal pengembang, melakukan debugging atau refactoring, serta menulis atau memperbaiki pengujian #cite(<stackoverflow2026ai>). Penggunaan tersebut menempatkan keluaran model dalam alur kerja pengembang, sehingga pemeriksaan terhadap kode yang dihasilkan menjadi bagian penting sebelum kode digunakan.

Persoalan keamanan muncul karena kode yang menjalankan fungsi sesuai permintaan masih dapat memiliki kelemahan. CyberSecEval melaporkan bahwa model yang diuji memberikan saran kode rentan pada rata-rata sekitar 30% kasus dalam benchmark tersebut #cite(<bab2-07>). Angka ini berlaku pada model dan kasus studi tersebut, bukan tingkat kerentanan seluruh kode hasil LLM saat ini. Temuan itu menunjukkan bahwa keberhasilan menghasilkan kode fungsional perlu disertai pemeriksaan persyaratan keamanan; kode yang dapat dijalankan belum cukup menjadi dasar penerimaan.

Pemeriksaan dapat memanfaatkan _static application security testing_ (SAST) dan penilaian LLM. SAST mencari pola kelemahan tanpa menjalankan program, sedangkan reviewer LLM dapat membantu menilai temuan berdasarkan konteks kode. Namun, penyaringan temuan mempunyai konsekuensi: QASecClaw melaporkan penurunan peringatan salah yang disertai kehilangan sebagian temuan benar #cite(<bab2-05>). Oleh karena itu, penilaian satu reviewer perlu dibandingkan dengan pembagian tugas yang memungkinkan dugaan kelemahan diperiksa kembali melalui analisis dan pengujian terpisah.

Pendekatan multi-agen memungkinkan pembagian peran untuk menganalisis temuan, menyiapkan pengujian, memvalidasi hasil, dan memperbaiki kode. ReasonVul menggunakan tiga sudut penalaran dan melaporkan hasil deteksi yang lebih baik daripada konfigurasi satu agen dalam uji ablasinya pada PrimeVul #cite(<bab2-25>). AutoSafeCoder menghubungkan pembuatan kode, review, dan fuzzing melalui umpan balik berulang #cite(<bab2-22>). Kedua penelitian memberi alasan untuk menguji pembagian peran dan pemeriksaan silang. Manfaatnya perlu dinilai terhadap tambahan token dan waktu; jumlah agen sendiri belum menunjukkan bahwa keputusan lebih tepat. Pada pengaturan Java dalam Beyond QASecClaw, penambahan konteks agen tidak memberikan manfaat yang konsisten dibandingkan kontrol deterministik #cite(<almamun2026beyond>).

Pembagian peran tersebut perlu dihubungkan dengan _guardrails_, yaitu batas dan aturan pemeriksaan yang menentukan tindak lanjut atas keluaran model. Dalam Tugas Akhir ini, guardrails diwujudkan sebagai _security gate_ sebelum kode diteruskan kepada pengguna. Gate mengatur apakah kode dapat diterima (_pass_), perlu diperbaiki dan diperiksa ulang (_revise_), atau ditahan untuk ditinjau manusia (_block_). Manfaat yang dituju ialah mengurangi kode rentan yang lolos, memberikan umpan balik perbaikan, dan menyediakan alasan keputusan yang dapat ditelusuri. Manfaat tersebut perlu diuji bersama penerimaan kode tidak rentan, keberhasilan menjaga fungsi kode, dan biaya pemeriksaan.

Keputusan gate memerlukan mekanisme berbasis bukti karena kesepakatan reviewer masih dapat keliru. Refute-or-Promote melaporkan kasus ketika pengujian membantah kandidat kelemahan yang didukung beberapa reviewer #cite(<bab2-01>). Beyond QASecClaw juga menekankan pentingnya kesesuaian bukti dengan program dan ruang lingkup pemeriksaan #cite(<almamun2026beyond>). Pada rancangan penelitian ini, bukti mencakup hasil SAST, hasil pengujian fungsi dan keamanan, serta validasi kesesuaiannya dengan versi kode yang diperiksa. Peringatan alat, dugaan reviewer, dan kelemahan yang dikonfirmasi pengujian dibedakan agar keputusan dapat dijelaskan berdasarkan dukungan yang tersedia.

_Evidence-Based Arbiter_ dirancang sebagai komponen non-LLM yang menerapkan aturan keputusan terhadap bukti tersebut. Pemeriksaan wajib yang belum berjalan tidak diperlakukan sebagai lulus, sedangkan bukti yang bertentangan memerlukan tindak lanjut sebelum kode diterima. Setelah kode diperbaiki, pemeriksaan diulang agar keputusan mengacu pada versi terbaru. Mekanisme ini ditujukan untuk menjaga keterkaitan antara kode, bukti, dan keputusan, termasuk ketika agen gagal memberikan penilaian yang dapat digunakan. Pengaruh aturan tersebut terhadap kode rentan yang lolos dan kode tidak rentan yang tertahan menjadi bagian evaluasi.

Guardrails juga perlu memperhatikan masukan yang dibaca reviewer. Penyerang dapat menambahkan komentar yang mengarahkan reviewer untuk mengabaikan kelemahan. Sanitizer dapat digunakan untuk menyiapkan masukan reviewer, tetapi pengaruhnya terhadap deteksi perlu diperhatikan. Thornton menemukan bahwa efek komentar adversarial tidak signifikan pada pengujian berpasangan, sedangkan penghapusan komentar dapat menurunkan deteksi pada model yang lebih lemah #cite(<bab2-34>). Karena itu, ketahanan terhadap manipulasi perlu dinilai bersama kemampuan memeriksa kode tanpa serangan.

Berdasarkan kebutuhan tersebut, Tugas Akhir ini mengusulkan pengembangan _multi-agent security gate_ dengan Evidence-Based Arbiter untuk memeriksa dan memperbaiki kode hasil LLM. Fokus penelitian terletak pada pembagian peran pemeriksaan dan aturan penerimaan yang menangani bukti tidak lengkap atau bertentangan. Evaluasi membandingkan gate dengan generator tanpa gate, SAST saja, serta SAST dengan satu reviewer LLM untuk menilai manfaat pemeriksaan, perbaikan, dan biaya yang menyertainya. Evaluasi juga mencakup ketahanan terhadap manipulasi reviewer. Verifikasi keamanan dalam penelitian ini berarti pemeriksaan terhadap persyaratan dan kategori kelemahan yang ditetapkan.

== Rumusan Masalah

Berdasarkan latar belakang tersebut, Tugas Akhir ini merumuskan pertanyaan sebagai berikut.

+ Bagaimana merancang dan mengimplementasikan pembagian peran agen serta Evidence-Based Arbiter yang menghubungkan bukti pemeriksaan dengan keputusan penerimaan kode, termasuk ketika bukti tidak lengkap atau bertentangan?
+ Bagaimana perbandingan ketepatan keputusan dan hasil perbaikan multi-agent security gate dengan generator tanpa gate, SAST saja, serta SAST dengan satu reviewer LLM, beserta biaya pemeriksaannya?
+ Bagaimana pengaruh sanitizer dan aturan arbiter terhadap kemampuan deteksi serta ketahanan gate ketika reviewer menerima komentar manipulatif?

== Tujuan Tugas Akhir

Tugas Akhir ini bertujuan mengembangkan multi-agent security gate dengan pembagian peran untuk memeriksa dan memperbaiki kode hasil LLM. Evidence-Based Arbiter menghubungkan bukti pemeriksaan dengan keputusan penerimaan melalui aturan yang menangani hasil tidak lengkap atau bertentangan serta mencatat dasar keputusan. Evaluasi bertujuan mengukur manfaat gate melalui perbandingan ketepatan keputusan dan hasil perbaikan terhadap generator tanpa gate, SAST saja, serta SAST dengan satu reviewer LLM, disertai pengukuran fungsi kode dan biaya pemeriksaan. Evaluasi juga menilai pengaruh sanitizer dan aturan arbiter pada kode tanpa serangan maupun kode dengan komentar manipulatif.

== Batasan Masalah

Batasan masalah yang digunakan dalam Tugas Akhir ini adalah sebagai berikut.

+ Sistem memanfaatkan model LLM yang telah tersedia tanpa pelatihan atau fine-tuning model.
+ Pengujian menggunakan fungsi atau potongan kode Python dari tugas SecurityEval dan subset Python LLMSecEval #cite(<bab2-31>) #cite(<bab2-35>). Fokus awal mencakup CWE-22, CWE-78, CWE-89, CWE-502, dan CWE-798. Contoh pola dan patch dalam knowledge store, jika digunakan, berasal dari data pengembangan yang terpisah dari data uji.
+ Analisis statis menggunakan Semgrep dan Bandit, sedangkan pengujian fungsi dan keamanan dijalankan dalam lingkungan terisolasi. Pemeriksaan wajib yang tidak dapat dijalankan dicatat sebagai tidak teruji dan menghalangi pass. Evaluasi dibatasi pada tugas yang dipilih, bukan aplikasi utuh atau lingkungan produksi.
+ Perbaikan otomatis dibatasi pada dua ronde setelah keluaran pertama. Keputusan block diarahkan untuk tinjauan manusia; pelaksanaan tinjauan tersebut berada di luar evaluasi sistem.
+ Manipulasi reviewer dibatasi pada komentar yang mempertahankan perintah dan perilaku program. Aturan arbiter, prompt sistem, hasil alat, dan knowledge store berada di luar akses penyerang. Sanitizer menyiapkan tampilan reviewer dengan mempertahankan kode asli untuk pemindaian dan eksekusi.

== Metodologi

Pengembangan sistem dilakukan secara bertahap dengan pengujian pada data pengembangan sebagai dasar penyempurnaan rancangan. Konfigurasi dan kebijakan kemudian dibekukan sebelum evaluasi akhir. Tahapan pengerjaan Tugas Akhir adalah sebagai berikut.

+ *Studi literatur dan perancangan sistem.* Tahap ini mengkaji penelitian terkait dan menentukan kebutuhan gate. Hasilnya digunakan untuk menyusun arsitektur, pembagian peran agen, format bukti, dan aturan keputusan arbiter.
+ *Penyiapan data dan skenario pengujian.* Tahap ini memilih sampel, memeriksa label acuan serta duplikasi, dan memisahkan data pengembangan dari data uji. Skenario mencakup kode tanpa serangan, komentar manipulatif, bukti bertentangan, dan pemeriksaan yang gagal dijalankan.
+ *Implementasi sistem.* Tahap ini membangun alur pemeriksaan, sanitizer, pemanggilan alat, pengujian, arbiter, dan perbaikan kode. Bukti serta alasan keputusan dicatat untuk setiap versi kode, termasuk setelah patch.
+ *Pengujian dan analisis hasil.* Gate dibandingkan dengan generator tanpa gate, SAST saja, serta SAST dengan satu reviewer. Kontribusi pembagian peran diuji melalui kondisi satu reviewer dengan akses alat, aturan arbiter, dan batas total penggunaan model yang sama dengan gate multi-agen. Pengaruh sanitizer dan arbiter diuji melalui kondisi pembanding pada tugas yang sama. Analisis mencakup kode rentan yang lolos, penerimaan kode tidak rentan, hasil deteksi, keberhasilan patch, fungsi kode, token, dan waktu pemrosesan. Hasil pada kode bersih serta kasus gagal turut dilaporkan.

== Sistematika Pembahasan

Laporan Tugas Akhir ini terdiri dari lima bab dengan pembahasan sebagai berikut.

Bab I menjelaskan latar belakang, rumusan masalah, tujuan, batasan masalah, metodologi, dan sistematika pembahasan sebagai dasar pengerjaan Tugas Akhir.

Bab II membahas keamanan kode hasil LLM, SAST, sistem multi-agen, perbaikan kode, dan ketahanan reviewer. Penelitian terkait dibandingkan untuk menjelaskan dasar rancangan Evidence-Based Arbiter.

Bab III menguraikan analisis kebutuhan serta perancangan solusi, termasuk arsitektur gate, peran agen, kebijakan arbiter, dan skenario evaluasi.

Bab IV menjelaskan implementasi sistem, konfigurasi eksperimen, hasil pengujian, serta analisis perbandingan sesuai rumusan masalah.

Bab V menyampaikan kesimpulan berdasarkan hasil evaluasi serta saran untuk pengembangan dan penelitian berikutnya.
