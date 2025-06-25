import 'package:fitness_app/core/responsive/responsive.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class WorkoutGridLoading extends StatelessWidget {
  const WorkoutGridLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: R.gridColumns,
        childAspectRatio: 1.11,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
      ),
      itemCount: 12,
      itemBuilder:
          (context, index) => ShimmerLoading(
            baseColor: AppColors.gray.withOpacity(0.3),
            highlightColor: AppColors.white.withOpacity(0.1),
            child: ShimmerBox(
              width: double.infinity,
              height: 160.h,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
    );
  }
}
