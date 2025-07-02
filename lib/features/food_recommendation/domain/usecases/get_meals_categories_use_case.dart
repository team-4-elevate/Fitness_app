import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_categories_response/food_category.dart';
import 'package:fitness_app/features/food_recommendation/domain/repositories/food_recommend_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMealsCategoriesUseCase {
  GetMealsCategoriesUseCase(this._repo);
  final FoodRecommendRepo _repo;
  Future<ApiResult<List<FoodCategory>>> call() async {
    return _repo.getMealsCategories();
  }
}
