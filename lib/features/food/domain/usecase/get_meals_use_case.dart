import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food/data/models/meals_response.dart';
import 'package:fitness_app/features/food/domain/repository/food_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMealsUseCase {
  final FoodRepo foodRepo;
  GetMealsUseCase(this.foodRepo);

  Future<ApiResult<MealsResponse>> execute(String categoryName) async {
    return await foodRepo.getMeals(categoryName);
  }
}
