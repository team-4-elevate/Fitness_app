import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food_recommendation/data/datasources/food_recommend_remote_data_source.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_categories_response/food_category.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_on_category_response/meal.dart';
import 'package:fitness_app/features/food_recommendation/domain/repositories/food_recommend_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FoodRecommendRepo)
class FoodRecommendRepoImpl implements FoodRecommendRepo {
  final FoodRecommendRemoteDataSource _dataSource;
  FoodRecommendRepoImpl(this._dataSource);
  @override
  Future<ApiResult<List<Meal>>> getMealsByCategory(String category) async {
    try {
      var response = await _dataSource.getMealsByCategory(category);
      return response.when(
        success: (data) {
          return ApiSuccess(data.meals ?? []);
        },
        failure: (message) {
          return ApiFailure(message);
        },
      );
    } catch (e) {
      return ApiFailure(e.toString());
    }
  }

  @override
  Future<ApiResult<List<FoodCategory>>> getMealsCategories() async {
    try {
      var response = await _dataSource.getMealsCategories();
      return response.when(
        success: (data) {
          return ApiSuccess(data.categories ?? []);
        },
        failure: (message) {
          return ApiFailure(message);
        },
      );
    } catch (e) {
      return ApiFailure(e.toString());
    }
  }
}
