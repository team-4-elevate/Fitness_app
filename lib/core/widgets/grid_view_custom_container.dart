// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class GridViewCustomContainer extends StatelessWidget {
  final String imagePath;
  final String foodName;

  const GridViewCustomContainer({
    super.key,
    required this.imagePath,
    required this.foodName,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: CachedNetworkImage(
        imageUrl: imagePath,
        fit: BoxFit.cover,
        memCacheHeight: 200,
        memCacheWidth: 200,

        // Loading shimmer placeholder
        placeholder:
            (context, url) => ShimmerLoading(
              baseColor: AppColors.gray.withOpacity(0.3),
              highlightColor: AppColors.white.withOpacity(0.1),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.gray.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_outlined,
                        color: AppColors.white.withOpacity(0.5),
                        size: 32.r,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Loading...',
                        style: TextStyle(
                          color: AppColors.white.withOpacity(0.5),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        errorWidget:
            (context, url, error) => Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.gray.withOpacity(0.4),
                    AppColors.gray.withOpacity(0.6),
                  ],
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.restaurant_menu_outlined,
                      color: AppColors.white.withOpacity(0.8),
                      size: 32.r,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Image not available',
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.8),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    foodName,
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.6),
                      fontSize: 10.sp,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
        imageBuilder:
            (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  // Gradient overlay for text readability
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      AppColors.black.withOpacity(0.4),
                      AppColors.black.withOpacity(0.8),
                    ],
                    stops: const [0.0, 0.3, 0.7, 1.0],
                  ),
                ),
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(R.paddingSMValue),
                child: Text(
                  foodName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 1),
                        blurRadius: 3,
                        color: AppColors.black.withOpacity(0.9),
                      ),
                      Shadow(
                        offset: const Offset(1, 1),
                        blurRadius: 6,
                        color: AppColors.black.withOpacity(0.7),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
      ),
    );
  }
}
