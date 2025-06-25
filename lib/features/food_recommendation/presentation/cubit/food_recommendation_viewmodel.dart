import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_on_category_response/meal.dart';
import 'package:fitness_app/features/food_recommendation/domain/usecases/get_meals_categories_use_case.dart';
import 'package:fitness_app/features/food_recommendation/domain/usecases/get_meals_on_category_use_case.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_intent.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_recommendation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FoodRecommendationViewModel extends Cubit<FoodRecommendationState> {
  FoodRecommendationViewModel(
    this._mealsCategoriesUseCase,
    this._mealsOnCategoryUseCase,
  ) : super(const FoodRecommendationState());

  final GetMealsCategoriesUseCase _mealsCategoriesUseCase;
  final GetMealsOnCategoryUseCase _mealsOnCategoryUseCase;

  void doIntent(FoodIntent intent) {
    switch (intent) {
      case GetMealsCategoriesIntent():
        _handleGetMealsCategoriesIntent();
        break;
      case GetMealsByCategoryIntent(categoryName: final categoryName):
        _handleGetMealsByCategoryIntent(categoryName);
        break;
      case ChangeSelectedCategoryIntent(index: final index):
        _handleChangeSelectedCategoryIntent(index);
        break;
    }
  }

  Future<void> _handleGetMealsCategoriesIntent() async {
    emit(state.copyWith(foodCategoriesState: const LoadingState()));
    var result = await _mealsCategoriesUseCase.call();
    result.when(
      success: (data) {
        emit(state.copyWith(foodCategoriesState: SuccessState(data)));
      },
      failure: (message) {
        emit(state.copyWith(foodCategoriesState: ErrorState(message)));
      },
    );
  }

  Future<void> _handleGetMealsByCategoryIntent(String categoryName) async {
    try {
      final categoryKey = categoryName.toLowerCase();
      if (state.cachedMeals.containsKey(categoryKey)) {
        return;
      }
      emit(
        state.copyWith(
          loadingCategories: {...state.loadingCategories, categoryKey},
        ),
      );
      var result = await _mealsOnCategoryUseCase.call(categoryName);
      result.when(
        success: (meals) {
          final updatedCache = Map<String, List<Meal>>.from(state.cachedMeals);
          final updatedLoading = Set<String>.from(state.loadingCategories);

          updatedCache[categoryKey] = meals;
          updatedLoading.remove(categoryKey);

          emit(
            state.copyWith(
              mealsByCategoryState: SuccessState(meals),
              cachedMeals: updatedCache,
              loadingCategories: updatedLoading,
            ),
          );
        },
        failure: (message) {
          final updatedLoading = Set<String>.from(state.loadingCategories);
          updatedLoading.remove(categoryKey);

          emit(
            state.copyWith(
              mealsByCategoryState: ErrorState(message),
              loadingCategories: updatedLoading,
            ),
          );
        },
      );
    } catch (e) {
      final categoryKey = categoryName.toLowerCase();
      final updatedLoading = Set<String>.from(state.loadingCategories);
      updatedLoading.remove(categoryKey);

      emit(
        state.copyWith(
          mealsByCategoryState: ErrorState(e.toString()),
          loadingCategories: updatedLoading,
        ),
      );
    }
  }

  void _handleChangeSelectedCategoryIntent(int index) {
    emit(state.copyWith(selectedCategoryIndex: index));
  }
}
