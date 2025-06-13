import 'package:flutter/material.dart';
import 'responsive_manager.dart';

/// Unified responsive design class that provides all design system values
/// Uses both const values for performance and responsive values when needed
class R {
  static ResponsiveManager get _r => ResponsiveManager.instance;

  // =================== SPACING ===================

  /// Const spacing values - use for consistent spacing that doesn't need to be responsive
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;
  static const double space60 = 60.0;
  static const double space80 = 80.0;
  static const double space100 = 100.0;

  /// Responsive spacing - automatically adapts to screen size
  static double get spaceXS => _r.smartResponsive(4);
  static double get spaceSM => _r.smartResponsive(8);
  static double get spaceMD => _r.smartResponsive(16);
  static double get spaceLG => _r.smartResponsive(24);
  static double get spaceXL => _r.smartResponsive(32);
  static double get space2XL => _r.smartResponsive(48);
  static double get space3XL => _r.smartResponsive(60);

  /// Adaptive spacing based on device type
  static double get adaptiveSpacing =>
      _r.adaptiveValue(mobile: space16, tablet: space24, desktop: space32);

  // =================== TYPOGRAPHY ===================

  /// Const font sizes
  static const double fontXS = 10.0;
  static const double fontSM = 12.0;
  static const double fontBase = 14.0;
  static const double fontMD = 16.0;
  static const double fontLG = 18.0;
  static const double fontXL = 20.0;
  static const double font2XL = 24.0;
  static const double font3XL = 28.0;
  static const double font4XL = 32.0;
  static const double font5XL = 36.0;

  /// Responsive font sizes
  static double get textXS => _r.smartResponsive(10);
  static double get textSM => _r.smartResponsive(12);
  static double get textBase => _r.smartResponsive(14);
  static double get textMD => _r.smartResponsive(16);
  static double get textLG => _r.smartResponsive(18);
  static double get textXL => _r.smartResponsive(20);
  static double get text2XL => _r.smartResponsive(24);
  static double get text3XL => _r.smartResponsive(28);
  static double get text4XL => _r.smartResponsive(32);
  static double get text5XL => _r.smartResponsive(36);

  // =================== BORDER RADIUS ===================

  /// Const border radius
  static const double radiusXS = 4.0;
  static const double radiusSM = 8.0;
  static const double radiusBase = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 20.0;
  static const double radius2XL = 24.0;
  static const double radiusFull = 999.0;

  /// Responsive border radius
  static double get borderXS => _r.smartResponsive(4);
  static double get borderSM => _r.smartResponsive(8);
  static double get borderBase => _r.smartResponsive(12);
  static double get borderLG => _r.smartResponsive(16);
  static double get borderXL => _r.smartResponsive(20);
  static double get border2XL => _r.smartResponsive(24);

  // =================== COMPONENT SIZES ===================

  /// Button heights
  static const double buttonHeightSM = 40.0;
  static const double buttonHeight = 50.0;
  static const double buttonHeightLG = 60.0;

  /// Icon sizes
  static const double iconSM = 16.0;
  static const double iconBase = 20.0;
  static const double iconLG = 24.0;
  static const double iconXL = 32.0;
  static const double icon2XL = 40.0;

  /// Responsive component sizes
  static double get adaptiveButtonHeight => _r.adaptiveValue(
    mobile: buttonHeight,
    tablet: buttonHeightLG,
    desktop: buttonHeightLG,
  );

  static double get adaptiveIconSize =>
      _r.adaptiveValue(mobile: iconBase, tablet: iconLG, desktop: iconXL);

  // =================== EDGE INSETS ===================

  /// Const padding values
  static const EdgeInsets paddingXS = EdgeInsets.all(space4);
  static const EdgeInsets paddingSM = EdgeInsets.all(space8);
  static const EdgeInsets paddingMD = EdgeInsets.all(space16);
  static const EdgeInsets paddingLG = EdgeInsets.all(space24);
  static const EdgeInsets paddingXL = EdgeInsets.all(space32);

  /// Responsive padding
  static EdgeInsets get responsivePadding => EdgeInsets.all(
    _r.adaptiveValue(mobile: space16, tablet: space24, desktop: space32),
  );

  static EdgeInsets get horizontalPadding => EdgeInsets.symmetric(
    horizontal: _r.adaptiveValue(
      mobile: space16,
      tablet: space24,
      desktop: space32,
    ),
  );

  static EdgeInsets get verticalPadding => EdgeInsets.symmetric(
    vertical: _r.adaptiveValue(
      mobile: space16,
      tablet: space20,
      desktop: space24,
    ),
  );

  // =================== SIZED BOXES ===================

  /// Const sized boxes for spacing
  static const SizedBox spaceH4 = SizedBox(height: space4);
  static const SizedBox spaceH8 = SizedBox(height: space8);
  static const SizedBox spaceH12 = SizedBox(height: space12);
  static const SizedBox spaceH16 = SizedBox(height: space16);
  static const SizedBox spaceH20 = SizedBox(height: space20);
  static const SizedBox spaceH24 = SizedBox(height: space24);
  static const SizedBox spaceH32 = SizedBox(height: space32);
  static const SizedBox spaceH40 = SizedBox(height: space40);
  static const SizedBox spaceH60 = SizedBox(height: space60);

  static const SizedBox spaceW4 = SizedBox(width: space4);
  static const SizedBox spaceW8 = SizedBox(width: space8);
  static const SizedBox spaceW12 = SizedBox(width: space12);
  static const SizedBox spaceW16 = SizedBox(width: space16);
  static const SizedBox spaceW20 = SizedBox(width: space20);
  static const SizedBox spaceW24 = SizedBox(width: space24);
  static const SizedBox spaceW32 = SizedBox(width: space32);

  /// Responsive sized boxes
  static SizedBox get responsiveSpaceH => SizedBox(height: spaceMD);
  static SizedBox get responsiveSpaceW => SizedBox(width: spaceMD);

  // =================== BORDER RADIUS OBJECTS ===================

  /// Const border radius objects
  static const BorderRadius borderRadiusXS = BorderRadius.all(
    Radius.circular(radiusXS),
  );
  static const BorderRadius borderRadiusSM = BorderRadius.all(
    Radius.circular(radiusSM),
  );
  static const BorderRadius borderRadiusBase = BorderRadius.all(
    Radius.circular(radiusBase),
  );
  static const BorderRadius borderRadiusLG = BorderRadius.all(
    Radius.circular(radiusLG),
  );
  static const BorderRadius borderRadiusXL = BorderRadius.all(
    Radius.circular(radiusXL),
  );
  static const BorderRadius borderRadius2XL = BorderRadius.all(
    Radius.circular(radius2XL),
  );

  /// Responsive border radius objects
  static BorderRadius get responsiveBorderRadius =>
      BorderRadius.circular(borderBase);

  // =================== HELPER METHODS ===================

  /// Get responsive width value
  static double w(double value) => _r.responsiveWidth(value);

  /// Get responsive height value
  static double h(double value) => _r.responsiveHeight(value);

  /// Get responsive value (same as width)
  static double r(double value) => _r.responsiveWidth(value);

  /// Get responsive font size
  static double sp(double value) => _r.responsiveWidth(value);

  /// Get adaptive value based on device type
  static T adaptive<T>({required T mobile, T? tablet, T? desktop}) =>
      _r.adaptiveValue(mobile: mobile, tablet: tablet, desktop: desktop);

  /// Screen information
  static bool get isMobile => _r.isMobile;
  static bool get isTablet => _r.isTablet;
  static bool get isDesktop => _r.isDesktop;
  static bool get isLandscape => _r.isLandscape;
  static bool get isPortrait => _r.isPortrait;
  static double get screenWidth => _r.screenWidth;
  static double get screenHeight => _r.screenHeight;
  static Size get screenSize => _r.screenSize;
  static EdgeInsets get safeArea => _r.safeArea;

  // =================== GRID & LAYOUT ===================

  /// Get number of columns for grid based on screen size
  static int get gridColumns =>
      _r.adaptiveValue(mobile: 2, tablet: 3, desktop: 4);

  /// Get cross axis count for responsive grids
  static int getCrossAxisCount({int? mobile, int? tablet, int? desktop}) {
    return _r.adaptiveValue(
      mobile: mobile ?? 2,
      tablet: tablet ?? 3,
      desktop: desktop ?? 4,
    );
  }

  /// Get aspect ratio for cards/items
  static double get cardAspectRatio =>
      _r.adaptiveValue(mobile: 0.75, tablet: 0.8, desktop: 0.85);

  // =================== Double Values for Theme ===================

  // Padding as doubles (for EdgeInsets.symmetric)
  static double get paddingXSValue => _r.smartResponsive(4.0);
  static double get paddingSMValue => _r.smartResponsive(8.0);
  static double get paddingMDValue => _r.smartResponsive(16.0);
  static double get paddingLGValue => _r.smartResponsive(24.0);
  static double get paddingXLValue => _r.smartResponsive(32.0);

  // Border radius as doubles
  static double get borderSMValue => _r.smartResponsive(8.0);
  static double get borderBaseValue => _r.smartResponsive(12.0);
  static double get borderLGValue => _r.smartResponsive(16.0);
  static double get borderXLValue => _r.smartResponsive(20.0);
  static double get borderInputValue => _r.smartResponsive(25.0);
  static double get borderButtonValue => _r.smartResponsive(25.0);

  // Margin as doubles
  static double get marginSMValue => _r.smartResponsive(8.0);
  static double get marginMDValue => _r.smartResponsive(16.0);
  static double get marginLGValue => _r.smartResponsive(24.0);
}
