# MobileTask - PokeApp

Aplikasi ini dibuat untuk memenuhi tugas MobileTask menggunakan API [PokeAPI](https://pokeapi.co/). Aplikasi dibangun menggunakan **SwiftUI**.

---

## Fitur Utama

1. **Login & Registrasi**
   - Menggunakan local database Realm
   - Menyimpan data user secara lokal

2. **Landing Page**
   - Terdiri dari 2 tab:
     - **Home:** Menampilkan daftar nama Pokémon
     - **Profile:** Menampilkan data user yang login

3. **Home**
   - Menampilkan list nama Pokémon sebanyak 10
   - Scroll ke bawah untuk memuat Pokémon berikutnya (pagination)
   - Search bar untuk mencari Pokémon berdasarkan nama
   - Klik pada Pokémon untuk masuk ke halaman **Detail**:
     - Menampilkan nama Pokémon
     - Menampilkan abilities Pokémon

4. **Profile**
   - Menampilkan data user yang sedang login

5. **Offline Support (Optional)**
   - Pokémon yang sudah di-load sebelumnya bisa diakses ketika user offline

---

## Library yang Digunakan

- **Alamofire**: Networking
- **RxSwift**: Reactive programming
- **MBProgressHUD**: Loading indicator
- **XLPagerTabStrip**: Membuat tab di landing page
- **Local Database**: Realm

---

## Struktur Proyek (Jika Menggunakan Clean Architecture)

- **Core / Domain**
  - Entity
  - UseCase / Interactor
  - Repository Protocol
- **Data**
  - RemoteDataSource
  - LocalDataSource
  - Repository Implementation
- **Presentation**
  - View / ViewController / SwiftUI View
  - ViewModel
- **App**
  - 
