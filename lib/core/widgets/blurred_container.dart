import 'dart:ui';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class BlurredContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color backgroundColor;
  final double backgroundBlur;
  final List<BoxShadow>? boxShadow;
  final double? gap;
  final Alignment alignment;

  const BlurredContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.borderRadius = 50,
    this.backgroundColor = AppColors.blurBackground,
    this.backgroundBlur = 34.6,
    this.boxShadow,
    this.gap = 8,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: backgroundBlur,
          sigmaY: backgroundBlur,
        ),
        child: Container(
          width: width,
          height: height,
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius.r),
            boxShadow: boxShadow,
          ),
          child: child,
        ),
      ),
    );
  }
}
