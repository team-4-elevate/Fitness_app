import 'dart:ui';

import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/theme/app_font_style.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class NutritionInfoCard extends StatelessWidget {
  final String value;
  final String label;
  const NutritionInfoCard({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          width: 70,
          decoration: BoxDecoration(
            color: AppColors.surfaceDark.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 0.5,
              color: Color(0xffD3D3D3),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: AppFontStyle.customAppFont.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                label,
                style: AppFontStyle.customAppFont.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.primaryOrange,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
