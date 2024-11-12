# Dokumentasi Detail Aplikasi To-Do List Flutter

## Daftar Isi

1. [Struktur Proyek](#struktur-proyek)
2. [Palet Warna](#palet-warna)
3. [Fitur Utama](#fitur-utama)
4. [Komponen UI](#komponen-ui)
5. [State Management](#state-management)
6. [Penyimpanan Data](#penyimpanan-data)
7. [Notifikasi](#notifikasi)
8. [Validasi](#validasi)
9. [Animasi](#animasi)
10. [Internationalization](#internationalization)
11. [Workflow Pengembangan](#workflow-pengembangan)
12. [Best Practices](#best-practices)

## Struktur Proyek

```dart
lib/
├── main.dart                 # Entry point aplikasi
├── models/                   # Model data
│   └── task.dart            # Model untuk task
├── providers/               # State management
│   ├── task_provider.dart   # Provider untuk manajemen task
│   └── theme_provider.dart  # Provider untuk manajemen tema
├── screens/                 # Layar utama aplikasi
│   ├── home_screen.dart     # Layar utama
│   ├── add_task_screen.dart # Layar tambah task
│   └── edit_task_screen.dart# Layar edit task
├── services/                # Layanan aplikasi
│   ├── database_helper.dart # Helper untuk database SQLite
│   └── notification_service.dart # Layanan notifikasi
├── utils/                   # Utilitas
│   ├── color_palette.dart   # Definisi warna
│   ├── theme_data.dart      # Konfigurasi tema
│   └── date_time_helper.dart# Helper untuk format tanggal
└── widgets/                 # Widget yang dapat digunakan kembali
    └── task_item.dart       # Widget item task
```

## Palet Warna

### Mode Terang (Light Mode)

- **Primary**: `#3B82F6` - Biru utama untuk elemen-elemen penting
- **Secondary**: `#8B5CF6` - Ungu untuk aksen sekunder
- **Accent**: `#F59E0B` - Kuning untuk highlight
- **Background**: `#F3F4F6` - Abu-abu sangat terang untuk latar
- **Surface**: `#FFFFFF` - Putih untuk kartu dan permukaan
- **Text**: `#111827` - Abu-abu sangat gelap untuk teks
- **Muted**: `#9CA3AF` - Abu-abu untuk teks sekunder
- **Action Colors**:
  - Create: `#10B981` - Hijau untuk aksi pembuatan
  - Read: `#3B82F6` - Biru untuk aksi membaca
  - Update: `#F59E0B` - Oranye untuk aksi update
  - Delete: `#EF4444` - Merah untuk aksi hapus

### Mode Gelap (Dark Mode)

- **Primary**: `#60A5FA` - Biru terang untuk elemen-elemen penting
- **Secondary**: `#A78BFA` - Ungu terang untuk aksen sekunder
- **Accent**: `#FBBF24` - Kuning terang untuk highlight
- **Background**: `#1F2937` - Abu-abu gelap untuk latar
- **Surface**: `#111827` - Abu-abu sangat gelap untuk kartu
- **Text**: `#F9FAFB` - Putih untuk teks
- **Muted**: `#6B7280` - Abu-abu terang untuk teks sekunder
- **Action Colors**:
  - Create: `#34D399` - Hijau terang untuk aksi pembuatan
  - Read: `#60A5FA` - Biru terang untuk aksi membaca
  - Update: `#FBBF24` - Oranye terang untuk aksi update
  - Delete: `#F87171` - Merah terang untuk aksi hapus

## Fitur Utama

### 1. Manajemen Task

- Pembuatan task baru dengan deskripsi
- Pengaturan tanggal dan waktu task
- Penandaan task selesai/belum
- Pengeditan task yang ada
- Penghapusan task

### 2. Notifikasi

- Notifikasi lokal untuk pengingat task
- Penjadwalan notifikasi otomatis
- Pembatalan notifikasi saat task selesai/dihapus

### 3. Tema Aplikasi

- Dukungan mode terang dan gelap
- Penyimpanan preferensi tema
- Transisi halus antar tema

## Komponen UI

### 1. AppBar Design

- **Shadow & Elevation**

  - Elevation: 4
  - Shadow Color:
    - Light Mode: `Colors.black26`
    - Dark Mode: `Colors.black45`
  - Rounded Bottom Corners: `20.0`
  - Center Title: `true`

- **Font Style**

  - Font Family: Roboto
  - Title Size: 20
  - Font Weight: Bold
  - Color: White

- **Theme Integration**
  - Dynamic background color based on theme
  - Consistent shadow across all screens
  - Smooth theme transition

### 2. TaskItem Widget

- Tampilan kartu untuk setiap task
- Checkbox untuk status completion
- Tombol edit dan hapus
- Animasi fade saat status berubah

### 3. AddTaskScreen

- Form input deskripsi task
- Date picker untuk tanggal
- Time picker untuk waktu
- Validasi input

### 4. EditTaskScreen

- Pre-filled form dengan data task
- Fungsi update task
- Validasi perubahan

## Typography

### Font System

- **Primary Font**: Roboto (Google Fonts)
- **Weights Used**:
  - Regular (400)
  - Medium (500)
  - Bold (700)

### Text Styles

- **AppBar Title**

  ```dart
  GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  )
  ```

- **Task Description**

  ```dart
  GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: theme.textColor,
  )
  ```

- **Button Text**
  ```dart
  GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  )
  ```

### Theme Integration

- Global font family setting
- Dynamic text colors based on theme
- Consistent typography across screens

## Theme Configuration

### AppBar Theme

```dart
appBarTheme: AppBarTheme(
  backgroundColor: isDarkMode ? ColorPalette.primaryDark : ColorPalette.primaryLight,
  foregroundColor: Colors.white,
  elevation: 4,
  shadowColor: isDarkMode ? Colors.black45 : Colors.black26,
  centerTitle: true,
  titleTextStyle: GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(20),
    ),
  ),
),
```

### Text Theme

```dart
textTheme: GoogleFonts.robotoTextTheme().copyWith(
  bodyLarge: GoogleFonts.roboto(color: textColor),
  bodyMedium: GoogleFonts.roboto(color: textColor),
  titleLarge: GoogleFonts.roboto(
    color: textColor,
    fontWeight: FontWeight.bold,
  ),
),
```

## State Management

### TaskProvider

- Manajemen daftar task
- Operasi CRUD task
- Integrasi dengan database
- Pengelolaan notifikasi

### ThemeProvider

- Manajemen tema aplikasi
- Penyimpanan preferensi
- Toggle tema

## Penyimpanan Data

### Database SQLite

- Tabel tasks dengan kolom:
  - id (TEXT PRIMARY KEY)
  - description (TEXT)
  - date (TEXT)
  - time (TEXT)
  - isCompleted (INTEGER)

### Shared Preferences

- Penyimpanan preferensi tema
- Cache data aplikasi

## Notifikasi

### Konfigurasi

- Channel ID: 'todo_tasks'
- Channel Name: 'Task Reminders'
- Importance: max
- Priority: high

### Fitur

- Notifikasi tepat waktu
- Vibration dan sound
- Icon aplikasi sebagai notification icon
- Cancellation otomatis

## Validasi

### Input Task

- Deskripsi tidak boleh kosong
- Minimal 3 karakter
- Tanggal tidak boleh di masa lalu
- Waktu harus valid

### Update Task

- Validasi sama dengan input
- Pengecekan perubahan

## Animasi

### UI Animations

- Fade in/out untuk task items
- Scale animation untuk buttons
- Smooth transitions untuk tema

### Feedback

- Haptic feedback untuk actions
- Visual feedback untuk errors

## Internationalization

### Bahasa

- Default: Bahasa Indonesia
- Format tanggal lokal
- Format waktu 24 jam

## Workflow Pengembangan

### 1. Persiapan

- Setup Flutter project
- Instalasi dependencies
- Konfigurasi Android Manifest

### 2. Implementasi

- Pembuatan models
- Setup providers
- Pembuatan UI
- Integrasi database
- Setup notifikasi

### 3. Testing

- Unit testing
- Widget testing
- Integration testing

## Dependencies Update

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.1.0 # Added for Roboto font
  # ... other dependencies remain the same
```

## Best Practices

### Kode

- Penggunaan const constructors
- Proper error handling
- Clean architecture
- Dokumentasi kode

### UI/UX

- Material Design guidelines
- Responsive layout
- Accessibility support
- User feedback

### Performa

- Lazy loading
- Efficient state management
- Memory management
- Battery optimization

### UI Design

- Consistent shadow and elevation across all screens
- Proper font hierarchy using Roboto
- Smooth theme transitions
- Responsive text sizing
- Proper contrast ratios for accessibility

### Performance

- Font caching with google_fonts
- Efficient theme switching
- Optimized shadow rendering
- Minimal rebuilds during theme changes

```


```
