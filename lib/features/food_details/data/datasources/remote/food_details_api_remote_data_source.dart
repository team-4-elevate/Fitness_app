import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food_details/data/datasources/remote/food_details_remote_data_source.dart';
import 'package:fitness_app/features/food_details/data/models/meal_details_response/meal.dart';
import 'package:fitness_app/features/food_details/data/models/meal_details_response/meal_details_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FoodDetailsRemoteDataSource)
class FoodDetailsApiRemoteDataSource implements FoodDetailsRemoteDataSource {
  final ApiClient _apiClient;

  FoodDetailsApiRemoteDataSource(this._apiClient);

  @override
  Future<ApiResult<Meal>> getFoodDetails(String mealID) async {
    var response = await _apiClient.get(
      ApiConstants.getFoodDetailsEndpoint,
      baseUrl: ApiConstants.foodRecommendBaseUrl,
      queryParameters: {
        'i': mealID,
      },
    );
    return response.map((data) {
      return MealDetailsResponse.fromJson(data).meals?.first ?? Meal();
    });
  }
}
