import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_on_category_response/meal.dart';
import 'package:fitness_app/features/food_recommendation/domain/repositories/food_recommend_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMealsOnCategoryUseCase {
  GetMealsOnCategoryUseCase(this._repo);

  final FoodRecommendRepo _repo;

  Future<ApiResult<List<Meal>>> call(String category) async {
    return _repo.getMealsByCategory(category);
  }
}
