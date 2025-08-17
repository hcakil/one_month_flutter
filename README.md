# 📱 30-Day Flutter + Web + AI Development Project

## 🎯 Project Purpose
This project is a comprehensive study repository created to support your 30-day Flutter learning plan.

## 🌍 Multi-Language Support
- **Main Language**: English
- **Supported Languages**: English, Turkish
- **Language Toggle**: Available in the app via the language icon in the app bar
- **Saved Preference**: Your language choice is automatically saved

## 📋 Plan Overview
- **Duration**: 30 days
- **Daily Time**: 1.5–2 hours
- **Focus Areas**:
  - 🔵 Flutter & Web Modernization (Days 1-7)
  - 🟢 AI Integration with Flutter (Days 8-14)
  - 🟡 Fullstack & Backend Connection (Days 15-21)
  - 🟣 Portfolio & Optimization (Days 22-30)

## 🚀 Setup Instructions

### 1. Flutter Installation
```bash
# Download and install Flutter
# https://docs.flutter.dev/get-started/install

# Verify Flutter is added to PATH
flutter --version

# Install project dependencies
flutter pub get
```

### 2. Enable Web Support
```bash
flutter config --enable-web
```

### 3. Generate Localizations
```bash
# Generate localization files
flutter gen-l10n
```

### 4. Run the Project
```bash
# For web
flutter run -d chrome

# For mobile
flutter run
```

## 📁 Project Structure

```
one_month_flutter/
├── README.md
├── pubspec.yaml
├── l10n.yaml                       # Localization configuration
├── lib/
│   ├── main.dart                   # Main app with multi-language support
│   ├── l10n/                       # Localization files
│   │   ├── app_en.arb             # English translations
│   │   └── app_tr.arb             # Turkish translations
│   ├── providers/
│   │   └── language_provider.dart  # Language state management
│   └── week1/
│       ├── day1_flutter_updates.dart  # Enhanced with Impeller comparison
│       ├── day2_riverpod_state.dart
│       ├── day3_responsive_layout.dart
│       ├── day4_web_performance.dart
│       ├── day5_seo_metadata.dart
│       └── day6_mini_project_web.dart
├── week1_geflutter_web/              # 🔵 Week 1: Flutter & Web
├── week2_ai_integration/           # 🟢 Week 2: AI Integration
├── week3_fullstack/               # 🟡 Week 3: Fullstack
├── week4_portfolio/               # 🟣 Week 4: Portfolio
├── web/
└── assets/
```

## 🔵 Week 1 - Flutter & Web Modernization

### Daily Goals:
- **Day 1**: Flutter 3.27+ Updates and Material 3 ✨ **Enhanced with Visual Impeller vs Skia Comparison**
- **Day 2**: State Management (Riverpod 3)
- **Day 3**: Responsive & Adaptive Layout
- **Day 4**: Web Performance Optimization
- **Day 5**: SEO and Web Metadata
- **Day 6**: Mini Project (Responsive Web App)
- **Day 7**: Review & Video Study

## ✨ New Features Added

### 🌍 Multi-Language Support
- **Language Toggle**: Switch between English and Turkish with a single tap
- **Persistent Settings**: Your language preference is automatically saved
- **Complete Translation**: All UI elements are fully translated
- **Easy to Extend**: Add more languages by creating new `.arb` files

### 📊 Enhanced Impeller vs Skia Comparison
Day 1 now includes:
- **Animated Performance Bars**: Visual comparison of performance metrics
- **Real-time Updates**: Charts update when you toggle between engines
- **Multiple Metrics**: Performance, Memory Usage, Battery Life, Animation Smoothness
- **Visual Engine Comparison**: Side-by-side comparison with icons and status
- **Interactive Toggle**: Switch between Impeller and Skia to see differences

### 🎨 Improved User Experience
- **Smooth Animations**: Performance bars animate when engine changes
- **Color-coded Metrics**: Green/Orange/Red indicators for performance levels
- **Modern UI**: Enhanced cards and visual elements
- **Responsive Design**: Works great on both web and mobile

## 📚 Resources
- [Flutter Documentation](https://docs.flutter.dev/)
- [Material 3 Design](https://m3.material.io/)
- [Riverpod Documentation](https://riverpod.dev/)
- [Flutter Internationalization](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization)

## 🎯 Outputs
- 3 mini projects
- GitHub portfolio
- Blog post
- AI integration experience
- Multi-language app development skills

## 📝 Progress Tracking
Check off completed tasks for each day:

### Week 1
- [ ] Day 1: Flutter 3.27+ Updates ✨ **Enhanced with Impeller Comparison**
- [ ] Day 2: Riverpod State Management
- [ ] Day 3: Responsive Layout
- [ ] Day 4: Web Performance
- [ ] Day 5: SEO & Metadata
- [ ] Day 6: Mini Web Project
- [ ] Day 7: Review & Video

## 🔧 Technical Features

### State Management
- **Riverpod**: Modern state management for language preferences
- **Persistent Storage**: SharedPreferences for saving user settings
- **Reactive UI**: Automatic updates when language changes

### Localization
- **ARB Files**: Industry-standard localization format
- **Code Generation**: Automatic generation of type-safe translations
- **Fallback Support**: Graceful handling of missing translations

### Performance
- **Animated Comparisons**: Smooth animations for performance metrics
- **Efficient Updates**: Minimal rebuilds when switching languages
- **Optimized Assets**: Proper resource management

---

🚀 **Success!** You'll become an expert in Flutter during this 30-day journey, with additional skills in internationalization and performance visualization! 