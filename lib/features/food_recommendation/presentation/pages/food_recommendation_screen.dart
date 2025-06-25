import 'package:fitness_app/core/Constant/app_constants.dart';
import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_intent.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_recommendation_state.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_recommendation_viewmodel.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/food_categories_tabbar.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/food_error_view.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/food_grid_loading.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/food_grid_view_widget.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/food_tab_bar_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FoodRecommendationScreen extends StatefulWidget {
  const FoodRecommendationScreen({super.key});

  @override
  State<FoodRecommendationScreen> createState() => _FoodRecommendationScreen();
}

class _FoodRecommendationScreen extends State<FoodRecommendationScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _hasLoadedInitialMeals = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 0, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FoodRecommendationViewModel>().doIntent(
        const GetMealsCategoriesIntent(),
      );
    });
  }

  void _updateTabController(int tabCount) {
    if (tabCount <= 0) return;
    final previousIndex = _tabController.length > 0 ? _tabController.index : 0;
    _tabController.dispose();
    _tabController = TabController(
      length: tabCount,
      vsync: this,
      initialIndex: previousIndex < tabCount ? previousIndex : 0,
    );
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        context.read<FoodRecommendationViewModel>().doIntent(
          ChangeSelectedCategoryIntent(_tabController.index),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodRecommendationViewModel, FoodRecommendationState>(
      buildWhen:
          (previous, current) =>
              previous.selectedCategoryIndex != current.selectedCategoryIndex ||
              previous.foodCategoriesState != current.foodCategoriesState ||
              previous.mealsByCategoryState != current.mealsByCategoryState ||
              previous.cachedMeals != current.cachedMeals ||
              previous.loadingCategories != current.loadingCategories,
      listenWhen:
          (previous, current) =>
              previous.foodCategoriesState != current.foodCategoriesState ||
              previous.selectedCategoryIndex != current.selectedCategoryIndex,
      listener: (context, state) {
        state.foodCategoriesState?.whenOrNull(
          success: (data) {
            final categories = data ?? [];
            if (categories.isNotEmpty &&
                _tabController.length != categories.length) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  _updateTabController(categories.length);
                }
              });
              if (!_hasLoadedInitialMeals) {
                _hasLoadedInitialMeals = true;
                final categoryName = categories[0].strCategory ?? '';
                context.read<FoodRecommendationViewModel>().doIntent(
                  GetMealsByCategoryIntent(categoryName),
                );
              }
            }
          },
          error: (error) {
            context.showErrorSnackBar(error ?? '');
          },
        );
        state.mealsByCategoryState?.whenOrNull(
          error: (error) {
            context.showErrorSnackBar(error ?? '');
          },
        );
        // Sync TabController
        if (_tabController.length > 0 &&
            _tabController.index != state.selectedCategoryIndex &&
            state.selectedCategoryIndex < _tabController.length) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && !_tabController.indexIsChanging) {
              _tabController.animateTo(state.selectedCategoryIndex);
            }
          });
        }
      },
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppConstants.foodBgImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(context.l10n.food_Recommendation_title),
              centerTitle: true,
              leadingWidth: 35.r,
              elevation: 0,
              leading: SvgPicture.asset(AppConstants.customBackIcon)
                  .onTap(() {
                    // Navigator.of(context).pop();
                  })
                  .paddingAll(2.r),
            ),
            body: Column(
              children: [
                // TabBar Widget
                state.foodCategoriesState?.whenOrNull(
                      loading: () => const FoodTabBarLoading(),
                      initial: () => const FoodTabBarLoading(),
                      success: (categories) {
                        final categoryList = categories ?? [];
                        if (_tabController.length == categoryList.length) {
                          return FoodCategoriesTabbar(
                            tabController: _tabController,
                            categories: categoryList,
                            selectedCategoryIndex: _tabController.index,
                          );
                        } else {
                          return const FoodTabBarLoading();
                        }
                      },
                    ) ??
                    const SizedBox.shrink(),
                SizedBox(height: R.spaceMD),
                Expanded(
                  child:
                      state.foodCategoriesState?.when(
                        initial: () => FoodGridLoading(),
                        loading: () => const FoodGridLoading(),
                        success: (categories) {
                          final categoryList = categories ?? [];
                          if (categoryList.isEmpty) {
                            return SizedBox.shrink();
                          }
                          if (_tabController.length != categoryList.length) {
                            return const FoodGridLoading();
                          }
                          return state.mealsByCategoryState?.when(
                                initial: () => const FoodGridLoading(),
                                loading: () => const FoodGridLoading(),
                                success:
                                    (meals) => FoodGridViewWidget(
                                      tabController: _tabController,
                                      categories: categoryList,
                                      cachedMeals: state.cachedMeals,
                                      loadingCategories:
                                          state.loadingCategories,
                                      selectedCategoryIndex:
                                          state.selectedCategoryIndex,
                                    ),
                                error:
                                    (error) => FoodErrorView(
                                      categoryList: categoryList,
                                      error: error,
                                      foodRecommendationViewModel:
                                          context
                                              .read<
                                                FoodRecommendationViewModel
                                              >(),
                                      selectedCategoryIndex:
                                          state.selectedCategoryIndex,
                                      onPressed: () {
                                        context
                                            .read<FoodRecommendationViewModel>()
                                            .doIntent(
                                              GetMealsByCategoryIntent(
                                                categoryList[state
                                                            .selectedCategoryIndex]
                                                        .strCategory ??
                                                    '',
                                              ),
                                            );
                                      },
                                    ),
                              ) ??
                              FoodGridLoading();
                        },
                        error:
                            (error) => FoodErrorView(
                              categoryList: [],
                              error: error,
                              foodRecommendationViewModel:
                                  context.read<FoodRecommendationViewModel>(),
                              selectedCategoryIndex:
                                  state.selectedCategoryIndex,
                              onPressed: () {
                                context
                                    .read<FoodRecommendationViewModel>()
                                    .doIntent(GetMealsCategoriesIntent());
                              },
                            ),
                      ) ??
                      const FoodGridLoading(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
