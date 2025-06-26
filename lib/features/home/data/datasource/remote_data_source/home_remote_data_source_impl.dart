// features/home/data/datasource/remote_data_source/home_remote_data_source_impl.dart
import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/data/datasource/remote_data_source/home_remote_data_source_contract.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/daily_recommendation_response.dart';
import 'package:fitness_app/features/home/data/model/food_recomendation/food_recomendation/food_recomendation.dart';
import 'package:fitness_app/features/home/data/model/upcoming_workouts/tabs/upcoming_tapbar/upcoming_tapbar.dart';
import 'package:fitness_app/features/home/data/model/upcoming_workouts/workout_by_group/workout_by_group_response.dart';
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

    final result = await _apiClient.get(
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

  @override
  Future<ApiResult<UpcomingTapbar>> getMuscleGroups() async {
    try {
      final response = await _apiClient.get(
        ApiConstants.muscles,
        requiresToken: true,
      );

      return response.when(
        success: (data) {
          try {
            final muscleGroups = UpcomingTapbar.fromJson(data);
            return ApiSuccess(muscleGroups);
          } catch (error) {
            return ApiFailure('Failed to parse muscle groups: $error');
          }
        },
        failure: (message) => ApiFailure(message),
      );
    } catch (e) {
      return ApiFailure('Network error: $e');
    }
  }

  @override
  Future<ApiResult<WorkoutByGroupResponse>> getWorkoutsByMuscleGroupId(String muscleGroupId) async {
    try {
      final String endpoint = muscleGroupId.toLowerCase() == 'all' 
          ? '/exercises/workouts' 
          : '/musclesGroup/by-muscle-group';
      
      final Map<String, dynamic>? queryParams = muscleGroupId.toLowerCase() != 'all'
          ? {'muscleGroupId': muscleGroupId}
          : null;
      
      final response = await _apiClient.get(
        endpoint,
        queryParameters: queryParams,
        requiresToken: true,
      );

      return response.when(
        success: (data) {
          try {
            final workoutsByGroup = WorkoutByGroupResponse.fromJson(data);
            return ApiSuccess(workoutsByGroup);
          } catch (error) {
            return ApiFailure('Failed to parse workouts by group: $error');
          }
        },
        failure: (message) => ApiFailure(message),
      );
    } catch (e) {
      return ApiFailure('Network error: $e');
    }
  }
}
