import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food_details/data/models/meal_details_response/meal.dart';

abstract class FoodDetailsRemoteDataSource {
  Future<ApiResult<Meal>> getFoodDetails(String mealID);
}
