import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_preferences.dart';

class UserPreferencesNotifier extends StateNotifier<UserPreferences> {
  UserPreferencesNotifier()
      : super(const UserPreferences(
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

// User preferences provider
final userPreferencesProvider = StateNotifierProvider<UserPreferencesNotifier, UserPreferences>((ref) {
  return UserPreferencesNotifier();
}); 