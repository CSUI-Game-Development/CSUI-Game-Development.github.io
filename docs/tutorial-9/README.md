# Tutorial 9 - Game Polishing dan Game Balancing

Selamat datang pada tutorial kelima kuliah Game Development. Pada tutorial kali ini, kamu akan mempelajari cara apa yang dimaksud dengan ***Game Polishing*** dan juga ***Game Balancing***. Dalam ***Game Polishing*** kamu akan belajar mengenai ***Particles***. Sedangkan dalam ***Game Balancing*** kamu akan mencoba untuk melakukan *balancing* sederhana.

## Daftar isi

- [Tutorial 9 - Game Polishing dan Game Balancing](#tutorial-9---game-polishing-dan-game-Balancing)
  - [Daftar Isi](#daftar-isi)
  - [Pengantar](#pengantar)
    - [Game Polishing](#game-polishing)
    - [Game Balancing](#game-balancing)
  - [Creating Particles](#creating-particles)
    - [Particles](#particles)
    - [Creating an Environment Particle](#creating-an-environment-particle)
    - [Creating a Trail Particle](#creating-a-trail-particle)
  - [Game Balancing](#game-balancing)
    - [Balancing Spawn Rate](#balancing-spawn-rate)
  - [Bonus To Do](#bonus-to-do)
  - [Instruksi Pengerjaan](#Instruksi-Pengerjaan)
  - [Skema Penilaian](#skema-penilaian)
  - [Pengumpulan](#pengumpulan)
  - [Referensi](#referensi)


## Pengantar

> IMPORTANT: Untuk tutorial kali ini, diperbolehkan menggunakan template game yang telah disediakan **ATAU** melanjutkan dari yang sudah dikerjakan di tutorial 6 kemarin. Jika ingin melanjutkan proyek kemarin, cukup mengcopy isi folder T6 kamu ke dalam folder T9 sebelum mulai.

### Game Polishing

Selama mengerjakan tutorial game development ini, game yang sudah dibuat cukup sederhana. Mulai dari platformer 2D sederhana hingga first person (shooter?) 3D sederhana. Namun dalam game yang sudah dibuat masih belum ada "pemanis" yang diberikan ke pemain agar game yang dimainkan terlihat / terasa oleh pemain. Apa saja sih pemanisnya itu? Banyak hal yang dapat dilakukan oleh game developer agar dapat membuat game lebih menarik bagi pemain, hal ini dapat berupa visual ataupun audio. Dalam visual, game developer dapat membuat asset yang menarik bagi pemain, menggunakan post-processing agar asset yang ada lebih terlihat bersih, ataupun menambahkan detail-detail kecil berupa animasi ataupun particle yang dapat membuat game terlihat lebih dinamik.

Berikut adalah beberapa contoh polishing yang ada dalam game-game populer:

Dalam game Hollow Knight, particle banyak digunakan untuk membuat animasi yang ada semakin menarik. Seperti contohnya particle saat menyerang, particle saat menghancurkan pintu ataupun membunuh musuh, hingga particle pada environment level.

![Hollow Knight](images/hollow-knight.gif)

Dalam game GTA V, polishing yang dapat dilihat pada scene _wasted_ adalah effect slow-motion yang ada, perubahan color balancing untuk memberikan efek kalah/mati, hingga penggunaan sound fx yang sangat khas.

![GTA V](images/gta-wasted.gif)

### Game Balancing

Pada tutorial-4 kemarin, kamu sudah mempelajari mengenai basic 2D level design, dan mencoba untuk mendesain suatu level. Namun, apakah kamu yakin level yang kamu buat sudah pasti bisa diselesaikan oleh pemain? apakah kamu yakin level yang kamu buat tidak membuat pemain kesal dan akhirnya berhenti memainkan game kamu? Jika tidak, maka kamu perlu untuk memainkan kembali level yang kamu buat dan lakukan *Game Balancing* pada level tersebut. Banyak hal yang dapat dilakukan untuk melakukan _balancing_ pada suatu level, mulai dari mengubah nilai-nilai yang digunakan dalam script yang digunakan, hingga mengubah level design yang sudah dibuat agar level lebih _balanced_.

Berikut adalah beberapa contoh mengenai game balancing:

Dalam game Cat Mario, level sengaja dibuat sangat susah karena game Cat Mario didesin untuk menjadi _Rage Game_. Namun dalam pembuatan levelnya, pasti tetap dilakukan balancing agar level yang dibuat dapat diselesaikan oleh pemain dalam keadaan ***Rage*** bukan sampai ***Rage Quit***.

![Cat Mario](images/cat-mario.gif)

Dalam permainan League of Legends, balancing dilakukan setiap saat karena permainan MOBA memang merupakan game multiplayer yang dirancang agar menjadi game yang [Perfect Imbalance](https://www.youtube.com/watch?v=e31OSVZF77w), dimana balancing dilakukan agar permainan tetap menyenangkan bagi pemain dengan memberikan perubahan meta di setiap patch change-nya.

![League of Legends Patch Notes](images/patch-notes.png)

## Creating Particles

### Particles

Particles merupakan teknik dalam game development untuk menampilkan atau mensimulasikan efek physics yang kompleks, seperti api, asap dari api tersebut, hujan, dan lain-lain. dengan menggunakan particle, game developer dapat memberikan tampilan visual yang lebih detail dan lebih menarik kepada pemain. Dalam game engine Godot, disediakan Node particle untuk game 2D yaitu ```Particles2D```. Dengan menggunakan node ```Particles2D``` kamu dapat membuat berbagai macam efek yang ingin kamu buat. Untuk melakukan itu kamu dapat bermain dengan properties yang ada pada node ```Particles2D```, pada tutorial ini, kamu akan mencoba untuk membuat particle hujan abu pada level yang sudah disediakan, dan juga particle trail ketika player berjalan di level. Untuk penjelasan properties yang digunakan akan dijelaskan dengan sejalannya tutorial. Berikut adalah perbedaan hasil akhir yang diharapkan dengan level tanpa penggunaan particle:

![Keadaan Awal](images/keadaan-awal.gif)

![Hasil Akhir](images/hasil-akhir.gif)

### Creating an Environment Particle

Pertama, buka template Level 1 yang telah disediakan (atau gunakan level yang sudah kamu buat di tutorial-6 sebelumnya), lalu tambahkan node Particles2D kepada root Node yang ada.

![Add Node Particles2D](images/new-particles2d.png)

Ketika berhasil ditambahkan, node Particles2D akan menampilkan warning, hal ini dikarenakan kamu perlu menambahkan ParticlesMaterial kepada Node Particles2D agar dapat berjalan. Hal ini dapat ditemukan di tab inspector, ```Process Material```, lalu tambahkan ParticlesMaterial yang baru.

![New Particles Material](images/particles_material.png)

Sekarang kamu dapat melihat particlemu bejalan, namun hanya berupa titik-titik kecil yang berjatuhan, sekarang kita akan mengubah particle ini agar menjadi hujan abu yang kita inginkan. Karena kita ingin membuat hujan abu, kita ingin agar titik-titik particle yang kita punya berjumlah banyak, dan bertahan lama di layar. Untuk melakukan itu pada tab inspector, ubah ```Amount``` menjadi 500, ```Lifetime``` menjadi 4, dan ```Speed Scale``` menjadi 0.5. 
- Properti ```Amount``` melambangkan banyaknya titik particle yang ingin kita punya.
- Properti ```Lifetime``` melambangkan lamanya suatu titik particle akan hidup di dunia game kita.
- Properti ```Speed Scale``` melambangkan kecepatan jalannya waktu untuk particle kita.

![Amount, Lifetime and Speed Scale](images/amount-lifetime-speed-scale.png)

Selanjutnya, kita ingin agar titik particle kita dapat terlihat dari kamera, sehingga kita perlu untuk mengubah ukuran dari particle kita. Klik ```ParticlesMaterial``` yang sudah kita tambahkan sebelumnya, lalu pada tab ```Scale``` ubah ```Scale``` menjadi 10 dan agar kita mendapat variasi ukuran, ubah ```Scale Random``` menjadi 0.5.
- Properti ```Scale``` melambangkan ukuran dari suatu titik particle.
- Properti ```Scale Random``` melabangkan range random dari titik particle yang akan dibuat. 0 menandakan tidak ada random scale, 1 menandakan banyak random scale.

![Scale](images/scale.png)

Selanjutnya, agar particle yang kita miliki tidak hanyak muncul dari suatu titik saja, kita akan mengubah area awal particle dari titik menjadi persegi panjang yang sangat panjang agar dapat menutupi seluruh level. Pada tab ```Emission Shape```, ubah ```Shape``` menjadi box, dan ubah ```Box Extents``` value x menjadi 2000. Dari sini particle sudah mulai terlihat seperti hujan.

![Emission Shape](images/emission-shape.png)

Selanjutnya, agar particle yang kita punya terlihat seperti hujan abu, kita dapat mengubah warnanya. Pada tab ```Color```, ubah warna menjadi warna abu (#A9A9A9).

![Color](images/color.png)

Selanjutnya, kita ingin agar hujan abu kita memiliki kecepatan yang lebih cepat agar menghasilkan ilusi hujan abu yang lebat. Untuk melakukan ini, pada tab ```Direction```, ubah ```Spread``` menjadi 20 agar persebaran particle tidak terlalu jauh. Lalu pada tab ```Gravity``` ubah gravity x menjadi -500 dan gravity y menjadi 500 agar particle kita terpengaruh gravitasi ke arah kiri bawah. Lalu, pada tab ```Initial Velocity```, ubah ```Velocity``` menjadi 500 agar particle kita sudah cepat dari awal mulai animasi particle.
- Properti ```Spread``` melambangkan derajat persebaran particle. 180 derajat menandakan particle akan keluar ke segala arah.
- Properti ```Gravity``` melambangkan besarang gravitasi yang diterima oleh titik particle kita.
- Properti ```Velocity``` melambangkan kecepatan awal titik particle ketika muncul di game.

![Spread, Gravity, and Velocity](images/spread-gravity-velocity.jpg)

Hmmm, kenapa particle yang sekarang ada pada awalnya muncul ke arah kanan terlebih dahulu? Itu karena dengan kita mengubah nilai ```Velocity``` menjadi lebih dari 0, particle yang kita punya akan dikenakan kecepatan sesuai dengan nilai ```Velocity``` ke arah kanan saja. Oleh karena itu kita harus merotasi particle kita agar arah particle ke arah kiri. Pada tab ```Transform``` pada Node2D, ubah rotation degrees menjadi 180. Lalu, pada tab ```Drawing```, ubah ```Local Coord``` menjadi off.
- Properti ```Transform``` merupakan posisi dari Node2D.
- Properti ```Local Coords``` melambangkan sifat dari particle, dimana jika ```on``` particle akan begerak sesuai dengan pergerakan node, sedangkan jika ```off``` particle yang sudah dinyalakan akan tetap berjalan sesuai physics yang ada dengan menghiraukan posisi node.

![Transform](images/transform-1.png)
![Local Cords](images/local-coords.png)

Sepertinya particle yang sudah kita buat sudah mirip dengan hujan abu, coba kita liat dalam in-game.

![Missing Particle](images/missing-particle-camera.gif)

Loh? kok ketika kita gerak particlenya hilang? Itu karena particle hanya akan ditampilkan jika drawing areanya berada di camera. Oleh karena itu kita harus mengubah drawing area particle kita dan juga posisinya. Pada tab ```Drawing``` ubah ```Visibilty Rect``` menjadi (-2000, -1000, 4000, 1000) untuk mengubah ukuran drawing area particle dan titik tengahnya. Lalu pada tab ```Transform``` ubah posisi x menjadi 1700 dan posisi y menjadi -200 agar particle berada di tengah level.
- Properti ```Visibility Rect``` melambangkan ukuran drawing area (visibility area) dari particle kita.

![Visibility Rect](images/visibility-rect.png)
![Transform](images/transform-2.png)

Sekarang, tinggal beberapa detail lagi yang akan kita buat. Yaitu merotasi titik particle agar tidak terlihat seperti kotak, dan membuat particle tidak menutupi sprite level ktia. Pada tab ```Angle``` ubah ```Angle``` menjadi 45, untuk merotasi kotak particle sebanyak 45 derajat. Lalu pada tab ```Canvas Item```, ```Visibility``` ubah ```Show behind parent``` menjadi ```on``` agar particle kita berada di belakang sprite parent. 
- Properti ```Angle``` melabangkan rotasi dari titik particle kita.
- Properti ```Show behind parent``` merupakan properti dari CanvasItem untuk membuat sprite berada di belakang sprite parent.

![Angle](images/angle.png)
![Canvas Item](images/canvas-item.png)

Done! Sekarang particle sudah terlihat seperti hujan abu!

![Done Hujan Abu](images/done-abu.gif)

### Creating a Trail Particle

Sekarang kita akan membuat particle trail saat player berjalan. Pertama buka scene ```player.tscn```. Lalu tambahkan kembali Node Particles2D. Dan tambahkan kembali ```ParticlesMaterial```. Berbeda dengan particle environment sebelumnya, untuk particle ini kita akan menggunakan aset yang disediakan. Pada tab ```Texture```, ubah ```Texture``` menjadi menggunakan asset ```Asserts/kenney_platformerpack/PNG/Particles/brickGrey_small.png```.
- Properti ```Texture``` melambangkan texture yang ingin kita pakai untuk particle kita, jika tidak ada akan menggunakan kotak (seperti pada particle environment hujan abu)

![Texture](images/texture.png)

Selanjutnya, berbeda dengan sebelumnya, sekarang kita tidak ingin jumlah particle yang cukup banyak karena akan memenuhi trail kita, dan lifetime dari particle tidak perlu lama karena trail tidak akan lama berada di layar, oleh karena itu pada tab ```Particles2D```, ubah ```Amount``` menjadi 4 dan ```Lifetime``` menjadi 0.5.

![Amount and Lifetime](images/trail-amount-lifetime.png)

Selanjutnya, agar particle muncul ke segala arah dan terbang ke atas, ubah ```Gravity``` nilai y menjadi -200, ```Spread``` menjadi 180 derajat, dan ```Initial Velocity``` menjadi 50.

![Spread and Gravity](images/trail-spread-gravity.jpg)

Selanjutya, agar particle tidak hanya muncul dari satu titik, ubah ```Emission Shape``` menjadi box dengan nilai x 30. Lalu pindahkan pula node Particles2D ke bagian kaki player, pada tab ```Transform``` ubah nilai y menjadi 30.

![Emission Shape](images/trail-emission-shape.png)
![Transform](images/trail-transform.png)

Selanjutnya, agar particle tidak terus mengikuti player, ubah ```Local Coord``` menjadi ```off```. 

![Local Coord](images/trail-local-coord.png)

Sekarang, karena sepertinya sudah terlihat bagus, kita coba mainkan di in-game.

![Trail is Always On](images/trail-always-on.gif)

Sepertinya sudah terlihat cukup bagus, sekarang masalahnya particle selalu berjalan, sedangkan kita hanya ingin particle berjalan ketika player berada di lantai dan sedang berjalan. Untuk melakukan itu kita dapat menggunakan script untuk mengatur kapan particle berjalan dengan mengganti atribut ```Emission```, dimana atribut ini melambangkan keadaa particle berjalan atau tidak (mengeluarkan particle atau tidak). Untuk itu kita perlu mengubah script ```Player.gd```. Tambahkan baris ini di bagian deklarasi variable:
```
onready var particle = self.get_node("Particles2D")
```

Lalu tambahkan baris ini di fungsi ```_process```:
```
if is_on_floor() and (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		particle.set_emitting(true)
	else:
		particle.set_emitting(false)
```

![Trail Done](images/trail-done.gif)

Done! Sekarang particle sudah terlihat seperti trail jalan player!

## Game Balancing

### Balancing Spawn Rate

Sekarang kita akan mencoba untuk melakukan balancing pada game yang sudah kita buat. Untuk itu sudah disediakan template scene ```Spawner.tscn```, masukkan scene tersebut ke Level 1, di akhir platform tengah (posisi transform x 1700 y 280). Lalu coba mainkan gamenya.

![Unbalanced](images/unbalanced.gif)

Dapat dilihat bahwa kita sebagai pemain tidak dapat menyelesaikan permainan dikarenakan spawner terlalu banyak memunculkan musuh, sehingga pemain tidak dapat melompati tikus-tikus yang ada untuk menuju akhir level. Oleh karena itu perlu dilakukan game balancing terhadap game ini. Coba kamu mainkan lagi dan coba pikirkan apa yang kira kira membuat pemain tidak bisa melompati tikus-tikus yang ada. Setelah memainkan beberapa kali, semoga kamu menyadari bahwa karena terlalu banyak tikus dan ***Spawn Rate** antar tikus terlalu kecil, membuat tidak ada celah yang dapat dimanfaatkan pemain untuk melewati rintangan tersebut. Dan jika kamu sudah melihat tab inspector pada Spawner, sudah disedikan variable ```Spawn Rate``` yang dapat diubah, coba ubah menjadi 2 detik dan coba mainkan kembali.

![Too Easy](images/too-easy.gif)

Hmm pemain sudah bisa melewati rintangan untuk mencapai akhir level. Namun sepertinya pemain dapat melakukan hal itu dengan cukup mudah. Ingat, kita harus dapat membuat pemain berada dalam [***FLOW***](https://www.gamasutra.com/view/feature/166972/cognitive_flow_the_psychology_of_.php) agar pemain tidak merasa permainan terlalu mudah ataupun terlalu sulit. Oleh karena itu, silahkan cari nilai yang menurut kamu tepat sebagai ```Spawn Rate```. Dalam tutorial ini, akan menggunakan nilai 1 sebagai ```Spawn Rate``` yang digunakan. Setelah kalian mencoba dan menemukan nilai ```Spawn Rate``` yang tepat menurut kalian, coba mainkan kembali untuk memastikan bahwa level sudah balanced.

![Balanced](images/balanced.gif)

Selamat, tutorial ini sudah selesai!

## Bonus To Do

Apabila masih ada waktu atau ingin lanjut berlatih mandiri, silakan baca
referensi yang tersedia untuk belajar mengimplementasikan fitur tambahan.
Tidak ada kriteria khusus untuk ini, kamu bebas menambahkan apapun yang kamu
suka. Karena materi tutorial ini dibagi dua, game polishing dan game balancing,
kamu harus mengeksplorasi keduanya. Beberapa contoh yang bisa dikerjakan:

- Menambah particle lagi.
- Menambah efect saat player mati.
- Melakukan level design agar level balanced.
- dll. _Get creative!_

Jika mengerjakan fitur tambahan, buat file baru bernama `T9_[NPM].md` dimana
`[NPM]` adalah NPM kamu (misal: `t9_1506757913`) di folder yang sama dengan
[`README.md`](README.md) ini. Tulis teks menggunakan format [Markdown](https://docs.gitlab.com/ee/user/markdown.html).

## Instruksi Pengerjaan

1. Dalam repositori pribadi kamu, silakan sinkronisasi _branch_ ```master``` dengan repositori _upstream_.
   Instruksi lebih lanjut bisa dibaca [disini](https://help.github.com/en/articles/syncing-a-fork).
2. Jika terdapat _conflict_, mohon diselesaikan secara damai.
   Jika tidak yakin bagaimana caranya, silakan ambil mata kuliah *Advanced Programming* atau baca [ini](https://help.github.com/en/articles/resolving-a-merge-conflict-using-the-command-line).
3. Setelah semua selesai, buat _branch_ baru dari _branch_ ```master``` dengan nama ```tutorial-x``` dimana ```x``` adalah nomor tutorial (misal: tutorial-4).
4. Ganti _current branch_ menjadi ```tutorial-x``` tersebut, silakan kerjakan tutorial di dalam _branch_ yang bersangkutan.
   Setiap _branch_ tutorial **tidak perlu** di _merge_ ke _branch_ ```master```.

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

Tenggat waktu pengumpulan adalah **Jumat, 4 Desember 2020, pukul 21:00**.

## Referensi

- [Particle System 2D](https://docs.godotengine.org/en/3.1/tutorials/2d/particle_systems_2d.html)
- [Particles2D](https://docs.godotengine.org/en/3.1/classes/class_particles2d.html)
- [Kenney Assets](https://www.kenney.nl/assets/platformer-pack-redux)
- Materi tutorial pengenalan Godot Engine, kuliah Game Development semester
  gasal 2020/2021 Fakultas Ilmu Komputer Universitas Indonesia.
