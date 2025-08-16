import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Language state provider
final languageProvider = StateNotifierProvider<LanguageNotifier, Locale>((ref) {
  return LanguageNotifier();
});

class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier() : super(const Locale('en')) {
    _loadLanguage();
  }

  static const String _languageKey = 'selected_language';

  // Load saved language preference
  Future<void> _loadLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_languageKey) ?? 'en';
      state = Locale(languageCode);
    } catch (e) {
      // If there's an error, default to English
      state = const Locale('en');
    }
  }

  // Change language and save preference
  Future<void> setLanguage(Locale locale) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, locale.languageCode);
      state = locale;
    } catch (e) {
      // Handle error silently, keep current state
    }
  }

  // Toggle between English and Turkish
  Future<void> toggleLanguage() async {
    final newLocale = state.languageCode == 'en' 
        ? const Locale('tr') 
        : const Locale('en');
    await setLanguage(newLocale);
  }
} 