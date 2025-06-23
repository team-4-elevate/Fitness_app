// features/home/data/datasource/remote_data_source/home_remote_data_source_impl.dart
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/data/datasource/remote_data_source/home_remote_data_source_contract.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/daily_recommendation_response.dart';
import 'package:fitness_app/features/home/data/model/food_recomendation/food_recomendation/food_recomendation.dart';
import 'package:fitness_app/features/home/data/model/upcoming_workouts/upcoming_workouts/upcoming_workouts.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient _apiClient;

  HomeRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<DailyRecommendationResponse>> getDailyRecommendations({
    required String targetMuscleGroupId,
    required String difficultyLevelId,
  }) async {
    final queryParams = {
      'targetMuscleGroupId': targetMuscleGroupId,
      'difficultyLevelId': difficultyLevelId,
      'limit': '5',
    };

    final result = await _apiClient.get<Map<String, dynamic>>(
      '/exercises/random',
      queryParameters: queryParams,
      requiresToken: true,
    );

    return result.when(
      success: (data) {
        final response = DailyRecommendationResponse.fromJson(data);
        return ApiSuccess(response);
      },
      failure: (failure) => ApiFailure(failure),
    );
  }

  @override
  Future<ApiResult<UpcomingWorkouts>> getUpcomingWorkouts() async {
    final queryParams = {'limit': '5'};

    final result = await _apiClient.get<Map<String, dynamic>>(
      '/exercises',
      queryParameters: queryParams,
      requiresToken: true,
    );

    return result.when(
      success: (data) {
        try {
          final upcomingWorkouts = UpcomingWorkouts.fromJson(data);
          return ApiSuccess(upcomingWorkouts);
        } catch (error) {
          return ApiFailure('Failed to parse upcoming workouts: $error');
        }
      },
      failure: (message) => ApiFailure(message),
    );
  }

  @override
  Future<ApiResult<FoodRecomendation>> getFoodRecommendations() async {
    try {
      final response = await _apiClient.get(
        'https://www.themealdb.com/api/json/v1/1/categories.php',
      );
      
      return response.when(
        success: (data) {
          try {
            final foodRecommendations = FoodRecomendation.fromJson(data);
            return ApiSuccess(foodRecommendations);
          } catch (error) {
            return ApiFailure('Failed to parse food recommendations: $error');
          }
        },
        failure: (message) => ApiFailure(message),
      );
    } catch (e) {
      return ApiFailure('Network error: $e');
    }
  }
}
