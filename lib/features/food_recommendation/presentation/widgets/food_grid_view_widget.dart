import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_recommendation_state.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/food_grid_loading.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/grid_view_custom_container.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/grid_view_custom_widget.dart';
import 'package:flutter/material.dart';

class FoodGridViewWidget extends StatelessWidget {
  final TabController tabController;
  final FoodRecommendationState state;
  const FoodGridViewWidget({
    super.key,
    required this.tabController,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(tabController.length, (index) {
        final categories =
            state.foodCategoriesState?.whenOrNull(
              success: (data) => data ?? [],
            ) ??
            [];

        if (index >= categories.length) {
          return const FoodGridLoading();
        }

        final category = categories[index];
        final categoryKey = category.strCategory?.toLowerCase() ?? '';
        final cachedMeals = state.cachedMeals[categoryKey] ?? [];
        final isLoading = state.loadingCategories.contains(categoryKey);

        if (isLoading && cachedMeals.isEmpty) {
          return const FoodGridLoading();
        }

        if (cachedMeals.isEmpty) {
          return Center(
            child: Text(
              state.mealsByCategoryState?.whenOrNull(
                    error: (error) => error.toString(),
                  ) ??
                  '',
              style: const TextStyle(color: AppColors.white),
            ),
          );
        }

        return GridViewCustomWidget(
          itemCount: cachedMeals.length,
          itemBuilder: (context, index) {
            final meal = cachedMeals[index];
            return GridViewCustomContainer(
              foodName: meal.strMeal ?? '',
              imagePath: meal.strMealThumb ?? '',
            );
          },
        );
      }),
    );
  }
}
