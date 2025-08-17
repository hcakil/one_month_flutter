# 🔐 Security Guide

## 🚨 URGENT: Exposed API Key Alert

**A Google API Key has been detected in your repository commit history!**

### Immediate Actions Required:

#### 1. **Rotate the Exposed API Key** ⚡
```bash
# Go to Google Cloud Console
# https://console.cloud.google.com/apis/credentials

# Steps:
# 1. Find the exposed API key
# 2. Delete or regenerate it immediately
# 3. Create a new API key
# 4. Update your local configuration
```

#### 2. **Clean Git History** 🧹
The API key is in your git history and needs to be removed:

```bash
# Option 1: Remove specific file from history (if you know the exact file)
git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch path/to/file/with/api/key' \
  --prune-empty --tag-name-filter cat -- --all

# Option 2: Use BFG Repo-Cleaner (recommended)
# Download BFG from: https://rtyley.github.io/bfg-repo-cleaner/
java -jar bfg.jar --replace-text passwords.txt
git reflog expire --expire=now --all && git gc --prune=now --aggressive

# Option 3: If the repository is new, consider starting fresh
# This might be the safest option for a learning project
```

#### 3. **Force Push Changes** (⚠️ Use with caution)
```bash
git push --force-with-lease origin --all
git push --force-with-lease origin --tags
```

## 🛡️ Security Best Practices

### API Key Management

#### ✅ DO:
- Store API keys in environment variables
- Use the provided `api_keys_template.dart` as a template
- Keep API keys in files that are in `.gitignore`
- Use different API keys for development/production
- Regularly rotate API keys
- Restrict API key permissions to minimum required
- Monitor API key usage

#### ❌ DON'T:
- Commit API keys to version control
- Share API keys in plain text
- Use production keys in development
- Leave unused API keys active
- Ignore security alerts

### File Structure for Secrets

```
lib/
├── config/
│   ├── api_keys_template.dart  ✅ (committed - template only)
│   └── api_keys.dart          ❌ (ignored by git - contains real keys)
├── .env.template              ✅ (committed - template only)
└── .env                       ❌ (ignored by git - contains real values)
```

### Environment Variables Setup

Create a `.env` file in your project root:
```bash
# .env (this file is ignored by git)
GOOGLE_API_KEY=your_actual_google_api_key_here
OPENAI_API_KEY=your_actual_openai_api_key_here
FIREBASE_API_KEY=your_actual_firebase_key_here
```

Load environment variables in your Flutter app:
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

// Usage
String apiKey = dotenv.env['GOOGLE_API_KEY'] ?? '';
```

### Git Hooks for Prevention

Create `.git/hooks/pre-commit`:
```bash
#!/bin/sh
# Pre-commit hook to check for potential secrets

echo "Checking for potential secrets..."

# Check for common secret patterns
if git diff --cached --name-only | xargs grep -l "AIza\|sk-\|pk_\|AKIA" 2>/dev/null; then
    echo "❌ Potential API key detected!"
    echo "Please remove API keys before committing."
    exit 1
fi

echo "✅ No secrets detected."
exit 0
```

Make it executable:
```bash
chmod +x .git/hooks/pre-commit
```

## 🔍 Monitoring and Detection

### GitHub Security Features
- Enable **Dependabot alerts**
- Enable **Secret scanning**
- Enable **Code scanning**
- Review **Security advisories**

### Regular Security Checks
```bash
# Check git history for potential secrets
git log --all --full-history -- "*.dart" | grep -i "api\|key\|secret\|password"

# Check current files for secrets (install truffleHog)
trufflehog git file://. --only-verified
```

## 📚 Additional Resources

- [GitHub Secret Scanning](https://docs.github.com/en/code-security/secret-scanning)
- [Google API Key Best Practices](https://cloud.google.com/docs/authentication/api-keys)
- [Flutter Security Best Practices](https://docs.flutter.dev/deployment/security)
- [OWASP Mobile Security](https://owasp.org/www-project-mobile-security/)

## 🆘 If You Need Help

1. **Immediate Security Concern**: Rotate the API key first, ask questions later
2. **Git History Cleanup**: Consider professional help if you're unsure
3. **Future Prevention**: Follow this guide and use the provided templates

---

**Remember**: Security is not optional. Always err on the side of caution when dealing with API keys and sensitive data. 