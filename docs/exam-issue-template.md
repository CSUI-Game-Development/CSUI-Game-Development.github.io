# Exam Issue Template

The following is the issue template for describing the programming task during
the final exam. Each student will receive the issue on their own GitLab/GitHub
repository.

> Indonesian / Bahasa Indonesia

```markdown
# Ujian Akhir Semester (UAS)

> CSCE604121 Game Development - Fakultas Ilmu Komputer Universitas Indonesia

## Tata Tertib Ujian & Komponen Penilaian

Silakan lihat dokumen _cover page_ UAS yang telah tersedia di laman Scele kuliah.
Kerjakan _issue_ secara mandiri di dalam _branch_ baru bernama `uas`.
Kumpulkan hasil pekerjaan ke laman Scele kuliah dalam bentuk teks tautan (URL)
ke Merge/Pull Request atau _branch_ `uas` di GitLab/GitHub proyek game individu.

## Deskripsi Tugas

> TODO: Diisi oleh tim pengajar (dosen dan/atau asisten). Isi dengan deskripsi
> mengenai penambahan atau perbaikan fitur pada game individu yang perlu
> dikerjakan oleh peserta ujian. Deskripsi harus mengandung daftar tugas yang
> wajib dikerjakan dan opsional (jika ada).

## Instruksi Pengerjaan

> Instruksi berikut dituliskan dengan menggunakan GitLab sebagai acuan. Apabila
> peserta menggunakan GitHub atau repositori Git daring lain sebagai penyimpanan
> _codebase_ proyek game individu, maka pastikan asisten dapat membuat _issue_
> baru di _issue tracker_ dan memiliki hak akses untuk melihat isi repositori Git.

1. Jika kamu mengerjakan ujian di komputer yang berbeda dari biasanya, buat
   salinan (_clone_) dari _source code_ game _individual gamejam_ kamu ke
   komputer menggunakan perintah `git clone`.

   ```bash
   git clone https://gitlab.com/<username GitLab>/<nama project GitLab>
   ```

2. Pastikan repositori Git di komputermu telah mengandung _source code_
   versi terkini dari game _individual gamejam_.

   ```bash
   cd <nama folder repositori Git lokal>
   git checkout <nama branch utama, misal: `master` atau `main`>
   git pull
   ```

3. Buat _branch_ baru berdasarkan _commit_ terakhir di _branch_ utama untuk
   mulai mengerjakan UAS.

   ```bash
   git checkout -b uas
   ```

4. Mulai mengerjakan UAS. Jangan lupa untuk menyimpan hasil pekerjaanmu dengan
   membuat _commit_ dan _push_ ke repositori Git daring di GitLab.

   ```bash
   git add <berkas baru atau berkas hasil edit>
   git commit -m "<pesan commit>"
   git push
   ```

5. Buat Merge Request (MR) melalui GitLab untuk mengintegrasikan _branch_ `uas`
   ke _branch_ utama. Pastikan _source branch_ ketika membuat MR adalah
   _branch_ `uas` lalu _target branch_ adalah _branch_ utama.

6. _Assign_ dirimu sendiri sebagai **_Assignee_** MR, kemudian _assign_ asisten
   mentor kelompokmu sebagai **_Reviewer_** MR.

7. Hubungi dosen untuk mengatur jadwal tatap muka dan demonstrasi hasil
   pengerjaan UAS.

8. Setelah tatap muka dan demonstrasi, silakan _merge_ ke _branch_ utama.

Selamat mengerjakan!

/estimate 2h
```
