import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_categories_response/food_category.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_intent.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_recommendation_viewmodel.dart';
import 'package:fitness_app/core/widgets/custom_tabbar_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodCategoriesTabbar extends StatelessWidget {
  final TabController tabController;
  final List<FoodCategory> categories;
  final int selectedCategoryIndex;
  const FoodCategoriesTabbar({
    super.key,
    required this.tabController,
    required this.categories,
    required this.selectedCategoryIndex,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
          controller: tabController,
          isScrollable: true,
          unselectedLabelColor: AppColors.white,
          dividerColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          indicator: const BoxDecoration(),
          tabAlignment: TabAlignment.start,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: (index) {
            context.read<FoodRecommendationViewModel>().doIntent(
              ChangeSelectedCategoryIntent(index),
            );
            final categoryName = categories[index].strCategory ?? '';
            context.read<FoodRecommendationViewModel>().doIntent(
              GetMealsByCategoryIntent(categoryName),
            );
          },
          tabs:
              categories.map((category) {
                return Tab(
                  child: CustomTabbarTab(
                    title: category.strCategory,
                    isSelected:
                        selectedCategoryIndex == categories.indexOf(category),
                  ),
                );
              }).toList(),
        );
  }
}
