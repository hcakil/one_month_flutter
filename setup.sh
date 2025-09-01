s#!/bin/bash

echo "🚀 30 Günlük Flutter Gelişim Projesi - Kurulum Scripti"
echo "======================================================"

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter bulunamadı. Flutter'ı kurmak için:"
    echo ""
    echo "1. https://docs.flutter.dev/get-started/install adresini ziyaret edin"
    echo "2. İşletim sisteminiz için Flutter SDK'sını indirin"
    echo "3. PATH'e Flutter'ı ekleyin"
    echo "4. Bu scripti tekrar çalıştırın"
    echo ""
    exit 1
fi

echo "✅ Flutter bulundu: $(flutter --version | head -n 1)"

# Check Flutter doctor
echo ""
echo "🔍 Flutter doctor çalıştırılıyor..."
flutter doctor

# Enable web support
echo ""
echo "🌐 Web desteği aktifleştiriliyor..."
flutter config --enable-web

# Get dependencies
echo ""
echo "📦 Bağımlılıklar yükleniyor..."
flutter pub get

# Create web icons directory
echo ""
echo "🎨 Web ikonları için klasör oluşturuluyor..."
mkdir -p web/icons

# Create basic web icons (you should replace these with actual icons)
echo "📝 Temel web dosyaları oluşturuluyor..."

# Create favicon.png (placeholder)
cat > web/favicon.png << 'EOF'
# This is a placeholder. Replace with actual favicon.png
EOF

# Create basic web icons info
cat > web/icons/README.md << 'EOF'
# Web Icons

Bu klasörde aşağıdaki icon dosyalarını bulundurmalısınız:

- Icon-192.png (192x192 px)
- Icon-512.png (512x512 px) 
- Icon-maskable-192.png (192x192 px, maskable)
- Icon-maskable-512.png (512x512 px, maskable)
- favicon.png (32x32 px)

Bu ikonları https://favicon.io/ veya benzer araçlarla oluşturabilirsiniz.
EOF

# Check if everything is ready
echo ""
echo "🧪 Proje durumu kontrol ediliyor..."

if flutter pub deps > /dev/null 2>&1; then
    echo "✅ Bağımlılıklar başarıyla yüklendi"
else
    echo "❌ Bağımlılık yükleme hatası"
    exit 1
fi

echo ""
echo "🎉 Kurulum tamamlandı!"
echo ""
echo "📋 Sıradaki adımlar:"
echo "1. Web ikonlarını web/icons/ klasörüne ekleyin"
echo "2. flutter run -d chrome ile web versiyonunu test edin"
echo "3. Gün 1 görevlerine başlayın!"
echo ""
echo "🚀 Başarılar! 30 günlük yolculuğunuz başlıyor..." 