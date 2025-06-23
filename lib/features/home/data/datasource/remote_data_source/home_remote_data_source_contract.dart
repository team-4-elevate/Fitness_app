// features/home/data/datasource/remote_data_source/home_remote_data_source_contract.dart
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/daily_recommendation_response.dart';
import 'package:fitness_app/features/home/data/model/food_recomendation/food_recomendation/food_recomendation.dart';
import 'package:fitness_app/features/home/data/model/upcoming_workouts/upcoming_workouts/upcoming_workouts.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResult<DailyRecommendationResponse>> getDailyRecommendations({
    required String targetMuscleGroupId,
    required String difficultyLevelId,
  });

  Future<ApiResult<UpcomingWorkouts>> getUpcomingWorkouts();
  
  Future<ApiResult<FoodRecomendation>> getFoodRecommendations();
}
