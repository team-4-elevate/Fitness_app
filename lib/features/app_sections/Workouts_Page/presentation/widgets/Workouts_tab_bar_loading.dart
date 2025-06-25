import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class WorkoutTabBarLoading extends StatelessWidget {
  const WorkoutTabBarLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 4,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder:
            (context, index) => ShimmerLoading(
              baseColor: AppColors.gray.withOpacity(0.3),
              highlightColor: AppColors.white.withOpacity(0.1),
              child: ShimmerBox(
                width: 90.w,
                height: 36.h,
                borderRadius: BorderRadius.circular(18.r),
              ),
            ),
      ),
    );
  }
}
