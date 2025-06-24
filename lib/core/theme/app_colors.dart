import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Color intensity constants
  static const int baseColor = 1000;
  static const int colorCode10 = 10;
  static const int colorCode20 = 20;
  static const int colorCode30 = 30;
  static const int colorCode40 = 40;
  static const int colorCode50 = 50;
  static const int colorCode60 = 60;
  static const int colorCode70 = 70;
  static const int colorCode80 = 80;
  static const int colorCode90 = 90;
  static const int colorCode100 = 100;

  // =================== Primary Colors ===================
  static const Color primaryOrange = Color(0xFFFF4100);
  static const Color secondaryOrange = Color(0xffFF6A00);
  static const Color primaryBlue = Color(0xFF02369C);

  // =================== Basic Colors ===================
  static const Color green = Color(0xFF11CE19);
  static const Color red = Color(0xFFCC1010);
  static const Color gray = Color(0xFF535353);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkWhite = Color(0xFFD9D9D9);
  static const Color black = Color(0xFF000000);
  static const Color error = Color(0xFFCC1010);

  // =================== Background Colors ===================
  static const Color backgroundDark = Color(0xFF1A1A1A); // Dark background
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF242424);
  static const Color surfaceLight = Color(0xFFF5F5F5);

  // =================== Text Colors ===================
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textOnLight = Color(0xFF000000);

  // =================== Light Colors ===================
  static const Color lightOrange = Color(0xFFFFE5D9);
  static const Color lightBlue = Color(0xFFE3EAFF);

  // =================== Blur Effect Colors ===================
  static const Color blurBackground = Color(0x80000000); // 50% opacity black
  static const Color glassEffect = Color(0x1AFFFFFF); // 10% opacity white

  // =================== Shimmer Effect Colors ===================
  static const Color shimmerBaseColor = Color(0xFF3A3A3A);   // Dark base for shimmer on dark backgrounds
  static const Color shimmerHighlightColor = Color(0xFF525252); // Slightly lighter for shimmer effect
}
