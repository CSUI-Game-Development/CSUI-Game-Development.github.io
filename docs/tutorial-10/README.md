# Tutorial 10 - Game Export & Build Optimisation

> Peringatan: tutorial 10 bersifat **opsional**.

Selamat datang di tutorial 10 kuliah Game Development. Pada tutorial kali ini,
kamu akan mempelajari cara untuk membuat _build_ game ke _platform_ tujuan
supaya calon pemain dapat memainkan game tanpa harus mengunduh Godot Editor.
Selain itu, kamu juga akan melihat bagaimana caranya mengoptimisasi proses
pembuatan _build_ sehingga game yang dihasilkan hanya mengandung fitur-fitur
_engine_ yang dibutuhkan.

## Pengantar

Apabila kamu telah mengikuti rangkaian tutorial dari awal, maka kamu sudah
bisa membuat game sederhana. Langkah selanjutnya adalah membuat game buatanmu
agar bisa dimainkan banyak orang dengan praktis. Sama halnya dengan pemrograman
dimana kamu harus _compile_ dan membuat _build_ program dari _source code_,
game buatanmu juga harus ditransformasikan dari _source code_ dan kumpulan aset
menjadi sebuah produk yang bisa dimainkan di _platform_ yang diinginkan.

Pada game yang dibangun menggunakan Godot, proses untuk mentransformasikan
_source code_ dan kumpulan aset dalam game agar menjadi sebuah
_executable build_ di _platform_ tujuan disebut sebagai proses _**Export**_.
_Source code_ dan aset akan "dibungkus" bersama dengan _binary executable_
Godot Engine yang mengandung fitur-fitur untuk menjalankan game yang telah
"dibungkus." _Binary executable_ Godot Engine disebut sebagai _Export Template_
dan telah disediakan oleh Godot.

> Catatan: Mohon maaf dengan bahasa yang kurang presisi. Mungkin lebih tepatnya,
> proses "pembungkusan" di Godot dilakukan seperti kompilasi dan eksekusi
> pada bahasa pemrograman dengan _virtual machine_/_runtime environment_ khusus
> seperti Java (JVM) dan C# (CLR). Apabila dianalogikan ke ekosistem Java (JVM),
> proses _export_ layaknya mengolah _source code_ dan aset ke bentuk seperti
> "_bytecode_". Kemudian, _export template_ berperan sebagai "JVM" akan
> diatur untuk mengenali dan mengeksekusi "bytecode".

## Export Game

Untuk melakukan _export game_, silakan ikuti panduan resmi Godot di tautan berikut:
[Exporting projects](https://docs.godotengine.org/en/stable/getting_started/workflow/export/exporting_projects.html).
Pastikan kamu telah mengunduh _export template_ dan menyiapkan kebutuhan yang
diperlukan oleh _platform_ tujuan. Misalnya, jika kamu ingin _export_ game ke
Android, maka unduhlah _export template_ Android serta _toolchain_ terkait
pengembangan Android seperti Android Studio, Android SDK, Gradle, dan
sebagainya.

Beberapa catatan terkait proses _export_:

- Apabila game kamu memiliki _script_ yang membaca berkas secara langsung
  (misal: teks dialog dalam berkas _teks_ atau JSON), maka pastikan berkas
  tersebut ditambahkan ke dalam filter berkas/folder _non-resource_ yang
  harus di-_export_.

## Membuat Export Template

_Export template_ resmi dari Godot sebenarnya mengandung semua fitur yang
dimiliki Godot Engine seperti pengmbangan game 2D, 3D, audio, _network_, dan
lain-lain. Hanya saja, kamu sebagai pengembang game mungkin tidak akan
menggunakan semua fitur tersebut. Sebagai contoh, apabila kamu mengembangkan
game 2D, maka kemungkinan besar game kamu tidak membutuhkan modul pengembangan
game 3D. Apabila kamu menggunakan _export template_ yang disediakan Godot, maka
game kamu akan mengandung modul-modul fitur yang sebenarnya tidak dipakai di
dalam game.

Untuk membuat _export template_, maka kita membutuhkan _source code_ dari Godot
Engine dan _build system_ yang dipakai oleh kontributor Godot.

```bash
git clone https://github.com/godotengine/godot.git
```

Godot Engine menggunakan _build system_ bernama [SCons](https://pypi.org/project/SCons/)
yang dapat dipasang menggunakan _package manager_ `pip` di Python minimal versi
3.5:

```bash
pip install SCons
```

Masuk ke dalam direktori (misal: `godot`), lalu buatlah _branch_ baru bernama
`tutorial-10` menggunakan versi (_tag_) Godot Engine terkini sebagai acuan:

> Catatan: Pada saat penulisan dokumen ini, versi _stable_ dari Godot Engine
> yang dijadikan acuan adalah versi `3.2.3-stable`.

```bash
$ cd godot
$ git checkout -b tutorial 3.2.3-stable
$ git log -1 --oneline
31d0f8ad8d (HEAD -> tutorial-10, tag: 3.2.3-stable) Bump version to 3.2.3-stable
```

Karena keterbatasan waktu tutorial, kita hanya akan membuat _export template_
baru untuk _build_ game Web. Pembuatan _export template_ di _platform_ selain
Web bisa dikaji di waktu terpisah, terutama dalam proses pengembangan game di
tugas kelompok. Selanjutnya, ikuti dokumen ["Compiling for the Web"](https://docs.godotengine.org/en/stable/development/compiling/compiling_for_web.html)
hingga akhir _section_ ["Building export templates"](https://docs.godotengine.org/en/stable/development/compiling/compiling_for_web.html#building-export-templates).
Apabila telah berhasil membuat _export template_ baru, silakan mencoba
_export_ ulang game kamu dengan menggunakan _export template_ baru.

## Tugas

- [ ] Buat _build_ versi Web (HTML5) dari game tutorial kamu menggunakan
  _export template_ resmi dari Godot.
- [ ] Buat _export template_ baru untuk membuat _executable build_ game tutorial
  kamu sebagai game Web (HTML5).
- [ ] Pastikan _export template_ baru buatanmu hanya mengandung modul-modul
  yang dibutuhkan dan dipakai di dalam game.
  - Misal: Jika kamu memilih membuat _build_ dari game 2D dan kamu memang tidak
    menggunakan fitur-fitur terkait game 3D, maka matikan modul 3D dalam
    berkas _build options_ (`custom.py`).
- [ ] Lampirkan berkas _build options_ buatanmu di dalam repositori Git
  pengerjaan tutorial ini.
- [ ] Coba bandingkan ukuran _build_ yang dihasilkan dari _export template_
  buatanmu dengan _export template_ resmi dari Godot. Apakah lebih kecil?
  Lebih besar? Laporkan di berkas laporan yang dituliskan dalam format Markdown
  (misal: `T10_[NPM].md`).

## Tugas Tambahan

- [ ] Lakukan optimisasi _build_ pada game Individual Gamejam atau proyek
  kelompok, kemudian cantumkan tautan (URL) ke _commit_ terkait di berkas
  laporan tutorial. **Pastikan _author_ dari _commit_ terkait adalah dirimu sendiri.**
- [ ] Jika kamu melakukan optimasi _build_ pada game Individual Gamejam,
  unggah versi terbaru ke laman itch.io milikmu dan pastikan game masih
  bisa dimainkan secara normal.

## Skema Penilaian

Pada tutorial ini, ada empat kriteria nilai yang bisa diperoleh:

1. **A** apabila kamu mengerjakan tutorial dan latihan melebihi dari ekspektasi
   tim pengajar.
2. **B** apabila kamu hanya mengerjakan tutorial sesuai yang diminta oleh
   deskripsi tutorial.
3. **C** apabila kamu mengerjakan tutorial secara minimalis atau tidak
   lengkap/tuntas.
4. **E** apabila kamu tidak mengerjakan apapun atau tidak mengumpulkan.

## Pengumpulan

Kumpulkan dengan memasukkan berkasnya ke dalam Git dan _push_ ke _fork_ materi
tutorial ini di repositori milik pribadi. **Jangan _push_ atau membuat Merge
Request ke repositori _upstream_ materi tutorial kecuali jika kamu ingin
kontribusi materi atau memperbaiki materi yang sudah dipublikasikan!**

Tenggat waktu pengumpulan adalah **Sabtu, 2 Januari 2021, pukul 21:00**.

## Referensi

- [Laman unduh Godot Engine dan _export templates_ resmi](https://godotengine.org/download/)
- Repositori _source code_ Godot Engine di [GitHub](https://github.com/godotengine/godot)
- Panduan melakukan _export_ di [dokumentasi resmi Godot](https://docs.godotengine.org/en/stable/getting_started/workflow/export/exporting_projects.html)
- [_Tool_ daring untuk membuat berkas _build options_ (`custom.py`)](https://godot-build-options-generator.github.io/)
- Dokumen-dokumen terkait kompilasi, termasuk membuat _export template_ baru di [dokumentasi resmi Godot](https://docs.godotengine.org/en/stable/development/compiling/index.html)
- Materi tutorial pengenalan Godot Engine, kuliah Game Development semester
  gasal 2020/2021 Fakultas Ilmu Komputer Universitas Indonesia.
