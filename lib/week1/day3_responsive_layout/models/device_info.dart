import 'package:flutter/material.dart';

/// Device information model for responsive layout decisions
class DeviceInfo {
  final DeviceType deviceType;
  final Orientation orientation;
  final double screenWidth;
  final double screenHeight;
  final double devicePixelRatio;
  final bool isWeb;
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;

  const DeviceInfo({
    required this.deviceType,
    required this.orientation,
    required this.screenWidth,
    required this.screenHeight,
    required this.devicePixelRatio,
    required this.isWeb,
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
  });

  /// Create DeviceInfo from MediaQueryData
  factory DeviceInfo.fromMediaQuery(MediaQueryData mediaQuery) {
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final devicePixelRatio = mediaQuery.devicePixelRatio;
    final orientation = mediaQuery.orientation;

    // Determine device type based on screen width
    DeviceType deviceType;
    bool isMobile = false;
    bool isTablet = false;
    bool isDesktop = false;

    if (width < 600) {
      deviceType = DeviceType.mobile;
      isMobile = true;
    } else if (width < 1200) {
      deviceType = DeviceType.tablet;
      isTablet = true;
    } else {
      deviceType = DeviceType.desktop;
      isDesktop = true;
    }

    return DeviceInfo(
      deviceType: deviceType,
      orientation: orientation,
      screenWidth: width,
      screenHeight: height,
      devicePixelRatio: devicePixelRatio,
      isWeb: identical(0, 0.0), // Simple web detection
      isMobile: isMobile,
      isTablet: isTablet,
      isDesktop: isDesktop,
    );
  }

  /// Get appropriate column count based on device type
  int get columnCount {
    switch (deviceType) {
      case DeviceType.mobile:
        return orientation == Orientation.portrait ? 1 : 2;
      case DeviceType.tablet:
        return orientation == Orientation.portrait ? 2 : 3;
      case DeviceType.desktop:
        return 4;
    }
  }

  /// Get appropriate padding based on device type
  double get horizontalPadding {
    switch (deviceType) {
      case DeviceType.mobile:
        return 16.0;
      case DeviceType.tablet:
        return 24.0;
      case DeviceType.desktop:
        return 32.0;
    }
  }

  /// Get appropriate font size multiplier
  double get fontSizeMultiplier {
    switch (deviceType) {
      case DeviceType.mobile:
        return 1.0;
      case DeviceType.tablet:
        return 1.1;
      case DeviceType.desktop:
        return 1.2;
    }
  }

  @override
  String toString() {
    return 'DeviceInfo(type: $deviceType, orientation: $orientation, '
        'size: ${screenWidth.toInt()}x${screenHeight.toInt()}, '
        'ratio: ${devicePixelRatio.toStringAsFixed(1)})';
  }
}

/// Device type enumeration
enum DeviceType {
  mobile,
  tablet,
  desktop,
}

/// Extension to get device type names
extension DeviceTypeExtension on DeviceType {
  String get name {
    switch (this) {
      case DeviceType.mobile:
        return 'Mobile';
      case DeviceType.tablet:
        return 'Tablet';
      case DeviceType.desktop:
        return 'Desktop';
    }
  }

  String get description {
    switch (this) {
      case DeviceType.mobile:
        return 'Width < 600px';
      case DeviceType.tablet:
        return '600px ≤ Width < 1200px';
      case DeviceType.desktop:
        return 'Width ≥ 1200px';
    }
  }
}

/// Orientation extension
extension OrientationExtension on Orientation {
  String get name {
    switch (this) {
      case Orientation.portrait:
        return 'Portrait';
      case Orientation.landscape:
        return 'Landscape';
    }
  }
}
