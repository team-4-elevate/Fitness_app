// features/home/presentation/widgets/skeleton.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.r,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 104.r,
            height: 104.r,
            margin: EdgeInsets.symmetric(vertical: 5.r, horizontal: 8.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8.r,
                  offset: Offset(0, 4.r),
                ),
              ],
            ),
            child: Skeletonizer(
              enabled: true,
              effect: ShimmerEffect(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.black,
                duration: const Duration(milliseconds: 1500),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: AppColors.surfaceDark,
                    ),
                    Positioned(
                      top: 10.r,
                      left: 10.r,
                      right: 10.r,
                      height: 60.r,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.shimmerHighlightColor,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: 40.r,
                      child: Container(
                        color: AppColors.surfaceDark.withOpacity(0.5),
                      ),
                    ),
                    Positioned(
                      left: 10.r,
                      right: 10.r,
                      bottom: 12.r,
                      child: Container(
                        height: 16.r,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.textSecondary,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
