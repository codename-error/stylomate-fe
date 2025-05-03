# Documentasi Flutter Instalasi

Persyaratan umum

- sistem operasi windows, mackOs, atau Linux
- Disk space minimal: 2.8 GB (tidak termasuk IDE/tools lainnya)
- Git (untuk clone Flutter SDK)

### 1. Instalasi di windows

    langkah-langkah

1. Donwload Flutter SDK
    - Buka [https://flutter.dev/docs/get-started/install/windows](https://flutter.dev/docs/get-started/install/windows)
    - Unduh Zip ZDK file dan ekstrak ke folder yang diinginkan
2. Tambahkan Flutter ke PATH
    - Buka Envoirentment Variable
    - Tambahkan C:\src\flutter\bin ke dalam user variables> PATH
3. Cek Instalasi
    - Jalankan
        
        ```json
        flutter doctor
        ```
        
4. Instalasi Android Studio
    - Unduh dari: https://[developer.android.com](https://developer.android.com/studio)
    - pastikan plugin Flutter dan Dart terpasang
5. Install SDK Android
    - via android Studio > SDK Manager

### 2. Instalasi di macOS

langkah-langkah

1. install Flutter SDK
    
    ```json
    git clone https://github.com/flutter/flutter.git -b stable
    ```
    
2. Tambahkan Flutter ke PATH
    
    tambahkan ini ke ~/.zshrc atau ~/.bash_profile:
    
    ```json
    export PATH="$PATH:`pwd`/flutter/bin"
    ```
    
3. Install XCode
    - untuk via App Store
    - Jalankan: sudo xcode-select —switch / Applications/Xcode.app/Contents/Developer
4. Cek Instalasi
    
    ```json
    flutter doctor
    ```
    

### Menjalankan di dalam aplikasi

1. Clone Github repository ke dalam komputer anda
    
    ```json
    git clone https://github.com/codename-error/stylomate-fe.git
    ```
    
2. Setelah dilakukan cloning maka selanjutnya menjalankan :

```json
flutter run
```

Aplikasi ini akan berjalan dengan lancar namun dependecies bisa berpengaruh jika anda gagal menjalankannya