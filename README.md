# README

README ini dokumentasi untuk menjalankan sebuah project atau applikasi.

## Persyaratan
* Ruby versi 2.6.3
* Mysql

## Berikut langkah-langkah untuk men-setup dan menjalankan aplikasi:
* Clone aplikasi projeck ke lokal
* Arahkan navigasi ke folder aplikasi projek
* Setelah berada di dalam folder projek, jalankan perintah ```bundle install```
* Buka database.yml (config/database.yml) dan ubah nilai username dan password sesuai yang ada di lokal mesin
* Di ruby, untuk membuat database tidak perlu file sql. Setelah database.yml disimpan, cukup jalankan perintah ```rails db:create```. Ini akan otomatis membuat database.
* Setelah database dibuat, langkah selanjutnya membuat tabel-tabelnya. jalankan perintah ```rails db:migrate```. Ini akan membuat tabel-tabel yang tersedia di db/migrate
* Untuk memastikan periksa kembali database yang telah dibuat
* Jika semuanya berjalan lancar, jalankan aplikasi dengan mengetik perintah ```rails server```
* Jika terjadi masalah email mimin di sann.lix@gmail.com
* Terakhir silahkan dicoba-coba :)

## Desain ERD
https://dbdiagram.io/d/5ee5f1179ea313663b3a8391

## Dokumentasi API
https://taptalktestapi.docs.apiary.io/#
