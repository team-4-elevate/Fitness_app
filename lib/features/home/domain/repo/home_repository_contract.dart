// features/home/domain/repo/home_repository_contract.dart

import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/daily_recommendation_response.dart';
import 'package:fitness_app/features/home/domain/entities/daily_recommendation_item.dart';

abstract class HomeRepository {
  Future<ApiResult<DailyRecommendationResponse>> getDailyRecommendations({
    required String targetMuscleGroupId,
    required String difficultyLevelId,
  });

  Future<ApiResult<List<DailyRecommendationItem>>> getUpcomingWorkouts();

  Future<ApiResult<List<DailyRecommendationItem>>> getFoodRecommendations();
}
