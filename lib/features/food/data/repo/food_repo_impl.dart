import 'package:dio/dio.dart';
import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food/data/models/meals_response.dart';
import 'package:fitness_app/features/food/domain/repository/food_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FoodRepo)
class FoodRepoImpl implements FoodRepo {
  final ApiClient apiClient;

  FoodRepoImpl(this.apiClient);

  @override
  Future<ApiResult<MealsResponse>> getMeals(String categoryName) async {
    // var response = await apiClient.get<MealsResponse>(
    //   ApiConstants.getMealsEndpoint,
    //   queryParameters: {'c': categoryName},
    //   secondBaseUrl: ApiConstants.secondBaseUrl,
    // );

    // return response;
    try {
      var response = await Dio().get(
        'https://www.themealdb.com/api/json/v1/1/filter.php',
        queryParameters: {'c': categoryName},
      );

      MealsResponse data = MealsResponse.fromJson(response.data);

      return ApiSuccess(data);
    } catch (e) {
      return ApiFailure(e.toString());
    }
  }
}
