#!/bin/bash

# Flutter Web Build Server Script
# This script helps serve the Flutter web build using the correct Python command

echo "🌐 Flutter Web Build Server"
echo "=========================="

# Check if build/web directory exists
if [ ! -d "build/web" ]; then
    echo "❌ Error: build/web directory not found!"
    echo "Please run 'flutter build web' first."
    exit 1
fi

# Check for Python3
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
    echo "✅ Found Python3: $(python3 --version)"
elif command -v python &> /dev/null; then
    PYTHON_CMD="python"
    echo "✅ Found Python: $(python --version)"
else
    echo "❌ Error: Neither python3 nor python found!"
    echo "Please install Python to serve the web build."
    exit 1
fi

echo ""
echo "🚀 Starting server..."
echo "📁 Serving from: build/web"
echo "🌍 URL: http://localhost:8000"
echo "🔄 Press Ctrl+C to stop the server"
echo ""

cd build/web
$PYTHON_CMD -m http.server 8000

