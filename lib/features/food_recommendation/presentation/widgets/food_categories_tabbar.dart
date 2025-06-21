import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_intent.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_recommendation_state.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_recommendation_viewmodel.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/custom_tabbar_tab.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/food_tab_bar_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodCategoriesTabbar extends StatelessWidget {
  final TabController tabController;
  final FoodRecommendationState state;
  const FoodCategoriesTabbar({super.key, 
    required this.tabController,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return state.foodCategoriesState?.when(
          initial: () => const FoodTabBarLoading(),
          loading: () => const FoodTabBarLoading(),
          error:
              (error) => Padding(
                padding: EdgeInsets.symmetric(vertical: R.paddingMDValue),
                child: Center(
                  child: Text(
                    ' ${error ?? ''}',
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              ),
          success: (data) {
            final categories = data ?? [];
            if (categories.isEmpty) {
              return  Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    context.l10n.food_Recommendation_no_categories,
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              );
            }

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
                // Dispatch intent to change selected category
                context.read<FoodRecommendationViewModel>().doIntent(
                  ChangeSelectedCategoryIntent(index),
                );

                final categoryName = categories[index].strCategory ?? '';
                final categoryKey = categoryName.toLowerCase();

                if (!state.cachedMeals.containsKey(categoryKey)) {
                  // Dispatch intent to get meals for selected category
                  context.read<FoodRecommendationViewModel>().doIntent(
                    GetMealsByCategoryIntent(categoryName),
                  );
                }
              },
              tabs:
                  categories.map((category) {
                    final index = categories.indexOf(category);
                    return Tab(
                      child: CustomTabbarTab(
                        title: category.strCategory,
                        isSelected: state.selectedCategoryIndex == index,
                      ),
                    );
                  }).toList(),
            );
          },
        ) ??
        const FoodTabBarLoading();
  }
}
