= Pendahuluan

Bab ini menjelaskan dasar pengerjaan Tugas Akhir, mulai dari latar belakang dan rumusan masalah sampai tujuan, batasan masalah, metodologi, serta sistematika pembahasan.

== Latar Belakang

Pemanfaatan _large language model_ (LLM) memungkinkan pengembang membuat kode melalui instruksi bahasa alami. Kemampuan ini perlu disertai pemeriksaan keamanan karena kode yang menjalankan fungsi sesuai permintaan masih dapat memiliki kelemahan. CyberSecEval melaporkan bahwa model yang diuji memberikan saran kode rentan pada rata-rata sekitar 30% kasus dalam benchmark tersebut #cite(<bab2-07>). Hasil ini menunjukkan bahwa kemampuan menghasilkan kode perlu diikuti pemeriksaan sebelum kode digunakan.

Pemeriksaan keamanan kode dapat memanfaatkan analisis statis dan penilaian LLM. _Static application security testing_ (SAST) mencari pola kelemahan tanpa menjalankan program, tetapi dapat menghasilkan peringatan pada kode yang sebenarnya tidak rentan. LLM kemudian dapat membantu menilai peringatan berdasarkan konteks kode. QASecClaw menerapkan pembagian tugas tersebut dan melaporkan penurunan peringatan salah yang disertai kehilangan sebagian temuan benar #cite(<bab2-05>). Karena itu, penyaringan temuan perlu memperhatikan ketepatan peringatan sekaligus kelemahan yang terlewat.

Pendekatan multi-agen membagi pekerjaan pemeriksaan dan perbaikan kepada beberapa agen. AutoSafeCoder menghubungkan pembuatan kode, review, dan fuzzing melalui umpan balik berulang #cite(<bab2-22>). Multi-LLMSecCodeEval juga memadukan beberapa model dengan analisis statis pada tahap generasi, deteksi, serta perbaikan #cite(<bab2-28>). Pendekatan ini menyediakan dasar untuk menghubungkan pemeriksaan dengan perbaikan kode. Dalam Tugas Akhir ini, perhatian diarahkan pada mekanisme yang menentukan apakah hasil pemeriksaan sudah cukup untuk menerima kode.

Mekanisme tersebut diperlukan ketika hasil alat dan agen berbeda atau pengujian belum dapat dijalankan. Kesepakatan reviewer juga masih perlu diperiksa bersama bukti yang tersedia. Refute-or-Promote melaporkan kasus ketika suatu pengujian membantah kandidat kelemahan yang didukung beberapa reviewer #cite(<bab2-01>). Beyond QASecClaw turut menunjukkan pentingnya kesesuaian bukti dengan program yang diperiksa. Pada pengaturan Java yang diuji, penambahan konteks agen tidak memberikan manfaat yang konsisten dibandingkan kontrol deterministik #cite(<almamun2026beyond>). Oleh karena itu, penggunaan beberapa agen perlu disertai aturan pengambilan keputusan dan pengujian manfaatnya.

Masukan yang dibaca reviewer juga dapat memengaruhi pemeriksaan. Penyerang dapat menambahkan komentar yang mengarahkan reviewer untuk mengabaikan kelemahan. Sanitizer dapat digunakan untuk menyiapkan masukan reviewer, tetapi pengaruhnya terhadap deteksi perlu diperhatikan. Thornton menemukan bahwa efek komentar adversarial tidak signifikan pada pengujian berpasangan, sedangkan penghapusan komentar dapat menurunkan deteksi pada model yang lebih lemah #cite(<bab2-34>). Ketahanan terhadap manipulasi karena itu perlu dinilai bersama kemampuan memeriksa kode tanpa serangan.

Tugas Akhir ini mengusulkan pengembangan _multi-agent security gate_ dengan _Evidence-Based Arbiter_ untuk memeriksa kode hasil LLM sebelum diteruskan kepada pengguna. Agen membantu menganalisis temuan, menyiapkan pengujian, dan memperbaiki kode. Arbiter non-LLM menggunakan bukti pemeriksaan dan aturan keamanan untuk menentukan apakah kode diterima (_pass_), diperbaiki (_revise_), atau ditahan untuk ditinjau manusia (_block_). Kode yang diperbaiki kembali menjalani pemeriksaan. Evaluasi diarahkan pada ketepatan keputusan, hasil perbaikan, dan ketahanan terhadap manipulasi reviewer. Verifikasi keamanan dalam penelitian ini berarti pemeriksaan terhadap persyaratan dan kategori kelemahan yang ditetapkan.

== Rumusan Masalah

Berdasarkan latar belakang tersebut, Tugas Akhir ini merumuskan pertanyaan sebagai berikut.

+ Bagaimana merancang dan mengimplementasikan multi-agent security gate dengan Evidence-Based Arbiter untuk menangani bukti pemeriksaan yang tidak lengkap atau bertentangan?
+ Bagaimana ketepatan keputusan dan hasil perbaikan gate dibandingkan dengan pemeriksaan menggunakan SAST saja serta SAST dengan satu reviewer LLM?
+ Bagaimana pengaruh sanitizer dan aturan arbiter terhadap kemampuan deteksi serta ketahanan gate ketika reviewer menerima komentar manipulatif?

== Tujuan Tugas Akhir

Tugas Akhir ini bertujuan mengembangkan multi-agent security gate yang memeriksa dan memperbaiki kode hasil LLM dengan Evidence-Based Arbiter sebagai pengambil keputusan. Arbiter dirancang untuk menggunakan bukti pemeriksaan dan menangani hasil yang tidak lengkap atau bertentangan. Sistem dievaluasi dengan membandingkan ketepatan keputusan penerimaan serta hasil perbaikannya terhadap SAST saja dan SAST dengan satu reviewer. Evaluasi juga menilai pengaruh sanitizer dan aturan arbiter pada kode tanpa serangan maupun kode dengan komentar manipulatif, disertai pengukuran fungsi kode dan biaya pemeriksaan.

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
+ *Pengujian dan analisis hasil.* Gate dibandingkan dengan generator tanpa gate, SAST saja, serta SAST dengan satu reviewer. Pengaruh sanitizer dan arbiter diuji melalui kondisi pembanding pada tugas yang sama. Analisis mencakup kode rentan yang lolos, penerimaan kode tidak rentan, hasil deteksi, keberhasilan patch, fungsi kode, token, dan waktu pemrosesan. Hasil pada kode bersih serta kasus gagal turut dilaporkan.

== Sistematika Pembahasan

Laporan Tugas Akhir ini terdiri dari lima bab dengan pembahasan sebagai berikut.

Bab I menjelaskan latar belakang, rumusan masalah, tujuan, batasan masalah, metodologi, dan sistematika pembahasan sebagai dasar pengerjaan Tugas Akhir.

Bab II membahas keamanan kode hasil LLM, SAST, sistem multi-agen, perbaikan kode, dan ketahanan reviewer. Penelitian terkait dibandingkan untuk menjelaskan dasar rancangan Evidence-Based Arbiter.

Bab III menguraikan analisis kebutuhan serta perancangan solusi, termasuk arsitektur gate, peran agen, kebijakan arbiter, dan skenario evaluasi.

Bab IV menjelaskan implementasi sistem, konfigurasi eksperimen, hasil pengujian, serta analisis perbandingan sesuai rumusan masalah.

Bab V menyampaikan kesimpulan berdasarkan hasil evaluasi serta saran untuk pengembangan dan penelitian berikutnya.
