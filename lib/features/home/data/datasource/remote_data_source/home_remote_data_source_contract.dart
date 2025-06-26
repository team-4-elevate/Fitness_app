// features/home/data/datasource/remote_data_source/home_remote_data_source_contract.dart
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/daily_recommendation_response.dart';
import 'package:fitness_app/features/home/data/model/food_recomendation/food_recomendation/food_recomendation.dart';
import 'package:fitness_app/features/home/data/model/upcoming_workouts/tabs/upcoming_tapbar/upcoming_tapbar.dart';
import 'package:fitness_app/features/home/data/model/upcoming_workouts/workout_by_group/workout_by_group_response.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResult<DailyRecommendationResponse>> getDailyRecommendations({
    required String targetMuscleGroupId,
    required String difficultyLevelId,
  });

  Future<ApiResult<FoodRecomendation>> getFoodRecommendations();

  Future<ApiResult<UpcomingTapbar>> getMuscleGroups();

  Future<ApiResult<WorkoutByGroupResponse>> getWorkoutsByMuscleGroupId(String muscleGroupId);
}
