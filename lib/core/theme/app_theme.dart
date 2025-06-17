// core/theme/app_theme.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/responsive/responsive.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // =================== Light Theme ===================
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'BalooThambi2',

    // Color Scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryOrange,
      brightness: Brightness.light,
      primary: AppColors.primaryOrange,
      secondary: AppColors.primaryBlue,
      surface: AppColors.white,
      background: AppColors.backgroundDark,
      error: AppColors.error,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.white,
      onBackground: AppColors.white,
      onError: AppColors.white,
    ),

    scaffoldBackgroundColor: AppColors.backgroundDark,

    // =================== App Bar Theme - Responsive ===================
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: R.textXL, // ✅ Using responsive font size
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        fontFamily: 'SF Pro Display',
      ),
      iconTheme: IconThemeData(
        color: AppColors.white,
        size: R.iconLG, // ✅ Using responsive icon size
      ),
    ),

    // =================== Text Theme - Responsive ===================
    textTheme: TextTheme(
      // Headings - Responsive
      headlineLarge: TextStyle(
        fontSize: R.text4XL, // ✅ 32.sp responsive
        fontWeight: FontWeight.bold,
        color: AppColors.white,
        height: 1.2,
      ),
      headlineMedium: TextStyle(
        fontSize: R.text3XL, // ✅ 28.sp responsive
        fontWeight: FontWeight.bold,
        color: AppColors.white,
        height: 1.2,
      ),
      headlineSmall: TextStyle(
        fontSize: R.text2XL, // ✅ 24.sp responsive
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.3,
      ),

      // Titles - Responsive
      titleLarge: TextStyle(
        fontSize: R.textXL, // ✅ 20.sp responsive
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.3,
      ),
      titleMedium: TextStyle(
        fontSize: R.textLG, // ✅ 18.sp responsive
        fontWeight: FontWeight.w500,
        color: AppColors.white,
        height: 1.4,
      ),
      titleSmall: TextStyle(
        fontSize: R.textMD, // ✅ 16.sp responsive
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.4,
      ),

      // Body Text - Responsive
      bodyLarge: TextStyle(
        fontSize: R.textMD, // ✅ 16.sp responsive
        fontWeight: FontWeight.normal,
        color: AppColors.white,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: R.textBase, // ✅ 14.sp responsive
        fontWeight: FontWeight.normal,
        color: AppColors.white,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontSize: R.textSM, // ✅ 12.sp responsive
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
        height: 1.4,
      ),

      // Labels - Responsive
      labelLarge: TextStyle(
        fontSize: R.textBase, // ✅ 14.sp responsive
        fontWeight: FontWeight.w500,
        color: AppColors.white,
        height: 1.4,
      ),
      labelMedium: TextStyle(
        fontSize: R.textSM, // ✅ 12.sp responsive
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.3,
      ),
      labelSmall: TextStyle(
        fontSize: R.textXS, // ✅ 10.sp responsive
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.3,
      ),
    ),

    // =================== Elevated Button Theme - Responsive ===================
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryOrange,
        foregroundColor: AppColors.white,
        shadowColor: AppColors.primaryOrange.withOpacity(0.3),
        elevation: 0,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            R.borderButtonValue,
          ), // ✅ Responsive border
        ),

        textStyle: TextStyle(
          fontSize: R.textMD, // ✅ Responsive font size
          fontWeight: FontWeight.w800,
          color: AppColors.white,
        ),
        minimumSize: Size(
          double.infinity,
          R.adaptiveButtonHeight,
        ), // ✅ Responsive height
      ),
    ),

    // =================== Outlined Button Theme - Responsive ===================
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.white,
        side: BorderSide(
          color: AppColors.white,
          width: 1.5.r,
        ), // ✅ Responsive border width
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            R.borderButtonValue,
          ), // ✅ Responsive border
        ),
        padding: EdgeInsets.symmetric(
          horizontal: R.paddingLGValue, // ✅ Responsive padding
          vertical: R.paddingMDValue, // ✅ Responsive padding
        ),
        textStyle: TextStyle(
          fontSize: R.textMD, // ✅ Responsive font size
          fontWeight: FontWeight.w800,
        ),
        minimumSize: Size(
          double.infinity,
          R.adaptiveButtonHeight,
        ), // ✅ Responsive height
      ),
    ),

    // =================== Text Button Theme - Responsive ===================
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryOrange,
        textStyle: TextStyle(
          fontSize: R.textSM, // ✅ Responsive font size
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: R.paddingSMValue, // ✅ Responsive padding
          vertical: R.paddingXSValue, // ✅ Responsive padding
        ),
      ),
    ),

    // =================== Input Decoration Theme - Responsive ===================
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      contentPadding: EdgeInsets.symmetric(
        horizontal: R.paddingLGValue, // ✅ Responsive padding
        vertical: R.paddingMDValue, // ✅ Responsive padding
      ),

      // Border styles - Responsive
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          R.borderInputValue,
        ), // ✅ Responsive border
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.3),
          width: 1.r, // ✅ Responsive border width
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          R.borderInputValue,
        ), // ✅ Responsive border
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.3),
          width: 1.r, // ✅ Responsive border width
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(R.borderInputValue),
        borderSide: BorderSide(
          color: AppColors.primaryOrange,
          width: 2.r, // ✅ Responsive border width
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(R.borderInputValue),
        borderSide: BorderSide(color: AppColors.error, width: 2.r),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(R.borderInputValue),
        borderSide: BorderSide(
          color: AppColors.error,
          width: 2.r, // ✅ Responsive border width
        ),
      ),

      // Text styles - Responsive
      hintStyle: TextStyle(
        color: Colors.white.withOpacity(0.6),
        fontSize: R.textBase, // ✅ Responsive font size
        fontWeight: FontWeight.normal,
      ),
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.8),
        fontSize: R.textBase, // ✅ Responsive font size
        fontWeight: FontWeight.w500,
      ),
      errorStyle: TextStyle(
        color: AppColors.error,
        fontSize: R.textSM, // ✅ Responsive font size
        fontWeight: FontWeight.w500,
      ),

      // Icon styles - Responsive
      prefixIconColor: Colors.white.withOpacity(0.7),
      suffixIconColor: Colors.white.withOpacity(0.7),
    ),

    // =================== Dialog Theme - Responsive ===================
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(R.borderLG), // ✅ Responsive border
      ),
      titleTextStyle: TextStyle(
        fontSize: R.textXL, // ✅ Responsive font size
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      contentTextStyle: TextStyle(
        fontSize: R.textMD, // ✅ Responsive font size
        color: AppColors.textSecondary,
      ),
    ),

    // =================== Bottom Sheet Theme - Responsive ===================
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(R.borderXL), // ✅ Responsive border
        ),
      ),
    ),

    // =================== Card Theme - Responsive ===================
    cardTheme: CardThemeData(
      color: AppColors.white,
      surfaceTintColor: Colors.transparent,
      shadowColor: AppColors.black.withOpacity(0.1),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(R.borderLG),
      ),
      margin: EdgeInsets.all(R.marginSMValue),
    ),

    // =================== Progress Indicator Theme ===================
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryOrange,
      circularTrackColor: AppColors.lightOrange,
    ),

    // =================== Checkbox Theme - Responsive ===================
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryOrange;
        }
        return Colors.transparent;
      }),
      checkColor: const WidgetStatePropertyAll(AppColors.white),
      side: BorderSide(
        color: AppColors.white,
        width: 2.r,
      ), // ✅ Responsive border
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(R.borderSM), // ✅ Responsive border
      ),
    ),

    // =================== Switch Theme ===================
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.white;
        }
        return AppColors.textSecondary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryOrange;
        }
        return AppColors.lightOrange;
      }),
    ),

    // =================== Icon Theme - Responsive ===================
    iconTheme: IconThemeData(
      color: AppColors.white,
      size: R.iconBase, // ✅ Responsive icon size
    ),

    // =================== Divider Theme - Responsive ===================
    dividerTheme: DividerThemeData(
      color: Colors.white.withOpacity(0.2),
      thickness: 1.r, // ✅ Responsive thickness
      space: 1.r, // ✅ Responsive space
    ),
  );

  // =================== Dark Theme ===================
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryOrange,
      brightness: Brightness.dark,
      primary: AppColors.primaryOrange,
      secondary: AppColors.primaryBlue,
      surface: AppColors.backgroundDark,
      background: AppColors.backgroundDark,
      error: AppColors.error,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.white,
      onBackground: AppColors.white,
      onError: AppColors.white,
    ),

    scaffoldBackgroundColor: AppColors.backgroundDark,
    primaryColor: AppColors.primaryOrange,

    // Copy themes from light theme with dark adaptations
    appBarTheme: lightTheme.appBarTheme.copyWith(
      backgroundColor: AppColors.backgroundDark,
    ),

    textTheme: lightTheme.textTheme,
    elevatedButtonTheme: lightTheme.elevatedButtonTheme,
    outlinedButtonTheme: lightTheme.outlinedButtonTheme,
    textButtonTheme: lightTheme.textButtonTheme,
    inputDecorationTheme: lightTheme.inputDecorationTheme,
    cardTheme: lightTheme.cardTheme.copyWith(color: AppColors.surfaceDark),
    dialogTheme: lightTheme.dialogTheme.copyWith(
      backgroundColor: AppColors.surfaceDark,
    ),
    checkboxTheme: lightTheme.checkboxTheme,
    switchTheme: lightTheme.switchTheme,
    iconTheme: lightTheme.iconTheme,
    dividerTheme: lightTheme.dividerTheme,
  );

  // =================== Helper Methods - Responsive ===================

  /// Get theme based on brightness
  static ThemeData getTheme(bool isDark) {
    return isDark ? darkTheme : lightTheme;
  }

  /// Get primary button style - Responsive
  static ButtonStyle getPrimaryButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryOrange,
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          R.borderButtonValue,
        ), // ✅ Responsive
      ),
      padding: EdgeInsets.symmetric(
        horizontal: R.paddingMDValue, // ✅ Responsive
        vertical: R.paddingSMValue, // ✅ Responsive
      ),
      minimumSize: Size(
        double.infinity,
        R.adaptiveButtonHeight,
      ), // ✅ Responsive
      textStyle: TextStyle(
        fontSize: R.textMD, // ✅ Responsive
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// Get secondary button style - Responsive
  static ButtonStyle getSecondaryButtonStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: AppColors.white,
      side: BorderSide(
        color: AppColors.secondaryOrange,
        width: 1.r,
      ), // ✅ Responsive
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          R.borderButtonValue,
        ), // ✅ Responsive
      ),
      padding: EdgeInsets.symmetric(
        horizontal: R.paddingMDValue, // ✅ Responsive
        vertical: R.paddingSMValue, // ✅ Responsive
      ),
      minimumSize: Size(
        double.infinity,
        R.adaptiveButtonHeight,
      ), // ✅ Responsive
      textStyle: TextStyle(
        fontSize: R.textMD, // ✅ Responsive
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// Get social button style - Responsive
  static ButtonStyle getSocialButtonStyle({Color? backgroundColor}) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? Colors.white.withOpacity(0.1),
      foregroundColor: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(R.borderBase), // ✅ Responsive
        side: BorderSide(
          color: Colors.white.withOpacity(0.2),
          width: 1.r, // ✅ Responsive
        ),
      ),
      padding: EdgeInsets.all(R.paddingMDValue), // ✅ Responsive
      minimumSize: Size(60.w, 60.h), // ✅ Responsive
    );
  }

  /// Get input decoration for forms - Responsive
  static InputDecoration getInputDecoration({
    required String hintText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixIconPressed,
    bool isDense = true,
  }) {
    return InputDecoration(
      hintText: hintText,
      isDense: isDense,
      hintStyle: TextStyle(
        color: Colors.white.withOpacity(0.5),
        fontSize: R.textSM,
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 16.r),
      prefixIcon:
          prefixIcon != null
              ? Icon(
                prefixIcon,
                color: Colors.white.withOpacity(0.7),
                size: R.iconBase, // ✅ Responsive icon size
              )
              : null,
      suffixIcon:
          suffixIcon != null
              ? IconButton(
                icon: Icon(
                  suffixIcon,
                  color: Colors.white.withOpacity(0.7),
                  size: R.iconBase, // ✅ Responsive icon size
                ),
                onPressed: onSuffixIconPressed,
              )
              : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
        borderSide: BorderSide(color: AppColors.primaryOrange, width: 1.5.r),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
        borderSide: BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
        borderSide: BorderSide(color: AppColors.error),
      ),
    );
  }

  // =================== Adaptive Theme Methods ===================

  /// Get adaptive text style based on device
  static TextStyle getAdaptiveTextStyle({
    required double baseFontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return TextStyle(
      fontSize: baseFontSize.sp,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? AppColors.white,
    );
  }

  /// Get adaptive padding based on device
  static EdgeInsets getAdaptivePadding({
    double all = 0,
    double horizontal = 0,
    double vertical = 0,
  }) {
    if (all > 0) {
      return EdgeInsets.all(all.r); // ✅ Responsive
    }
    return EdgeInsets.symmetric(
      horizontal: horizontal.r, // ✅ Responsive
      vertical: vertical.r, // ✅ Responsive
    );
  }

  /// Get adaptive border radius
  static BorderRadius getAdaptiveBorderRadius(double radius) {
    return BorderRadius.circular(radius.r); // ✅ Responsive
  }

  /// Get adaptive button height based on device
  static double getAdaptiveButtonHeight() {
    return R.adaptiveButtonHeight; // ✅ Uses responsive logic
  }

  /// Get adaptive icon size based on context
  static double getAdaptiveIconSize(String size) {
    switch (size) {
      case 'small':
        return R.iconSM;
      case 'base':
        return R.iconBase;
      case 'large':
        return R.iconLG;
      case 'xl':
        return R.iconXL;
      default:
        return R.iconBase;
    }
  }
}
