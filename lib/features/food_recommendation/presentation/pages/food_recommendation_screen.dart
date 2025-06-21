import 'package:fitness_app/core/Constant/app_constants.dart';
import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_intent.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_recommendation_state.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_recommendation_viewmodel.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/food_categories_tabbar.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/food_grid_loading.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/food_grid_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FoodRecommendationScreen extends StatefulWidget {
  const FoodRecommendationScreen({super.key});

  @override
  State<FoodRecommendationScreen> createState() =>
      _FoodRecommendationMviScreenState();
}

class _FoodRecommendationMviScreenState extends State<FoodRecommendationScreen>
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
    setState(() {
      _tabController.dispose();
      _tabController = TabController(length: tabCount, vsync: this);
      _tabController.addListener(() {
        if (!_tabController.indexIsChanging) {
          context.read<FoodRecommendationViewModel>().doIntent(
            ChangeSelectedCategoryIntent(_tabController.index),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodRecommendationViewModel, FoodRecommendationState>(
      listener: (context, state) {
        state.foodCategoriesState?.whenOrNull(
          success: (data) {
            final categories = data ?? [];
            if (categories.isNotEmpty) {
              if (_tabController.length != categories.length) {
                _updateTabController(categories.length);
              }
              if (!_hasLoadedInitialMeals) {
                _hasLoadedInitialMeals = true;
                final categoryName = categories[0].strCategory ?? '';
                if (!state.cachedMeals.containsKey(
                  categoryName.toLowerCase(),
                )) {
                  context.read<FoodRecommendationViewModel>().doIntent(
                    GetMealsByCategoryIntent(categoryName),
                  );
                }
              }
            }
          },
        );
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
              title:  Text(context.l10n.food_Recommendation_title),
              centerTitle: true,
              leadingWidth: 35.r,
              elevation: 0,
              leading: SvgPicture.asset(AppConstants.customBackIcon)
                  .onTap(() {
                    Navigator.of(context).pop();
                  })
                  .paddingAll(2.r),
            ),
            body: Column(
              children: [
                // TabBar with categories from state
                FoodCategoriesTabbar(
                  state: state,
                  tabController: _tabController,
                ),
                SizedBox(height: R.spaceMD),
                Expanded(
                  child:
                      _tabController.length > 0
                          ?FoodGridViewWidget(state: state, tabController: _tabController)
                          : const FoodGridLoading(),
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
