import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_categories_response/meals_categories_response.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_on_category_response/meals_on_category_response.dart';

abstract interface class FoodRecommendRemoteDataSource {
  Future<ApiResult<MealsCategoriesResponse>> getMealsCategories();
  Future<ApiResult<MealsOnCategoryResponse>> getMealsByCategory(
    String category,
  );
}
