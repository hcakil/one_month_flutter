import 'package:flutter/material.dart';

/// Responsive breakpoints utility class
class ResponsiveBreakpoints {
  // Standard Material Design breakpoints
  static const double mobileMax = 599;
  static const double tabletMin = 600;
  static const double tabletMax = 1199;
  static const double desktopMin = 1200;
  
  // Custom breakpoints for specific use cases
  static const double smallMobile = 360;
  static const double largeMobile = 480;
  static const double smallTablet = 768;
  static const double largeTablet = 1024;
  static const double smallDesktop = 1440;
  static const double largeDesktop = 1920;

  /// Check if current width is mobile
  static bool isMobile(double width) => width <= mobileMax;
  
  /// Check if current width is tablet
  static bool isTablet(double width) => width >= tabletMin && width <= tabletMax;
  
  /// Check if current width is desktop
  static bool isDesktop(double width) => width >= desktopMin;
  
  /// Check if current width is small mobile
  static bool isSmallMobile(double width) => width <= smallMobile;
  
  /// Check if current width is large mobile
  static bool isLargeMobile(double width) => width > largeMobile && width <= mobileMax;
  
  /// Check if current width is small tablet
  static bool isSmallTablet(double width) => width >= tabletMin && width <= smallTablet;
  
  /// Check if current width is large tablet
  static bool isLargeTablet(double width) => width > smallTablet && width <= tabletMax;
  
  /// Get appropriate column count based on width
  static int getColumnCount(double width) {
    if (isMobile(width)) return 1;
    if (isTablet(width)) return 2;
    return 3;
  }
  
  /// Get appropriate grid column count based on width
  static int getGridColumnCount(double width) {
    if (width <= smallMobile) return 1;
    if (width <= mobileMax) return 2;
    if (width <= smallTablet) return 3;
    if (width <= tabletMax) return 4;
    if (width <= smallDesktop) return 5;
    return 6;
  }
  
  /// Get appropriate padding based on width
  static double getHorizontalPadding(double width) {
    if (isMobile(width)) return 16.0;
    if (isTablet(width)) return 24.0;
    return 32.0;
  }
  
  /// Get appropriate card width based on screen width
  static double getCardWidth(double screenWidth) {
    if (isMobile(screenWidth)) return screenWidth - 32;
    if (isTablet(screenWidth)) return (screenWidth - 64) / 2;
    return (screenWidth - 96) / 3;
  }
  
  /// Get appropriate font size multiplier
  static double getFontSizeMultiplier(double width) {
    if (isMobile(width)) return 1.0;
    if (isTablet(width)) return 1.1;
    return 1.2;
  }
  
  /// Get device type name
  static String getDeviceTypeName(double width) {
    if (isMobile(width)) return 'Mobile';
    if (isTablet(width)) return 'Tablet';
    return 'Desktop';
  }
  
  /// Get all breakpoint information as a map
  static Map<String, dynamic> getBreakpointInfo(double width) {
    return {
      'width': width,
      'deviceType': getDeviceTypeName(width),
      'isMobile': isMobile(width),
      'isTablet': isTablet(width),
      'isDesktop': isDesktop(width),
      'columnCount': getColumnCount(width),
      'gridColumnCount': getGridColumnCount(width),
      'horizontalPadding': getHorizontalPadding(width),
      'fontSizeMultiplier': getFontSizeMultiplier(width),
    };
  }
}

/// Responsive value class for different screen sizes
class ResponsiveValue<T> {
  final T mobile;
  final T? tablet;
  final T? desktop;

  const ResponsiveValue({
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  /// Get the appropriate value based on screen width
  T getValue(double width) {
    if (ResponsiveBreakpoints.isDesktop(width) && desktop != null) {
      return desktop!;
    }
    if (ResponsiveBreakpoints.isTablet(width) && tablet != null) {
      return tablet!;
    }
    return mobile;
  }
}

/// Extension to easily get responsive values from BuildContext
extension ResponsiveContext on BuildContext {
  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;
  
  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;
  
  /// Check if mobile
  bool get isMobile => ResponsiveBreakpoints.isMobile(screenWidth);
  
  /// Check if tablet
  bool get isTablet => ResponsiveBreakpoints.isTablet(screenWidth);
  
  /// Check if desktop
  bool get isDesktop => ResponsiveBreakpoints.isDesktop(screenWidth);
  
  /// Get responsive value
  T responsive<T>(ResponsiveValue<T> responsiveValue) {
    return responsiveValue.getValue(screenWidth);
  }
  
  /// Get column count
  int get columnCount => ResponsiveBreakpoints.getColumnCount(screenWidth);
  
  /// Get horizontal padding
  double get horizontalPadding => ResponsiveBreakpoints.getHorizontalPadding(screenWidth);
  
  /// Get font size multiplier
  double get fontSizeMultiplier => ResponsiveBreakpoints.getFontSizeMultiplier(screenWidth);
}
