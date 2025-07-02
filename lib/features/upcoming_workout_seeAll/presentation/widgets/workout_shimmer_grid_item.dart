// features/upcoming_workout_seeAll/presentation/widgets/workout_shimmer_grid_item.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WorkoutShimmerGridItem extends StatelessWidget {
  const WorkoutShimmerGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Shimmer.fromColors(
        baseColor: AppColors.backgroundDark,
        highlightColor: AppColors.shimmerBaseColor,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(color: AppColors.blurBackground),
              Positioned(
                left: 10,
                right: 10,
                bottom: 10,
                child: Container(
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
