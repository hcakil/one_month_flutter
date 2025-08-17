# 🔧 Gün 2: State Management (Riverpod 3)

**⏱ Toplam Süre**: 2 saat  
**🎯 Hedef**: Modern state management ile Riverpod 3'ü öğrenmek ve uygulamak

## 📋 Görevler Listesi

### 1. Riverpod.dev İncele (30 dakika)
- [ ] [Riverpod Documentation](https://riverpod.dev/) oku
- [ ] Temel kavramları öğren
- [ ] Provider türlerini incele

**Önemli Kavramlar:**
- Provider: Veri kaynağı
- Consumer: Provider dinleyicisi
- StateNotifier: Karmaşık state logic
- AsyncValue: Async işlemler için wrapper

### 2. StateNotifierProvider ile Sayaç Örneği Yap (40 dakika)

#### Basit Sayaç Implementation
```dart
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
  void decrement() => state--;
  void reset() => state = 0;
}

final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});
```

#### UI'da Kullanım
```dart
Consumer(
  builder: (context, ref, child) {
    final count = ref.watch(counterProvider);
    return Text('Count: $count');
  },
)
```

**Görevler:**
- [ ] CounterNotifier sınıfını oluştur
- [ ] Provider'ı tanımla
- [ ] UI'da Consumer kullan
- [ ] Increment, decrement, reset fonksiyonlarını test et

### 3. Mini Görev: Riverpod ile Sayaç (30 dakika)

#### Gelişmiş Sayaç Özellikleri
- [ ] Async increment (1 saniye gecikme ile)
- [ ] Remote sayaç değeri fetch etme
- [ ] Error handling ile AsyncValue
- [ ] Loading states

#### Async Counter Implementation
```dart
class AsyncCounterNotifier extends StateNotifier<AsyncValue<int>> {
  AsyncCounterNotifier() : super(const AsyncValue.data(0));

  Future<void> incrementAsync() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 1));
    state = AsyncValue.data((state.value ?? 0) + 1);
  }

  Future<void> fetchRemoteCounter() async {
    state = const AsyncValue.loading();
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      final remoteValue = DateTime.now().millisecond % 100;
      state = AsyncValue.data(remoteValue);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }
}
```

### 4. Mimari Avantajları Öğren (20 dakika)

#### 🏗️ Riverpod'un Mimari Avantajları

##### ✅ Compile-time Safety
- Derleme zamanında tip güvenliği
- Runtime hatalarını minimize eder
- IDE desteği ile otomatik tamamlama

##### ✅ Memory Management
- Otomatik dispose işlemi
- Memory leak'leri önler
- Gereksiz kaynakları temizler

##### ✅ Performance Optimization
- Gereksiz rebuild'leri önler
- Sadece gerekli widget'lar güncellenir
- Efficient dependency tracking

##### ✅ Debugging Excellence
- Provider Inspector ile state izleme
- Clear error messages
- Development tools integration

##### ✅ Code Generation Support
- Riverpod Generator ile boilerplate azaltma
- @riverpod annotation desteği
- Automatic provider generation

##### ✅ Testing Friendly
- Provider'ları kolayca mock'lama
- ProviderScope ile test isolation
- Dependency injection desteği

## 🎨 Pratik Egzersizler

### Egzersiz 1: User Preferences Manager
```dart
class UserPreferences {
  final String theme;
  final bool notifications;
  final double fontSize;

  const UserPreferences({
    required this.theme,
    required this.notifications,
    required this.fontSize,
  });

  UserPreferences copyWith({
    String? theme,
    bool? notifications,
    double? fontSize,
  }) {
    return UserPreferences(
      theme: theme ?? this.theme,
      notifications: notifications ?? this.notifications,
      fontSize: fontSize ?? this.fontSize,
    );
  }
}

class UserPreferencesNotifier extends StateNotifier<UserPreferences> {
  UserPreferencesNotifier() : super(const UserPreferences(
    theme: 'light',
    notifications: true,
    fontSize: 16.0,
  ));

  void setTheme(String theme) {
    state = state.copyWith(theme: theme);
  }

  void toggleNotifications() {
    state = state.copyWith(notifications: !state.notifications);
  }

  void setFontSize(double fontSize) {
    state = state.copyWith(fontSize: fontSize);
  }
}
```

### Egzersiz 2: Computed Values
```dart
// Computed provider example
final doubledCounterProvider = Provider<int>((ref) {
  final count = ref.watch(counterProvider);
  return count * 2;
});
```

## 📊 State Management Karşılaştırması

| Özellik | Riverpod | Provider | Bloc |
|---------|----------|----------|------|
| Type Safety | ✅ | ❌ | ✅ |
| Performance | ✅ | ⚠️ | ✅ |
| Learning Curve | ⚠️ | ✅ | ❌ |
| Code Generation | ✅ | ❌ | ❌ |
| Testing | ✅ | ⚠️ | ✅ |
| Community | ⚠️ | ✅ | ✅ |

## 💡 Best Practices

### ✅ DO:
- Provider'ları global olarak tanımlayın
- StateNotifier kullanın karmaşık logic için
- AsyncValue ile async işlemleri handle edin
- Provider'ları compose edin
- ref.watch() ve ref.read() farkını bilin

### ❌ DON'T:
- Provider'ları widget içinde tanımlamayın
- State'i direkt olarak mutate etmeyin
- Consumer olmadan provider okumaya çalışmayın
- Gereksiz provider'lar oluşturmayın

## 🔄 Async Patterns

### AsyncValue Kullanımı
```dart
Consumer(
  builder: (context, ref, child) {
    final asyncCount = ref.watch(asyncCounterProvider);
    
    return asyncCount.when(
      data: (count) => Text('Value: $count'),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  },
)
```

### Error Handling Best Practices
- ✅ AsyncValue.when() kullanın
- ✅ Try-catch blokları kullanın
- ✅ User-friendly error messages
- ✅ Retry mechanisms

## 📚 Kaynaklar

### Resmi Dokümantasyon
- [Riverpod Documentation](https://riverpod.dev/)
- [StateNotifier Guide](https://riverpod.dev/docs/concepts/state_notifier)
- [AsyncValue Documentation](https://riverpod.dev/docs/concepts/async_value)

### Video Kaynakları
- [Riverpod Complete Tutorial](https://www.youtube.com/watch?v=example)
- [State Management Comparison](https://www.youtube.com/watch?v=example)

### Blog Yazıları
- [Why Riverpod over Provider](https://blog.example.com/riverpod-vs-provider)
- [Advanced Riverpod Patterns](https://blog.example.com/advanced-riverpod)

## ✅ Tamamlama Kriterleri

Bu görevi tamamlamış sayılırsınız eğer:

- [ ] Riverpod temel kavramlarını öğrendiniz
- [ ] StateNotifierProvider ile sayaç oluşturdunuz
- [ ] AsyncValue ile async işlemleri handle ettiniz
- [ ] User preferences manager uyguladınız
- [ ] Mimari avantajları anladınız
- [ ] Best practices'leri öğrendiniz

## 🧪 Test Senaryoları

### Unit Test Örneği
```dart
void main() {
  test('CounterNotifier increment test', () {
    final container = ProviderContainer();
    
    expect(container.read(counterProvider), 0);
    
    container.read(counterProvider.notifier).increment();
    expect(container.read(counterProvider), 1);
    
    container.dispose();
  });
}
```

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
- [ ] Responsive layout kavramlarını hatırla
- [ ] LayoutBuilder ve MediaQuery dokümantasyonuna göz at

---

**Sonraki Gün**: [Gün 3 - Responsive & Adaptive Layout](../day3_responsive_layout/) 