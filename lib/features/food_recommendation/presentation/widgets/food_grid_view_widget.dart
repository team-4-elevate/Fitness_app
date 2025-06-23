import 'package:fitness_app/features/food_recommendation/data/models/meals_categories_response/food_category.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_on_category_response/meal.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/food_grid_loading.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/grid_view_custom_container.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/grid_view_custom_widget.dart';
import 'package:flutter/material.dart';

class FoodGridViewWidget extends StatelessWidget {
  final TabController tabController;
  final List<FoodCategory> categories;
  final Map<String, List<Meal>> cachedMeals;
  final Set<String> loadingCategories;
  final int selectedCategoryIndex;

  const FoodGridViewWidget({
    super.key,
    required this.tabController,
    required this.categories,
    required this.cachedMeals,
    required this.loadingCategories,
    required this.selectedCategoryIndex,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      physics: const NeverScrollableScrollPhysics(),
      children:
          categories.asMap().entries.map((entry) {
            final category = entry.value;
            final categoryKey = category.strCategory?.toLowerCase() ?? '';
            final meals = cachedMeals[categoryKey] ?? [];
            final isLoading = loadingCategories.contains(categoryKey);

            if (isLoading) {
              return const FoodGridLoading();
            }

            if (meals.isNotEmpty) {
              return GridViewCustomWidget(
                itemCount: meals.length,
                itemBuilder: (context, mealIndex) {
                  final meal = meals[mealIndex];
                  return GridViewCustomContainer(
                    foodName: meal.strMeal ?? '',
                    imagePath: meal.strMealThumb ?? '',
                  );
                },
              );
            }

            // Empty state
            return SizedBox.shrink();
          }).toList(),
    );
  }
}
