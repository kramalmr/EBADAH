# EBADAH

Aplikasi pendamping ibadah Islami modern yang dibuat menggunakan Flutter.  
EBADAH membantu pengguna mengakses doa harian, dzikir, dan konten Islami dalam pengalaman mobile yang bersih dan terorganisir.

---

## 📱 Tampilan Aplikasi

<p align="center">
  <img src="assets/screenshots/home.png" width="22%" />
  <img src="assets/screenshots/prayer_time.png" width="22%" />
  <img src="assets/screenshots/doa_page.png" width="22%" />
  <img src="assets/screenshots/qibla.png" width="22%" />
</p>

---

## ✨ Fitur

- 📖 Koleksi Doa Harian
- 🤲 Konten Dzikir & Doa
- 🗂️ Kategori yang Terorganisir
- 💾 Penyimpanan Database Lokal (SQLite)
- ⚡ Akses Offline Cepat
- 🎨 Tampilan Flutter yang Modern
- 🔍 Fitur Pencarian & Penjelajahan
- 📱 Layout Responsif untuk Mobile

---

## 🛠️ Teknologi yang Digunakan

- Flutter
- Dart
- SQLite
- Data Lokal JSON
- Material Design

---

## 📂 Struktur Project

```bash
lib/
├── models/
│   └── doa_model.dart
├── services/
│   └── doa_service.dart
├── database/
│   └── database_helper.dart
├── screens/
├── widgets/
└── main.dart
```

---

## 🗄️ Alur Database

Aplikasi menggunakan:

- `doa_input.json` → data dummy/local doa
- `database_helper.dart` → pembuatan database & tabel SQLite
- `doa_service.dart` → insert dan mengambil data
- `doa_model.dart` → model data doa

Data dari file JSON dimasukkan ke database SQLite lokal dan ditampilkan secara dinamis di dalam aplikasi.

---

## 🚀 Cara Menjalankan Project

### 1. Clone Repository

```bash
git clone https://github.com/kramalmr/EBADAH.git
```

### 2. Masuk ke Folder Project

```bash
cd EBADAH
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Jalankan Aplikasi

```bash
flutter run
```

---

## 📦 Build APK

```bash
flutter build apk
```

Lokasi APK hasil build:

```bash
build/app/outputs/flutter-apk/app-release.apk
```

---

## 🎯 Pengembangan Selanjutnya

- 🔔 Notifikasi Waktu Sholat
- 🌙 Dark Mode
- ☁️ Sinkronisasi Cloud
- 📚 Penambahan Konten Islami
- 🔊 Dukungan Audio Doa
- ❤️ Fitur Doa Favorit

---

## 👨‍💻 Developer

Dibuat menggunakan Flutter oleh **Muhammad Akram Almair**

---

## 📄 Lisensi

Project ini dibuat untuk keperluan edukasi (tugas akhir kelas 11) dan portofolio.