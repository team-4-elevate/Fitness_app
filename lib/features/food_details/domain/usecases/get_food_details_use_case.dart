import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food_details/domain/entities/meal_entity.dart';
import 'package:fitness_app/features/food_details/domain/repositories/food_details_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetFoodDetailsUseCase {
  final FoodDetailsRepo _repo;
  GetFoodDetailsUseCase(this._repo);

  Future<ApiResult<MealEntity>> call(String mealID) async {
    return await _repo.getFoodDetails(mealID);
  }
}
