# 📱 Gün 1: Flutter 3.27+ Yenilikleri ve Material 3

**⏱ Toplam Süre**: 2 saat  
**🎯 Hedef**: Flutter'ın en son özelliklerini öğrenmek ve Material 3 tasarım sistemini uygulamak

## 📋 Görevler Listesi

### 1. What's New in Flutter Oku (20 dakika)
- [ ] [Flutter 3.27 Release Notes](https://docs.flutter.dev/release/release-notes) oku
- [ ] Yeni özellikler listesini çıkar
- [ ] Breaking changes'leri not al

**Önemli Yenilikler:**
- Material 3 desteği
- Impeller rendering engine
- Web performans iyileştirmeleri
- Developer experience güncellemeleri

### 2. Material 3 Widget'larını Test Et (40 dakika)

#### Yeni Buton Türleri
```dart
// FilledButton - Ana eylemler için
FilledButton(
  onPressed: () {},
  child: Text('Filled Button'),
)

// FilledButton.tonal - İkincil eylemler için
FilledButton.tonal(
  onPressed: () {},
  child: Text('Tonal Button'),
)
```

#### Segmented Button
```dart
SegmentedButton<String>(
  segments: [
    ButtonSegment(value: 'day', label: Text('Gün')),
    ButtonSegment(value: 'week', label: Text('Hafta')),
  ],
  selected: {'day'},
  onSelectionChanged: (Set<String> selection) {
    // Handle selection
  },
)
```

#### Card Varyasyonları
```dart
// Filled Card
Card.filled(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Filled Card'),
  ),
)

// Outlined Card
Card.outlined(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Outlined Card'),
  ),
)
```

**Görevler:**
- [ ] Her bir widget türünü test et
- [ ] Farklı tema renklerini dene
- [ ] Responsive davranışları gözlemle

### 3. Impeller Rendering Oku (30 dakika)

**Impeller Nedir?**
- Flutter'ın yeni rendering engine'i
- Skia'nın yerini alan modern alternatif
- Daha iyi performans ve daha az jank

**Avantajları:**
- ✅ Daha hızlı rendering
- ✅ Daha az memory kullanımı
- ✅ Daha iyi battery life
- ✅ Smoother animasyonlar

**Görevler:**
- [ ] [Impeller Documentation](https://docs.flutter.dev/perf/impeller) oku
- [ ] Performans karşılaştırmalarını incele
- [ ] Platform desteğini kontrol et

### 4. Boş Projede Material 3 + Impeller Aktif Et (30 dakika)

#### Material 3 Aktifleştirme
```dart
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
    ),
  ),
)
```

#### Impeller Aktifleştirme
```bash
# iOS için
flutter run --enable-impeller

# Android için (varsayılan olarak aktif)
flutter run
```

**Görevler:**
- [ ] Yeni proje oluştur
- [ ] Material 3 tema uygula
- [ ] Impeller ile test et
- [ ] Performans farkını gözlemle

## 🎨 Pratik Egzersizler

### Egzersiz 1: Material 3 Showcase App
```dart
class Material3ShowcaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Material 3 Showcase')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Farklı buton türlerini ekle
            // Segmented button ekle
            // Card varyasyonlarını ekle
            // Chip'leri test et
          ],
        ),
      ),
    );
  }
}
```

### Egzersiz 2: Tema Karşılaştırması
- [ ] Material 2 vs Material 3 karşılaştırması yap
- [ ] Aynı widget'ları her iki tema ile test et
- [ ] Görsel farkları dokumenta et

## 📚 Kaynaklar

### Resmi Dokümantasyon
- [Flutter 3.27 Release Notes](https://docs.flutter.dev/release/release-notes)
- [Material 3 Documentation](https://docs.flutter.dev/ui/design/material)
- [Impeller Rendering Engine](https://docs.flutter.dev/perf/impeller)

### Video Kaynakları
- [What's New in Flutter (Google I/O)](https://www.youtube.com/watch?v=example)
- [Material 3 Design System](https://www.youtube.com/watch?v=example)

### Blog Yazıları
- [Material 3 Migration Guide](https://material.io/blog/material-3-flutter)
- [Impeller Performance Benefits](https://medium.com/flutter/example)

## ✅ Tamamlama Kriterleri

Bu görevi tamamlamış sayılırsınız eğer:

- [ ] Flutter 3.27 yeniliklerini okudunuz
- [ ] Material 3 widget'larını test ettiniz
- [ ] Impeller hakkında temel bilgi sahibi oldunuz
- [ ] Boş projede Material 3 + Impeller aktif ettiniz
- [ ] En az 5 farklı Material 3 widget'ı kullandınız

## 📝 Günlük Notlar

### Öğrendiklerim
- 
- 
- 

### Karşılaştığım Zorluklar
- 
- 
- 

### Yarına Hazırlık
- [ ] Riverpod dokümantasyonuna göz at
- [ ] State management kavramlarını hatırla

---

**Sonraki Gün**: [Gün 2 - Riverpod State Management](../day2_riverpod_state/) 