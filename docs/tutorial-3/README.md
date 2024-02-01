# Tutorial 3 - Introduction to Scripting w/ GDScript for Implementing Basic 2D Game Mechanics

Selamat datang pada tutorial ketiga kuliah Game Development. Pada tutorial
kali ini, kamu akan mempelajari dasar-dasar _syntax_ bahasa utama Godot Engine, GDScript beserta penggunaannya dalam konsep _node_ dan _object_ Godot Engine. Di akhir tutorial ini,
diharapkan kamu paham dengan penggunaan GDScript serta penerapan mekanik dasar _2D Platformer_.

## Daftar Isi

- [Tutorial 3 - Introduction to Scripting w/ GDScript for Implementing Basic 2D Game Mechanics](#tutorial-3---introduction-to-scripting-w-gdscript-for-implementing-basic-2d-game-mechanics)
  - [Daftar Isi](#daftar-isi)
  - [Pengantar](#pengantar)
    - [Is Scripting an Instrument?](#is-scripting-an-instrument)
    - [GDScript Example](#gdscript-example)
  - [Basic 2D Plane Movement](#basic-2d-plane-movement)
    - [Setting things up](#setting-things-up)
    - [Making a Script](#making-a-script)
    - [Writing and Using a Script](#writing-and-using-a-script)
    - [Gravity and Jumping](#gravity-and-jumping)
    - [KinematicBody2D vs RigidBody2D](#kinematicbody2d-vs-rigidbody2d)
  - [Extra: Mechanic Exploration](#extra-mechanic-exploration)
  - [Skema Penilaian](#skema-penilaian)
  - [Pengumpulan](#pengumpulan)
  - [Referensi](#referensi)

## Pengantar

### Is Scripting an Instrument?

Scripting Language merupakan istilah untuk bahasa pemrograman yang tidak perlu di-_compile_ sepenuhnya untuk dijalankan. Beberapa bahasa Scripting yang terkenal adalah Javascript dan Python.

Dasarnya, ada empat (4) bahasa pemrograman yang dapat digunakan dalam Godot Engine (GDScript, Visual Script, C#, C++). Pada Matakuliah Game Development ini akan diajarkan salah satu dari bahasa yang disediakan, yakni GDScript. Bahasa ini digunakan karena:

- Integrasi penuh dengan Godot Engine dan Godot Editor
- Sederhana dan cepat
- Mirip dengan bahasa scripting (Python, Lua, dll.)

### GDScript Example

Contoh sebuah script dalam GDScript adalah berikut:

```
# example.gd

# A file is a class!

# Inheritance

extends BaseClass

# (optional) class definition with a custom icon

class_name MyClass, "res://path/to/optional/icon.svg"

# Member Variables

var a = 5
var s = "Hello"
var arr = [1, 2, 3]
var dict = {"key": "value", 2:3}
var typed_var: int
var inferred_type := "String"

# Constants

const ANSWER = 42
const THE_NAME = "Charly"

# Enums

enum {UNIT_NEUTRAL, UNIT_ENEMY, UNIT_ALLY}
enum Named {THING_1, THING_2, ANOTHER_THING = -1}

# Built-in Vector Types

var v2 = Vector2(1, 2)
var v3 = Vector3(1, 2, 3)

# Function

func some_function(param1, param2):
    var local_var = 5

    if param1 < local_var:
        print(param1)
    elif param2 > 5:
        print(param2)
    else:
        print("Fail!")

    for i in range(20):
        print(i)

    while param2 != 0:
        param2 -= 1

    var local_var2 = param1 + 3
    return local_var2

# Functions override functions with the same name on the base/parent class.
# If you still want to call them, use '.' (like 'super' in other languages).

func something(p1, p2):
    .something(p1, p2)

# Inner Class

class Something:
    var a = 10

# Constructor

func _init():
    print("Constructed!")
    var lv = Something.new()
    print(lv.a)
```

> Catatan: Dokumentasi penuh ada pada link berikut:
> https://docs.godotengine.org/en/3.1/getting_started/scripting/gdscript/gdscript_basics.html#doc-gdscript

## Basic 2D Plane Movement

Kita akan membuat sebuah objek Kinematic2D yang dapat bergerak ke kiri dan ke kanan serta melompat. Tutorial ini akan mendemonstrasikan:

- Membuat sebuah objek Kinematic2D dengan child Collision2D dan Sprite
- Membuat Script dan memasangkan Script tersebut ke suatu node
- Implementasi Physics dasar

### Setting things up

Buka Project Godot tutorial ini dalam Godot Editor, kemudian pada FileSystem buka folder Scenes. Buka scene ```Main.tscn```. Akan terdapat Ground yang melayang dalam scene tersebut. Kita akan menaruh sesuatu yang dapat bergerak disana.
![Tampilan Main.tscn](images/main-scene.PNG)

Buat Scene baru dan tambahkan Node Kinematic2D pada scene tersebut. Ubah nama node tersebut menjadi Player. Tambahkan child node Sprite dan CollisionShape2D dengan menggunakan menu Add Child Node.

![Dialogue box New Scene](images/new-scene-menu.png)
![Dialogue box Node Selection](images/node-selection.png)
![Dialogue box Node Selection](images/child-node-selection.png)
![Susunan Scene](images/tree-structure.png)

Pilih node CollisionShape2D dan buka panel Inspector. Tambahkan Shape pada node tersebut dengan memilih new RectangleShape2D.

![Inspector CollisionShape2D](images/collision-inspector.png)

Pilih node Sprite dan buka panel Inspector. Pada menu texture, pilih menu Load dan buka folder Assets, kemudian pilih salah satu dari sprite pesawat yang ada.

![Inspector Sprite](images/sprite-inspector.png)

Save Scene tersebut dalam folder Scenes. Objek ini akan menjadi target scripting.
> Catatan: Nama node, scene, dan pilihan sprite dibebaskan. Kamu diperbolehkan untuk menggunakan aset milik sendiri.

Tampilan Godot Editor terdiri dari beberapa panel yang akan dijelaskan
sebagai berikut:

### Making a Script

Pada panel Scene, klik kanan pada node Player. Pilih Attach Script pada menu yang muncul. Akan muncul dialog untuk membuat script. Akan ada beberapa pilihan yang tersedia, diantaranya nama script, bahasa script, dll.

Karena script akan dipasang pada KinematicBody2D, script otomatis meng-_inherit_ class tersebut. Pada dasarnya, ini adalah skema dari GDScript, karena kita ingin menambahkan fungsionalitas baru pada node yang kita inginkan.

Ubah nama script menjadi `Player.gd` kemudian simpan script pada folder script.

![Attach Script Box](images/attach-node-dialogue.png)

Script akan otomatis terbuka pada Godot Editor. Setiap script yang dibuat akan diberikan template:

![Script editor](images/script-editor.png)

Terdapat dua fungsi dasar yang hampir selalu ada pada bermacam-macam script: `_ready()` dan _process. Fungsi `_ready()` akan selalu dipanggil ketika sebuah node menjadi aktif pada sebuah scene. Fungsi `_process(delta)` akan dipanggil berkala pada setiap frame update.

> Catatan: Game Engine memroses banyak frame dalam satu detik. Tergantung hardware, rata-rata komputer memiliki kecepatan proses 60 _frames per second_ (fps). Artinya, dalam satu detik fungsi `_process(delta)` dipanggil 60 kali.
> Bagi yang sudah mengenal engine Unity dan/atau Unreal, kedua fungsi ini memiliki fungsi yang sama dengan `Awake()`/`Start()` dan `Update()`.

### Writing and Using a Script

Sebuah script jika dipasang ke suatu node akan memberikan node tersebut atribut tambahan. Script dapat digunakan untuk mengendalikan node tersebut dan semua child node yang ada.

Tujuan kita adalah menggerakan node Player secara horizontal. Tambahkan cuplikan kode ini pada `Player.gd`:

```
extends KinematicBody2D

export (int) var speed = 400

var velocity = Vector2()

func get_input():
    velocity = Vector2()
    if Input.is_action_pressed('right'):
        velocity.x += speed
    if Input.is_action_pressed('left'):
        velocity.x -= speed

func _physics_process(delta):
    get_input()
    velocity = move_and_slide(velocity)
```

Perhatikan hal-hal berikut:

1. `export (int) var speed = 400` merupakan deklarasi variabel. Export membuat variabel speed dapat diakses lewat visual editor.
2. `var velocity = Vector2()` adalah deklarasi private variable Vector2. Vector2 adalah tipe data Vector built-in Godot yang memiliki dua arah (x,y).
3. `get_input()` adalah wrapper function untuk membaca input kemudian menambahkan velocity (kecepatan) pada Player.
3. `Input.is_action_pressed(String signal)` merupakan fungsi bawaan Godot yang membaca input.
4. `_physics_processs(delta)` dipanggil secara berkala untuk membaca input.
4. `move_and_slide(Vector2 vector)` merupakan fungsi KinematicBody2D. Ketika fungsi ini dipanggil, KinematicBody2D akan bergerak sebanyak input Vector2.

> Catatan: _physics_process(delta) tidak jauh berbeda dari _process(delta). Fungsi ini dipanggil secara berkala, namun memiliki waktu panggil yang konstan tanpa bergantung pada fps.

Jalankan Scene dan gunakan arrow keys. Player dapat bergerak secara horizontal.

### Gravity and Jumping

Jika dilihat, Player hanya bergerak horizontal dan tidak dipengaruhi gravitasi. Objek Player tetap diam diatas meskipun tidak berada pada suatu pijakan. Hal ini merupakan karakteristik dari KinematicBody2D, dimana node _tidak_ dipengaruhi oleh physics yang tersedia dari Game Engine.

### KinematicBody2D vs RigidBody2D

Salah satu alasan mengapa kita tidak memakai RigidBody2D yang dapat dipengaruhi physics Game Engine adalah konsistensi. Dengan memakai KinematicBody2D, objek yang digerakan oleh pemain akan selalu merespon terhadap input yang diberikan, dimana objek RigidBody2D akan mudah terpengaruh oleh physics diluar kendali pemain.

Apabila kita ingin membuat Player kita melompat, maka kita harus bisa membuat Player dipengaruhi gravitasi. Setidaknya, Player harus bisa jatuh. Untuk itu, kita harus menambahkan fungsi physics sendiri, karena kita tidak bisa menggunakan gravitasi Game Engine. Tambahkan baris berikut pada `Player.gd`:

```
extends KinematicBody2D

export (int) var speed = 400
export (int) var GRAVITY = 1200

const UP = Vector2(0,-1)

var velocity = Vector2()

func get_input():
    velocity.x = 0
    if Input.is_action_pressed('right'):
        velocity.x += speed
    if Input.is_action_pressed('left'):
        velocity.x -= speed

func _physics_process(delta):
    velocity.y += delta * GRAVITY
    get_input()
    velocity = move_and_slide(velocity, UP)
```

Beberapa hal yang ditambahkan:

1. Variabel `GRAVITY` sebagai angka arbitrer.
2. Konstanta `UP` merupakan _shorthand_ untuk Vector2 yang mengarah keatas. Pada Godot Engine, koordinat y negatif mengarah keatas.
3. `velocity.x = 0` memastikan bahwa Player akan berhenti apabila tidak ada tombol yang ditekan.
4. `velocity.y += delta * GRAVITY` merupakan fungsi gravitasi untuk Player. Setiap diproses, `velocity.y` Player ditambahkan sejumlah konstanta gravitasi (mengarah kebawah).

Jalankan scene. Objek Player akan jatuh.

![Visualisasi Gravitasi](images/fall.gif)

Sekarang Player kita butuh sebuah pijakan. Buka Scene Main.tscn. Tambahkan Scene (objek) Player pada scene main, kemudian jalankan scene. Player akan jatuh, namun berhenti ketika menyentuh tanah. Ketika di tanah, Player masih dapat bergerak secara horizontal.

![Visualisasi jatuh dan bergerak](images/ground_move.gif)

Apabila kita ingin Player melompat, salah satu cara yang bisa digunakan adalah mengubah `velocity.y` menjadi negatif. Tambahkan cuplikan kode pada `Player.gd`:

```
extends KinematicBody2D

export (int) var speed = 400
export (int) var jump_speed = -600
.
.
func get_input():
    velocity.x = 0
    if is_on_floor() and Input.is_action_just_pressed('up'):
        velocity.y = jump_speed
    if Input.is_action_pressed('right'):
        velocity.x += speed
    if Input.is_action_pressed('left'):
        velocity.x -= speed
.
.
```

Perhatikan bahwa:

1. `is_on_floor()` merupakan fungsi bawaan KinematicBody2D dimana node akan mengecek otomatis apabila Collider yang sedang bersentuhan merupakan floor atau bukan.
2. `Input.is_action_just_pressed('up')` merupakan fungsi input Godot Engine yang mengecek input pertama dari sebuah tombol.

Jalankan Scene. Player sekarang bisa melompat.

Selamat, kamu telah menyelesaikan tutorial ini!

![Melompat](images/jump.gif)

## Extra: Mechanic Exploration

Apabila masih ada waktu atau ingin lanjut berlatih mandiri, silakan baca referensi yang tersedia untuk belajar mengimplementasikan mekanik tambahan. Tidak ada kriteria khusus untuk ini, kamu bebas menambahkan apapun yang kamu suka. Beberapa contoh yang bisa diimplementasikan:

- Double Jump
- Dashing
- dll.

## Skema Penilaian

Pada tutorial ini, ada empat kriteria nilai yang bisa diperoleh:

1. **A** apabila kamu mengerjakan tutorial dan latihan melebihi dari ekspektasi
   tim pengajar.
1. **B** apabila kamu hanya mengerjakan tutorial sesuai yang diminta oleh
   deskripsi tutorial.
1. **C** apabila kamu mengerjakan tutorial secara minimalis atau tidak
   lengkap/tuntas.
1. **E** apabila kamu tidak mengerjakan apapun atau tidak mengumpulkan.

## Pengumpulan

Kumpulkan dengan memasukkan berkasnya ke dalam Git dan _push_ ke _fork_ materi
tutorial ini di repositori milik pribadi. **Jangan _push_ atau membuat Merge
Request ke repositori _upstream_ materi tutorial kecuali jika kamu ingin
kontribusi materi atau memperbaiki materi yang sudah dipublikasikan!**

Tenggat waktu pengumpulan adalah **20 September 2021 pukul 21:00**.

## Referensi

- [Kinematic Character (2D)](https://docs.godotengine.org/en/3.1/tutorials/physics/kinematic_character_2d.html)
- [Scripting](https://docs.godotengine.org/en/3.1/getting_started/step_by_step/scripting.html#scripting-a-scene)
- [2D Movement Overview](https://docs.godotengine.org/en/3.1/tutorials/2d/2d_movement.html)
- [Kenney Assets](https://kenney.nl/assets/platformer-characters-1)
- Materi tutorial pengenalan Godot Engine, kuliah Game Development semester
  gasal 2020/2021 Fakultas Ilmu Komputer Universitas Indonesia.
