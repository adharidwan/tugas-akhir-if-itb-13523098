# Komparasi Penelitian Terdahulu untuk Multi-Agent Security Gate

Disusun pada 3 November 2026 untuk TA **Perancangan dan Implementasi Multi-Agent Security Gate dengan Evidence-Based Arbiter untuk Verifikasi Keamanan Kode Hasil Large Language Model**.

Delapan studi dipilih berdasarkan kedekatannya dengan pembuatan kode aman, triase SAST, penyelesaian konflik antaragen, dan pengambilan keputusan berdasarkan bukti. Ini komparasi terarah, bukan systematic literature review. Angka di bawah merupakan hasil yang dilaporkan penulis; belum direplikasi dalam TA ini. Rancangan TA merujuk pada [catatan penelitian](bab2-catatan-pribadi.md) dan masih berupa usulan.

## 1. Komparasi tujuan, metode, dan dasar keputusan

| Paper | Masalah dan objek yang diperiksa | Metode dan dasar keputusan | Batas hasil dan relevansi terhadap TA |
|---|---|---|---|
| **[AutoSafeCoder](https://arxiv.org/html/2409.10737v1)**; Nunez dkk. (2024), v1 | Kode Python hasil LLM. | Coding Agent membuat/menambal; reviewer LLM memeriksa; fuzzing mengeksekusi masukan mutasi. | Pada v1, Bandit merupakan evaluator eksperimen. Tidak adanya crash belum menjamin keamanan. |
| **[QASecClaw](https://arxiv.org/html/2605.01885v1)**; Ameen dkk. (2026), v1 | Triase temuan SAST. | Semgrep menghasilkan kandidat; filter Qwen 3.5 Plus mempertahankan/menyisihkan temuan. Respons gagal/tidak valid mempertahankan seluruh batch. | Jalur dinamis tidak aktif pada eksperimen OWASP. Mengevaluasi laporan temuan, bukan keputusan penerimaan kode. |
| **[Multi-LLMSecCodeEval / Teaming-Up LLMs](https://arxiv.org/html/2603.22717v1)**; Sabir dkk. (2026), v1 | Menilai apakah kolaborasi beberapa model meningkatkan keamanan sepanjang generasi, deteksi, dan patching. | Sepuluh pipeline membandingkan model tunggal, ensemble, kolaborasi, serta kombinasi CodeQL, verifikasi lintas-model, dan patching. | Penting untuk memisahkan manfaat banyak model dari manfaat alat. Dataset diseleksi dan hasil bergantung pada evaluator; alur generasi sampai perbaikan sudah diteliti. |
| **[ReasonVul](https://arxiv.org/html/2605.18153v1)**; Peng dkk. (2026), v1 | Mendeteksi kerentanan pada fungsi rentan dan versi perbaikannya. | Agen deduktif, induktif, dan abduktif melakukan analisis independen lalu debat bila berbeda. Kesepakatan menjadi keputusan; konflik yang tersisa setelah batas ronde diberi label tidak rentan. | Pembanding untuk penyelesaian konflik. Konsekuensi aturan konflik terhadap keputusan penerimaan kode perlu diuji tersendiri; keberhasilan debat bukan bukti bahwa seluruh konflik telah terselesaikan benar. |
| **[VulTrial](https://arxiv.org/html/2505.10961v2)**; Widyasari dkk. (2025), v2; mencantumkan publikasi ICSE 2026 | Membedakan fungsi rentan dan benign yang sangat mirip. | Security Researcher mengajukan temuan, Code Author menyanggah, Moderator merangkum, dan Review Board LLM menetapkan validitas, severity, serta tindakan. | Pembanding untuk adjudikasi berbasis LLM. Rekomendasi mitigasi oleh Code Author berbeda dari loop implementasi patch yang dievaluasi sebagai keluaran kode. |
| **[SAST-Genius](https://arxiv.org/pdf/2509.15433)**; Agrawal dan Ahi (2025) | Memperbaiki deteksi dan triase pada repositori perangkat lunak. | Semgrep 1.97.0 digabung dengan Llama 3 8B yang di-fine-tune untuk analisis konteks, triase, dan pembuatan PoC. | Pembanding bagi triase berbantuan bukti dan penjelasan temuan. Data pelatihan mencakup data proprietary, sehingga replikasi memerlukan perhatian pada ketersediaan data. Hasil campuran bahasa tidak langsung mewakili Python hasil LLM. |
| **[Refute-or-Promote](https://arxiv.org/html/2604.19049v1)**; Agarwal (2026), v1 | Menyaring kandidat cacat sebelum pelaporan kepada pengelola perangkat lunak. | Review adversarial bertahap, konteks reviewer baru, kritik lintas-keluarga model, dan konfirmasi empiris wajib sebelum disclosure; manusia meninjau hasil akhir. | Pembanding dekat untuk promosi temuan berdasarkan bukti. Protokol berkembang selama kampanye; hasilnya studi lapangan, bukan eksperimen tetap pada benchmark kode hasil LLM. |
| **[Beyond QASecClaw](https://arxiv.org/html/2610.36947v1)**; Al Mamun dkk. (2026), v1, 27 Oktober | Menguji manfaat penambahan konteks agen, feedback verifier, dan kesesuaian bukti dalam software assurance Java. | Lima eksperimen membandingkan penilaian model dengan kontrol deterministik, termasuk pemeriksaan ruang lingkup bukti. Bukan replikasi langsung QASecClaw atau satu pipeline terpadu. | Sangat relevan bagi kebaruan arbiter non-LLM. Bukti bergantung pada konstruksi eksperimen, cakupan, dan model yang diuji; tidak membuktikan seluruh sistem multi-agen tidak bermanfaat. |

## 2. Komparasi evaluasi dan hasil

Metrik dalam tabel ini menjawab pertanyaan yang berbeda. Jumlah kode rentan, F1 deteksi, pasangan fungsi yang benar, dan kandidat yang gugur tidak dapat dipakai untuk membuat peringkat langsung antarpaper.

| Paper | Dataset / ruang evaluasi | Hasil yang dilaporkan | Cara membaca hasil |
|---|---|---|---|
| [AutoSafeCoder, §4, Tabel 1](https://arxiv.org/html/2409.10737v1#S4) | SecurityEval: 121 tugas Python; HumanEval; GPT-4o. | Rentan menurut Bandit **59/121 menjadi 44/121**; HumanEval pass@1 **0,9085 menjadi 0,8780**. | Keamanan dan fungsi diukur pada benchmark berbeda. |
| [QASecClaw, §IV-V, Tabel II-III](https://arxiv.org/html/2605.01885v1#S5) | OWASP Benchmark v1.2: **2.740 kasus Java**, 11 CWE. | FP **560 menjadi 64**; TP **1.273 menjadi 1.233**; F1 sekitar **0,784 menjadi 0,909**; recall sekitar **0,900 menjadi 0,871**. | Peringatan salah berkurang, tetapi sebagian temuan benar ikut tersisih. |
| [Multi-LLMSecCodeEval, §4 dan §6, Tabel 4](https://arxiv.org/html/2603.22717v1#S6) | SecLLMEval: 112 tugas; SecLLMHolmes: 106 tugas; C dan Python. | Pada eksperimen ensemble model lebih kecil, pipeline P10 menghasilkan **3,6% dan 1,9%** keluaran insecure pada masing-masing dataset. | Angka ini khusus konfigurasi pada Tabel 4; jangan digabung dengan persentase peningkatan konfigurasi model lain. Penilaian keamanan banyak bergantung pada CodeQL. |
| [ReasonVul, §6 dan §7](https://arxiv.org/html/2605.18153v1#S6) | PrimeVul dan JITVUL. | PrimeVul: **PairAcc 40,00%**, **F1 72,52%**; **389/542** konflik diselesaikan benar. JITVUL: **PairAcc 28,67%**. | PairAcc memerlukan kedua anggota pasangan diklasifikasikan benar; bukan akurasi per fungsi atau ukuran penerimaan kode. |
| [VulTrial, §3.1 dan §4.1, Tabel 1](https://arxiv.org/html/2505.10961v2#S4.T1) | PrimeVul paired: **435 pasangan uji**. | GPT-4o tanpa instruction tuning: **81 pasangan benar**, dibanding **40** pada single-agent CoT dan **44** pada GPTLens; recall **0,60**, FPR **0,52**. | Angka adalah jumlah pasangan. Peningkatan pair correctness tetap disertai false positive yang cukup besar; konfigurasi tuning dibahas terpisah. |
| [SAST-Genius, §IV, Tabel 1](https://arxiv.org/pdf/2509.15433) | **25 repositori** Python/Java/JavaScript; lebih dari 250 ribu LOC; **170 kerentanan acuan**. | FP **225 menjadi 20**; precision **35,7% menjadi 89,5%**; recall **73,5% menjadi 100%**. | Ini hasil kurasi penulis, dengan karakteristik berbeda dari benchmark sintetis dan tugas generasi kode. |
| [Refute-or-Promote, abstrak dan §4-5](https://arxiv.org/html/2604.19049v1#S4) | Kampanye **31 hari**, **7 target**, sekitar **171 kandidat**; subset protokol terkonsolidasi **30 kandidat**. | Sekitar **79%** kandidat gugur pada agregat retrospektif; **83%** pada subset prospektif. Satu uji empiris membantah kandidat yang didukung sepuluh reviewer khusus. | Kill rate bukan precision, recall, atau persentase kerentanan yang berhasil diperbaiki. Kandidat yang dibuang tidak semuanya otomatis berlabel acuan false positive. |
| [Beyond QASecClaw, §III-IV dan §VI](https://arxiv.org/html/2610.36947v1#S4) | **13.638 request model**; kontrol Java, OWASP, SV-COMP, Defects4J, dan paket bukti. | Pada delapan kontrol, peningkatan konteks **1 menjadi 50** menaikkan token sekitar **49 kali** tanpa memperbaiki unsafe clearance. Pada 32 tugas SV-COMP, baseline JBMC+JVM memberi **26 benar, 6 unresolved**. | Baseline deterministik memperoleh validasi JVM tambahan; inputnya tidak identik dengan feedback mentah ke model. Hasil dibatasi model dan konstruksi yang diuji. |

### Ketelitian angka untuk dua pembanding utama

Pada AutoSafeCoder, penurunan kerentanan adalah **12,40 poin persentase**, atau **25,42% secara relatif**; penurunan pass@1 **3,05 poin persentase**. Klaim “13%” perlu disertai jumlah sampel. [Sumber: Tabel 1](https://arxiv.org/html/2409.10737v1#S4).

Pada QASecClaw, pengurangan FP adalah **88,57%**. Sebanyak **40 TP** ikut hilang: **3,14% dari TP baseline**, setara penurunan recall **2,83 poin persentase** berdasarkan confusion matrix. [Sumber: Tabel III](https://arxiv.org/html/2605.01885v1#S5).

## 3. Sintesis untuk posisi penelitian TA

Bagian ini merupakan interpretasi komparatif dan usulan evaluasi, bukan hasil eksperimen TA atau bukti bahwa suatu kombinasi komponen belum pernah diteliti.

**Pembanding utama memiliki fungsi berbeda.** AutoSafeCoder cocok untuk membandingkan alur pembuatan dan perbaikan kode. QASecClaw cocok untuk membandingkan pengaruh reviewer terhadap temuan SAST. ReasonVul dan VulTrial relevan untuk menilai mekanisme penyelesaian konflik. Refute-or-Promote serta Beyond QASecClaw perlu diperhitungkan saat menjelaskan hubungan bukti empiris dengan keputusan. Dasar pengelompokan ini adalah metode dan ruang evaluasi pada tabel di atas.

**Keberadaan banyak agen, arbiter, feedback alat, atau loop perbaikan belum cukup menjadi klaim kebaruan.** Komponen tersebut sudah muncul dalam studi yang dibandingkan. Bahkan aturan deterministik untuk memeriksa bukti telah diuji dalam Beyond QASecClaw. Kontribusi TA perlu dinyatakan melalui masalah yang spesifik, kebijakan yang dapat diperiksa, dan pengujian yang menunjukkan manfaat maupun kerugiannya.

Arah kontribusi yang layak diuji adalah **ketepatan keputusan penerimaan kode Python hasil LLM ketika bukti SAST, penilaian reviewer, dan hasil pengujian tidak lengkap atau bertentangan**, termasuk sesudah patch dan saat reviewer menerima komentar manipulatif. Rancangan awalnya mencakup:

1. **Kewenangan reviewer dan arbiter yang jelas.** Reviewer memberi penilaian; program arbiter menerapkan kebijakan `pass`, `revise`, atau `block`. Reviewer tidak dapat sendirian membatalkan temuan berkeparahan tinggi yang belum diselesaikan.
2. **Bukti terhubung dengan kode yang diputuskan.** Simpan hash kode, aturan dan versi alat, hasil pengujian, serta alasan keputusan. Patch memicu pemeriksaan ulang; bukti versi lama tidak otomatis berlaku.
3. **Pemeriksaan gagal tetap menjadi hasil yang terlihat.** Timeout, JSON tidak valid, atau pengujian yang tidak berjalan tidak dihitung sebagai lulus. Laporkan pengaruh kebijakan ini terhadap cakupan penerimaan dan beban tinjauan.
4. **Ketahanan keputusan akhir diuji secara berpasangan.** Gunakan kode bersih dan kode dengan komentar serangan yang tidak mengubah perilaku program. Ukur apakah keputusan terhadap kode rentan berubah menjadi `pass`.

Hipotesisnya adalah kebijakan tersebut dapat mengurangi kode rentan yang lolos. Hipotesis tandingannya adalah gate hanya menjadi lebih sering menahan semua kode. Karena itu, penurunan unsafe pass harus dilaporkan bersama penerimaan kode benign, jumlah `block`, biaya, dan cakupan. Penggunaan Python atau nama Evidence-Based Arbiter sendiri belum membuktikan kebaruan.

## 4. Pembanding dan metrik yang disarankan

Tabel berikut adalah **rancangan eksperimen TA**, bukan reproduksi yang sudah selesai. Adaptasi metode harus disebut adaptasi; penggunaan komponen serupa belum cukup untuk menyatakan replikasi paper asli.

| Kondisi | Pertanyaan yang dijawab |
|---|---|
| Generator saja | Seberapa rentan keluaran awal sebelum gate diterapkan? |
| SAST saja | Berapa manfaat dan keterbatasan alat tanpa reviewer LLM? |
| SAST + satu reviewer LLM | Apakah triase menurunkan FP sambil meningkatkan kode rentan yang lolos? Terinspirasi jalur filter QASecClaw. |
| Reviewer LLM + pengujian dinamis + feedback perbaikan | Bagaimana hasil alur yang mendekati fungsi AutoSafeCoder ketika disesuaikan dengan lingkungan TA? |
| Gate lengkap dengan arbiter deterministik | Apakah kebijakan bukti memberi manfaat tambahan di atas alat, reviewer, dan pengujian yang sama? |
| Gate dengan komponen dihilangkan satu per satu | Apa pengaruh sanitizer, triase, dan aturan pemeriksaan bukti terhadap hasil? |

Pertahankan generator, sampel, versi alat, dan kesempatan revisi yang sama pada kondisi yang relevan. Catat perbedaan anggaran serta token aktual. Buat label acuan terpisah dari temuan alat di dalam gate, dan sertakan sampel rentan maupun benign.

| Metrik | Definisi operasional dan alasan |
|---|---|
| **Unsafe pass rate** | Jumlah sampel rentan yang mendapat `pass` dibagi seluruh sampel rentan yang dinilai. Mengukur kegagalan penerimaan kode. |
| **Benign pass rate** | Jumlah sampel benign yang mendapat `pass` dibagi seluruh sampel benign yang dinilai. Mengungkap gate yang sekadar menahan semua keluaran. |
| **Cakupan dan block rate** | Laporkan jumlah `pass`, `revise`, `block`, kegagalan, dan pemeriksaan tidak teruji. Jangan membuang kegagalan dari penyebut. |
| **Precision, recall, F1** | Hitung pada keluaran deteksi, dengan TP/FP/TN/FN dan hasil per CWE. `Block` karena kegagalan infrastruktur tidak otomatis berarti prediksi rentan. |
| **ASR bersyarat** | Pasangan rentan yang semula ditahan tetapi menjadi `pass` setelah serangan, dibagi pasangan rentan yang semula ditahan. Penyebut nol berarti tidak terdefinisi. |
| **Patch berhasil** | Patch menutup kelemahan acuan dan tetap lulus uji fungsi; bagi dengan seluruh kasus yang masuk remediasi. Catat regresi fungsi dan keamanan. |
| **Biaya** | Token semua panggilan, waktu dinding, jumlah request, ronde, dan kegagalan. Ini diperlukan untuk menilai manfaat tambahan tiap komponen. |

## 5. Jejak sumber

Semua sumber ditelusuri pada 3 November 2026. Versi v1 AutoSafeCoder dipertahankan agar sesuai dengan [PDF lokal](../reference/01-autosafecoder-2409.10737v1.pdf) dan naskah Bab 2 saat ini. Tahun VulTrial di tabel mengikuti preprint v2 tahun 2025; halaman paper juga mencantumkan venue ICSE 2026.

- [AutoSafeCoder v1](https://arxiv.org/html/2409.10737v1): §3 untuk peran agen; §4 dan Tabel 1 untuk evaluator, sampel, serta fungsi.
- [QASecClaw v1](https://arxiv.org/html/2605.01885v1): §III-C/D untuk jalur dinamis dan kegagalan filter; §IV-V untuk data dan hasil.
- [Multi-LLMSecCodeEval v1](https://arxiv.org/html/2603.22717v1): §4 untuk dataset dan pipeline; §6/Tabel 4 untuk konfigurasi ensemble model lebih kecil.
- [ReasonVul v1](https://arxiv.org/html/2605.18153v1): §4.2.5-4.3 untuk aturan keputusan; §6-7 untuk hasil dan konflik.
- [VulTrial v2](https://arxiv.org/html/2505.10961v2): §2 untuk peran dan keputusan; §3.1 serta §4.1/Tabel 1 untuk evaluasi.
- [SAST-Genius](https://arxiv.org/pdf/2509.15433): halaman 3, §IV/Tabel 1 untuk evaluasi; halaman 4, §V-B untuk data pelatihan proprietary.
- [Refute-or-Promote v1](https://arxiv.org/html/2604.19049v1): abstrak serta §3-5 untuk protokol, hasil, dan keterbatasan kampanye.
- [Beyond QASecClaw v1](https://arxiv.org/html/2610.36947v1): §III-IV untuk eksperimen; §V-VI untuk batas interpretasi. Paper menyatakan artefak risetnya belum dirilis publik.
