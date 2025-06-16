import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/responsive/responsive.dart';
import 'package:fitness_app/core/theme/app_font_style.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: AppFontStyle.customAppFont.fontFamily,

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

    // =================== App Bar Theme ===================
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: R.textXL, 
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
      ),
      iconTheme: IconThemeData(
        color: AppColors.white,
        size: R.iconLG, 
      ),
    ),

    // =================== Text Theme===================
    textTheme: TextTheme(
      // Headings - Responsive
      headlineLarge: TextStyle(
        fontSize: R.text4XL, // 32.sp
        fontWeight: FontWeight.bold,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
        color: AppColors.white,
        height: 1.2,
      ),
      headlineMedium: TextStyle(
        fontSize: R.text3XL, // 28.sp 
        fontWeight: FontWeight.bold,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
        color: AppColors.white,
        height: 1.2,
      ),
      headlineSmall: TextStyle(
        fontSize: R.text2XL, // 24.sp 
        fontWeight: FontWeight.w600,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
        color: AppColors.white,
        height: 1.3,
      ),

      // Titles - Responsive
      titleLarge: TextStyle(
        fontSize: R.textXL, //  20.sp 
        fontWeight: FontWeight.w600,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
        color: AppColors.white,
        height: 1.3,
      ),
      titleMedium: TextStyle(
        fontSize: R.textLG, // 18.sp
        fontWeight: FontWeight.w500,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
        color: AppColors.white,
        height: 1.4,
      ),
      titleSmall: TextStyle(
        fontSize: R.textMD, // 16.sp 
        fontWeight: FontWeight.w500,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
        color: AppColors.textSecondary,
        height: 1.4,
      ),

      // Body Text - Responsive
      bodyLarge: TextStyle(
        fontSize: R.textMD, // 16.sp
        fontWeight: FontWeight.normal,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
        color: AppColors.white,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: R.textBase, //  14.sp 
        fontWeight: FontWeight.normal,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
        color: AppColors.white,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontSize: R.textSM, //  12.sp 
        fontWeight: FontWeight.normal,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
        color: AppColors.textSecondary,
        height: 1.4,
      ),

      // Labels - Responsive
      labelLarge: TextStyle(
        fontSize: R.textBase, // 14.sp
        fontWeight: FontWeight.w500,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
        color: AppColors.white,
        height: 1.4,
      ),
      labelMedium: TextStyle(
        fontSize: R.textSM, // 12.sp 
        fontWeight: FontWeight.w500,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
        color: AppColors.textSecondary,
        height: 1.3,
      ),
      labelSmall: TextStyle(
        fontSize: R.textXS, // 10.sp 
        fontWeight: FontWeight.w500,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
        color: AppColors.textSecondary,
        height: 1.3,
      ),
    ),

    // =================== Elevated Button Theme===================
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryOrange,
        foregroundColor: AppColors.white,
        shadowColor: AppColors.primaryOrange.withOpacity(0.3),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            R.borderButtonValue,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: R.paddingSMValue, 
          vertical: R.paddingSMValue, 
        ),
        textStyle: TextStyle(
          fontSize: R.textMD, 
          fontWeight: FontWeight.w600,
          fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
          color: AppColors.white,
        ),
        minimumSize: Size(
          double.infinity,
          R.adaptiveButtonHeight,
        ),
      ),
    ),

    // =================== Outlined Button Theme===================
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.white,
        side: BorderSide(
          color: AppColors.white,
          width: 1.5.r,
        ), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            R.borderButtonValue,
          ), 
        ),
        padding: EdgeInsets.symmetric(
          horizontal: R.paddingSMValue, 
          vertical: R.paddingSMValue, 
        ),
        textStyle: TextStyle(
          fontSize: R.textMD,
          fontFamily:
              AppFontStyle.customAppFont.fontFamily, 
          fontWeight: FontWeight.w600,
        ),
        minimumSize: Size(
          double.infinity,
          R.adaptiveButtonHeight,
        ), 
      ),
    ),

    // =================== Text Button Theme ===================
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryOrange,
        textStyle: TextStyle(
          fontSize: R.textSM, 
          fontWeight: FontWeight.w600,
          fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
          decoration: TextDecoration.underline,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: R.paddingSMValue, 
          vertical: R.paddingXSValue, 
        ),
      ),
    ),

    // =================== Input Decoration Theme===================
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      constraints: BoxConstraints(maxHeight: R.space38, minHeight: R.space38),
      contentPadding: EdgeInsets.symmetric(
        horizontal: R.paddingSMValue,
        vertical: 0, 
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          R.borderInputValue,
        ),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.3),
          width: 1.r, // ✅ Responsive border width
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          R.borderInputValue,
        ), 
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.3),
          width: 1.r, 
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(R.borderInputValue),
        borderSide: BorderSide(
          color: AppColors.primaryOrange,
          width: 2.r, 
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(R.borderInputValue),
        borderSide: BorderSide(color: AppColors.error, width: 1.r),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(R.borderInputValue),
        borderSide: BorderSide(
          color: AppColors.error,
          width: 2.r, 
        ),
      ),

      // Text styles - Responsive
      hintStyle: TextStyle(
        color: Colors.white.withOpacity(0.6),
        fontSize: R.textBase,
        fontWeight: FontWeight.normal,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
      ),
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.8),
        fontSize: R.textBase,
        fontWeight: FontWeight.w500,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
      ),
      errorStyle: TextStyle(
        color: AppColors.error,
        fontSize: R.textSM, 
        fontWeight: FontWeight.w500,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
      ),

      // Icon styles - Responsive
      prefixIconColor: Colors.white.withOpacity(0.7),
      suffixIconColor: Colors.white.withOpacity(0.7),
    ),

    // =================== Dialog Theme ===================
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(R.borderLG),
      ),
      titleTextStyle: TextStyle(
        fontSize: R.textXL,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
      ),
      contentTextStyle: TextStyle(
        fontSize: R.textMD, 
        color: AppColors.textSecondary,
        fontFamily: AppFontStyle.customAppFont.fontFamily, // Custom font
      ),
    ),

    // =================== Bottom Sheet Theme - Responsive ===================
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(R.borderXL), 
        ),
      ),
    ),

    // =================== Card Theme - Responsive ===================
    cardTheme: CardTheme(
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

    // =================== Checkbox Theme ===================
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
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(R.borderSM),
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
      size: R.iconBase,
    ),

    // =================== Divider Theme - Responsive ===================
    dividerTheme: DividerThemeData(
      color: Colors.white.withOpacity(0.2),
      thickness: 1.r, 
      space: 1.r, 
    ),
  );

}
