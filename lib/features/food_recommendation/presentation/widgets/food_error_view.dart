import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_categories_response/food_category.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_recommendation_viewmodel.dart';
import 'package:flutter/material.dart';

class FoodErrorView extends StatelessWidget {
  final String? error;
  final List<FoodCategory> categoryList;
  final int selectedCategoryIndex;
  final void Function()? onPressed;
  final FoodRecommendationViewModel foodRecommendationViewModel;
  const FoodErrorView({
    super.key,
    required this.error,
    required this.categoryList,
    required this.selectedCategoryIndex,
    required this.foodRecommendationViewModel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.restaurant_menu, color: AppColors.red, size: 48.r),
          R.spaceH16,
          Text(
            context.l10n.food_food_Recommendation_fail_to_loadCategories,
            style: TextStyle(color: AppColors.white, fontSize: 16.sp),
          ),
          R.spaceH8,
          Text(
            error ?? '',
            style: TextStyle(color: AppColors.white, fontSize: 12.sp),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          R.spaceH16,
          ElevatedButton(
            onPressed: onPressed,
            child: Text(context.l10n.retry),
          ).paddingAll(R.paddingMDValue),
        ],
      ),
    );
  }
}
