import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food_details/domain/entities/meal_entity.dart';

abstract class FoodDetailsRepo {
  Future<ApiResult<MealEntity>> getFoodDetails(String mealID);
}
