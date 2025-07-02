import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_categories_response/food_category.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_on_category_response/meal.dart';

abstract interface class FoodRecommendRepo {
  Future<ApiResult<List<FoodCategory>>> getMealsCategories();
  Future<ApiResult<List<Meal>>> getMealsByCategory(String category);
}
