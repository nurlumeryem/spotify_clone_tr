# 🎧 Spotify Clone TR

Flutter ile geliştirilmiş, Spotify'dan ilham alan modern bir müzik dinleme uygulaması. Bu proje; Clean Architecture, Firebase ile kimlik doğrulama, Supabase ile medya depolama ve BLoC ile durum yönetimini içermektedir.

![Ekran Görüntüsü](assets/screenshots/darkmodehome.png)

## ✨ Özellikler

- 🎵 Supabase üzerinden albüm, şarkı ve çalma listesi gösterimi (Storage + Database)
- 🔐 Firebase ile kullanıcı kimlik doğrulama (Email/Şifre)
- 📱 Farklı ekran boyutlarına duyarlı responsive tasarım
- 💾 SharedPreferences ile kalıcı veri saklama
- 🔁 GoRouter ile sayfalar arası gezinme
- 🎧 just_audio paketiyle müzik oynatma
- 📂 file_picker ile cihazdan dosya seçimi
- 🎯 Domain, Data ve Presentation katmanları ile Clean Architecture yapısı

## 📁 Proje Yapısı

```
lib/
├── common/
│   └── widgets/
├── core/
├── data/
├── domain/
├── presentation/
├── service/
├── firebase_options.dart
├── main.dart
└── service_locator.dart
```

## 🔌 Kullanılan Teknolojiler & Paketler

- **Flutter SDK**
- **Durum Yönetimi**: `flutter_bloc`, `bloc`
- **Navigasyon**: `go_router`
- **Bağımlılık Yönetimi**: `get_it`
- **Firebase**: `firebase_core`, `firebase_auth`, `cloud_firestore`
- **Supabase**: `supabase`, `flutter_dotenv`
- **Medya İşleme**: `just_audio`, `file_picker`, `flutter_svg`
- **Diğerleri**: `equatable`, `shared_preferences`, `http`, `fpdart`

## 🛠️ Kurulum ve Başlatma

1. **Projeyi klonlayın**

   ```bash
   git clone https://github.com/yourusername/spotify_clone_tr.git
   cd spotify_clone_tr
   ```

2. **Bağımlılıkları yükleyin**

   ```bash
   flutter pub get
   ```

3. **.env dosyasını oluşturun**
   - Proje kök dizinine `.env` dosyası ekleyin
   - Supabase ve Firebase anahtarlarınızı tanımlayın

4. **Projeyi çalıştırın**

   ```bash
   flutter run
   ```

## 🔐 Kimlik Doğrulama

- Firebase Authentication üzerinden giriş/kayıt akışları sağlanır.
- `firebase_options.dart` dosyasında konfigüre edilmiştir.

## ☁️ Backend

- Şarkı metadata ve görselleri Supabase üzerinden yönetilmektedir.
- Ek kullanıcı verileri ve ilişkileri için Firestore kullanılmıştır.

## 🧠 Mimarî

Proje **Clean Architecture** prensiplerine göre yapılandırılmıştır:

- **Domain Katmanı**: iş kuralları, use case’ler, entity’ler
- **Data Katmanı**: repository’ler, veri kaynakları
- **Presentation Katmanı**: UI, BLoC ve routing

## 💡 Gelecek Geliştirmeler

- Kullanıcı playlist ve favoriler sistemi
- Gerçek zamanlı yorum/chat sistemi (Supabase Realtime)
- Çoklu dil desteği (i18n)
- Tema değişimi (Açık/Koyu)

## 📸 Ekran Görüntüsü

| Koyu Mod Ana Ekran |
|---------------------|
| ![Home](assets/screenshots/darkmodehome.png) |

## 🧑‍💻 Geliştirici

- **[Adınız Soyadınız]**
- LinkedIn: <https://www.linkedin.com/in/meryemnurlu/>
- GitHub: <https://github.com/nurlumeryem>
