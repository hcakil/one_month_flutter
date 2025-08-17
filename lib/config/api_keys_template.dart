// ⚠️ TEMPLATE FILE - DO NOT COMMIT ACTUAL API KEYS ⚠️
// 
// This is a template file showing how to structure your API keys.
// 
// To use this:
// 1. Copy this file to api_keys.dart
// 2. Replace the placeholder values with your actual API keys
// 3. The api_keys.dart file will be ignored by git (see .gitignore)

class ApiKeys {
  // ⚠️ NEVER commit real API keys to version control ⚠️
  
  // Google API Keys
  static const String googleApiKey = 'YOUR_GOOGLE_API_KEY_HERE';
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY_HERE';
  
  // OpenAI API Key (for Week 2 - AI Integration)
  static const String openAiApiKey = 'YOUR_OPENAI_API_KEY_HERE';
  
  // Firebase Configuration (if using Firebase)
  static const String firebaseApiKey = 'YOUR_FIREBASE_API_KEY_HERE';
  static const String firebaseProjectId = 'YOUR_FIREBASE_PROJECT_ID_HERE';
  
  // Other API Keys
  static const String supabaseUrl = 'YOUR_SUPABASE_URL_HERE';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY_HERE';
  
  // Helper method to check if keys are properly configured
  static bool get areKeysConfigured {
    return !googleApiKey.contains('YOUR_') &&
           !openAiApiKey.contains('YOUR_') &&
           googleApiKey.isNotEmpty &&
           openAiApiKey.isNotEmpty;
  }
  
  // Helper method to get a warning message if keys are not configured
  static String get configurationWarning {
    if (areKeysConfigured) return '';
    
    return '''
⚠️ API Keys Not Configured ⚠️

To configure your API keys:
1. Copy lib/config/api_keys_template.dart to lib/config/api_keys.dart
2. Replace the placeholder values with your actual API keys
3. Never commit the api_keys.dart file to version control

The api_keys.dart file is already added to .gitignore for your security.
''';
  }
}

// Example usage in your app:
// 
// import 'package:your_app/config/api_keys.dart';
// 
// void someFunction() {
//   if (!ApiKeys.areKeysConfigured) {
//     print(ApiKeys.configurationWarning);
//     return;
//   }
//   
//   // Use your API keys safely
//   final apiKey = ApiKeys.googleApiKey;
//   // ... make API calls
// } 