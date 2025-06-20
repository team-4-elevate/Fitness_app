import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food/data/models/meals_response.dart';

abstract interface class FoodRepo {
  Future<ApiResult<MealsResponse>> getMeals(String categoryName);
}
