import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_categories_response/food_category.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_on_category_response/meal.dart';

class FoodRecommendationState extends Equatable {
  final AppStates<List<FoodCategory>>? foodCategoriesState;
  final AppStates<List<Meal>>? mealsByCategoryState;
  final int selectedCategoryIndex;
  final Map<String, List<Meal>> cachedMeals;
  final Set<String> loadingCategories;
  final List<FoodCategory> categories;

  const FoodRecommendationState({
    this.foodCategoriesState,
    this.mealsByCategoryState,
    this.selectedCategoryIndex = 0,
    this.cachedMeals = const {},
    this.loadingCategories = const {},
    this.categories = const [],
  });

  FoodRecommendationState copyWith({
    AppStates<List<FoodCategory>>? foodCategoriesState,
    AppStates<List<Meal>>? mealsByCategoryState,
    int? selectedCategoryIndex,
    Map<String, List<Meal>>? cachedMeals,
    Set<String>? loadingCategories,
    List<FoodCategory>? categories,
  }) {
    return FoodRecommendationState(
      foodCategoriesState: foodCategoriesState ?? this.foodCategoriesState,
      mealsByCategoryState: mealsByCategoryState ?? this.mealsByCategoryState,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      cachedMeals: cachedMeals ?? this.cachedMeals,
      loadingCategories: loadingCategories ?? this.loadingCategories,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [
        foodCategoriesState,
        mealsByCategoryState,
        selectedCategoryIndex,
        cachedMeals,
        loadingCategories,
        categories,
      ];
}
