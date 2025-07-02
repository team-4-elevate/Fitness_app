// features/upcoming_workout_seeAll/presentation/widgets/workout_shimmer_tab_bar.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WorkoutShimmerTabBar extends StatelessWidget {
  const WorkoutShimmerTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Shimmer.fromColors(
        baseColor: AppColors.backgroundDark,
        highlightColor: AppColors.shimmerBaseColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              5,
              (index) => Container(
                margin:
                    EdgeInsets.only(left: index == 0 ? 16.w : 8.w, right: 8.w),
                width: 80.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
