import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/theme/app_font_style.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/widgets/blurred_background.dart';
import 'package:fitness_app/core/widgets/grid_view_custom_container.dart';
import 'package:fitness_app/core/widgets/grid_view_custom_widget.dart';
import 'package:fitness_app/features/food_details/presentation/cubit/food_details_cubit.dart';
import 'package:fitness_app/features/food_details/presentation/cubit/food_details_intent.dart';
import 'package:fitness_app/features/food_details/presentation/widgets/header_details_widget.dart';
import 'package:fitness_app/features/food_details/presentation/widgets/ingredient_list_widget.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_on_category_response/meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FoodDetailsPage extends StatelessWidget {
  final FoodDetailsArgs args;
  const FoodDetailsPage({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FoodDetailsCubit>()
        ..foodDetailsIntent(
          GetFoodDetails(mealID: args.mealID),
        ),
      child: Scaffold(
        body: BlurredBackground(
          isScrollable: true,
          child: BlocConsumer<FoodDetailsCubit, FoodDetailsState>(
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.getDetails) {
                case LoadingState():
                case SuccessState():
                  return Skeletonizer(
                    enabled: state.getDetails is! SuccessState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderDetailsWidget(),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'ingredients',
                            style: AppFontStyle.customAppFont.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        IngredientListWidget(),
                        if (args.meals.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Recommendation',
                              style: AppFontStyle.customAppFont.copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          GridViewCustomWidget(
                            disableScroll: true,
                            itemCount:
                                args.meals.length > 4 ? 4 : args.meals.length,
                            itemBuilder: (p0, index) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.foodDetailsScreen,
                                  arguments: FoodDetailsArgs(
                                    mealID: args.meals[index].idMeal ?? '',
                                    meals: args.meals,
                                  ),
                                );
                              },
                              child: GridViewCustomContainer(
                                imagePath: args.meals[index].strMealThumb ?? '',
                                foodName: args.meals[index].strMeal ?? '',
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ],
                    ),
                  );
                default:
                  return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}

class FoodDetailsArgs {
  final String mealID;
  final List<Meal> meals;

  FoodDetailsArgs({
    required this.mealID,
    required this.meals,
  });
}
