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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is UserPreferences &&
      other.theme == theme &&
      other.notifications == notifications &&
      other.fontSize == fontSize;
  }

  @override
  int get hashCode => theme.hashCode ^ notifications.hashCode ^ fontSize.hashCode;

  @override
  String toString() {
    return 'UserPreferences(theme: $theme, notifications: $notifications, fontSize: $fontSize)';
  }
} 