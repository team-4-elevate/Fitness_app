import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food_recommendation/data/datasources/food_recommend_remote_data_source.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_categories_response/meals_categories_response.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_on_category_response/meals_on_category_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FoodRecommendRemoteDataSource)
class FoodRecommendRemoteDataSourceImpl
    implements FoodRecommendRemoteDataSource {
  final ApiClient _apiClient;
  FoodRecommendRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<MealsOnCategoryResponse>> getMealsByCategory(
    String category,
  ) async {
    var response = await _apiClient.get(
      ApiConstants.foodRecommendedMealsEndpoint,
      baseUrl: ApiConstants.foodRecommendBaseUrl,
      queryParameters: {'c': category},
    );
    return response.map((data) {
      return MealsOnCategoryResponse.fromJson(data);
    });
  }

  @override
  Future<ApiResult<MealsCategoriesResponse>> getMealsCategories() async {
    var response = await _apiClient.get(
      ApiConstants.foodRecommendedCategoriesEndpoint,
      baseUrl: ApiConstants.foodRecommendBaseUrl,
    );

    return response.map((data) {
      return MealsCategoriesResponse.fromJson(data);
    });
  }
}
