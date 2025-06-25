import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class CustomTabbarTab extends StatelessWidget {
  final String? title;
  final bool isSelected;
  const CustomTabbarTab({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(R.paddingSMValue),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryOrange : null,
        borderRadius: BorderRadius.circular(360.r),
      ),
      child: Text(
        title ?? '',
        style: context.textTheme.bodyMedium?.copyWith(
          color: AppColors.white,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
