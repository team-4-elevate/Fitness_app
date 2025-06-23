// features/home/domain/usecase/get_daily_recommendations_usecase.dart
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/daily_recommendation_response.dart';
import 'package:fitness_app/features/home/domain/repo/home_repository_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDailyRecommendationsUseCase {
  final HomeRepository _repository;

  GetDailyRecommendationsUseCase(this._repository);

  Future<ApiResult<DailyRecommendationResponse>> call({
    required String targetMuscleGroupId,
    required String difficultyLevelId,
  }) async {
    return await _repository.getDailyRecommendations(
      targetMuscleGroupId: targetMuscleGroupId,
      difficultyLevelId: difficultyLevelId,
    );
  }
}
