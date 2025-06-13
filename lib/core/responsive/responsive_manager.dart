import 'package:flutter/material.dart';

/// Global responsive manager that tracks screen dimensions without requiring BuildContext
class ResponsiveManager {
  static ResponsiveManager? _instance;
  static ResponsiveManager get instance => _instance ??= ResponsiveManager._();
  ResponsiveManager._();

  // Screen dimensions
  Size? _screenSize;
  EdgeInsets? _safeArea;
  double? _devicePixelRatio;

  // Base design dimensions
  static const double baseWidth = 375.0;
  static const double baseHeight = 812.0;

  // Breakpoints
  static const double mobileMax = 599.0;
  static const double tabletMin = 600.0;
  static const double tabletMax = 1199.0;
  static const double desktopMin = 1200.0;

  /// Initialize with MediaQuery data - call this in your app initialization
  void initialize(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    _screenSize = mediaQuery.size;
    _safeArea = mediaQuery.padding;
    _devicePixelRatio = mediaQuery.devicePixelRatio;
  }

  /// Update screen dimensions when they change
  void updateScreenSize(
    Size newSize,
    EdgeInsets safeArea,
    double devicePixelRatio,
  ) {
    _screenSize = newSize;
    _safeArea = safeArea;
    _devicePixelRatio = devicePixelRatio;
  }

  // Getters for screen info
  Size get screenSize => _screenSize ?? const Size(375, 812);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get safeArea => _safeArea ?? EdgeInsets.zero;
  double get devicePixelRatio => _devicePixelRatio ?? 1.0;

  // Device type checks
  bool get isMobile => screenWidth <= mobileMax;
  bool get isTablet => screenWidth >= tabletMin && screenWidth <= tabletMax;
  bool get isDesktop => screenWidth >= desktopMin;
  bool get isLandscape => screenWidth > screenHeight;
  bool get isPortrait => screenHeight >= screenWidth;
  bool get isSmallScreen => screenHeight < 700;
  bool get isLargeScreen => screenHeight > 900;

  // Responsive calculations
  double responsiveWidth(double designWidth) {
    return (screenWidth * designWidth) / baseWidth;
  }

  double responsiveHeight(double designHeight) {
    return (screenHeight * designHeight) / baseHeight;
  }

  /// Smart responsive value that automatically decides when to use const vs dynamic
  /// Use this for values that should be responsive on mobile but can be const on larger screens
  double smartResponsive(double value, {bool forceResponsive = false}) {
    if (forceResponsive || isMobile) {
      return responsiveWidth(value);
    }
    return value; // Use const value for tablets and desktop
  }

  /// Get adaptive value based on screen size
  T adaptiveValue<T>({required T mobile, T? tablet, T? desktop}) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }
}

/// Mixin to easily access responsive manager in widgets
mixin ResponsiveMixin {
  ResponsiveManager get responsive => ResponsiveManager.instance;
}
