# 🚀 Deployment Guide - Flutter Web to GitHub Pages

This guide will help you deploy your Flutter web application to GitHub Pages with automated CI/CD.

## 📋 Prerequisites

- Flutter SDK installed (3.27.0 or higher)
- Git configured
- GitHub account
- Repository pushed to GitHub

## 🔧 Setup Steps

### 1. Enable GitHub Pages

1. Go to your repository on GitHub
2. Click on **Settings** tab
3. Scroll down to **Pages** section
4. Under **Source**, select **GitHub Actions**
5. Save the settings

### 2. Configure Repository Name

If your repository name is different from `one_month_flutter`, update the base href in these files:

- `web/index.html` - Update the `<base href="/your-repo-name/">` tag
- `deploy.sh` - Update the `--base-href` parameter
- `.github/workflows/deploy.yml` - Update the `--base-href` parameter

### 3. Push Your Code

```bash
git add .
git commit -m "Add Day 6 mini project and GitHub Pages deployment"
git push origin main
```

## 🤖 Automated Deployment

The GitHub Actions workflow will automatically:

1. ✅ Checkout your code
2. ✅ Setup Flutter environment
3. ✅ Install dependencies
4. ✅ Generate localization files
5. ✅ Build Flutter web app
6. ✅ Deploy to GitHub Pages

## 🛠️ Manual Deployment

If you prefer manual deployment:

```bash
# Run the deployment script
./deploy.sh

# Or manually:
flutter clean
flutter pub get
flutter gen-l10n
flutter build web --release --web-renderer html --base-href /your-repo-name/
```

## 🌐 Access Your App

Once deployed, your app will be available at:
```
https://[your-username].github.io/[repository-name]
```

## 🔍 Troubleshooting

### Common Issues

1. **404 Error**: Check that the base href matches your repository name
2. **Build Fails**: Ensure all dependencies are properly configured
3. **Localization Issues**: Run `flutter gen-l10n` before building
4. **Assets Not Loading**: Verify asset paths in `pubspec.yaml`

### Debug Steps

1. Check GitHub Actions logs in the **Actions** tab
2. Verify the build output in `build/web/` directory
3. Test locally with `flutter run -d chrome --web-renderer html`

## 📁 Project Structure

```
one_month_flutter/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions workflow
├── web/
│   ├── index.html              # Web entry point
│   └── manifest.json           # PWA manifest
├── lib/
│   └── week1/
│       └── day6_mini_project_web/  # Day 6 mini project
├── deploy.sh                   # Manual deployment script
└── DEPLOYMENT.md              # This file
```

## 🎯 Features Included

### Day 6 Mini Project Features:
- ✅ **Responsive Dashboard** - Adapts to mobile, tablet, and desktop
- ✅ **Interactive Components** - Counters, sliders, switches, chips
- ✅ **Data Visualization** - Animated charts and graphs
- ✅ **Performance Monitor** - Real-time system metrics
- ✅ **Modern UI** - Material 3 design with smooth animations
- ✅ **Multi-language Support** - English and Turkish

## 🔄 Updating Your App

To update your deployed app:

1. Make your changes
2. Commit and push to main branch
3. GitHub Actions will automatically rebuild and deploy

## 📱 Mobile Optimization

The app is optimized for:
- 📱 Mobile devices (responsive design)
- 💻 Desktop browsers
- 🌐 Progressive Web App (PWA) features
- ⚡ Fast loading with HTML renderer

## 🎨 Customization

### Changing Colors
Update the theme in `lib/main.dart`:
```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: Colors.deepPurple, // Change this color
  brightness: Brightness.light,
),
```

### Adding New Pages
1. Create new screen in `lib/week1/`
2. Add route in `main.dart`
3. Update navigation in home screen

## 📊 Performance Tips

- Use `--web-renderer html` for better compatibility
- Optimize images and assets
- Enable gzip compression on your server
- Use CDN for static assets if needed

## 🆘 Support

If you encounter issues:

1. Check the [Flutter Web documentation](https://docs.flutter.dev/platform-integration/web)
2. Review [GitHub Pages documentation](https://docs.github.com/en/pages)
3. Check GitHub Actions logs for build errors

---

**Happy Deploying! 🚀**
