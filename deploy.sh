#!/bin/bash

# Flutter Web Deployment Script for GitHub Pages
# This script builds the Flutter web app and prepares it for GitHub Pages deployment

echo "🚀 Starting Flutter Web Deployment..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    exit 1
fi

# Check Flutter version
echo "📱 Flutter version:"
flutter --version

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Generate localization files
echo "🌍 Generating localization files..."
flutter gen-l10n

# Build for web (Flutter automatically chooses the best renderer)
echo "🔨 Building Flutter web app..."
flutter build web --release --base-href /one_month_flutter/

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo "📁 Build files are in: ./build/web"
    echo ""
    echo "🌐 To deploy to GitHub Pages:"
    echo "1. Push your code to GitHub"
    echo "2. Enable GitHub Pages in repository settings"
    echo "3. Set source to 'GitHub Actions'"
    echo "4. The workflow will automatically deploy your app"
    echo ""
    echo "🔗 Your app will be available at:"
    echo "https://[your-username].github.io/[repository-name]"
    echo ""
    echo "📋 Manual deployment (if needed):"
    echo "1. Copy contents of ./build/web to a 'docs' folder"
    echo "2. Push the 'docs' folder to your repository"
    echo "3. Enable GitHub Pages with 'docs' as source"
    echo ""
    echo "📁 Copying build files to docs folder for manual deployment..."
    mkdir -p docs
    cp -r build/web/* docs/
    echo "✅ Files copied to docs/ folder"
    echo "   You can now push with: git add docs/ && git commit -m 'Deploy' && git push"
else
    echo "❌ Build failed. Please check the errors above."
    exit 1
fi
