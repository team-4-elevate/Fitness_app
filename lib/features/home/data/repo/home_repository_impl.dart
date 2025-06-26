// features/home/data/repo/home_repository_impl.dart
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/data/datasource/remote_data_source/home_remote_data_source_contract.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/daily_recommendation_response.dart';
import 'package:fitness_app/features/home/domain/entities/daily_recommendation_item.dart';
import 'package:fitness_app/features/home/domain/repo/home_repository_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<DailyRecommendationResponse>> getDailyRecommendations({
    required String targetMuscleGroupId,
    required String difficultyLevelId,
  }) async {
    return await _remoteDataSource.getDailyRecommendations(
      targetMuscleGroupId: targetMuscleGroupId,
      difficultyLevelId: difficultyLevelId,
    );
  }

  @override
  Future<ApiResult<List<DailyRecommendationItem>>> getUpcomingWorkouts() async {
    final result = await _remoteDataSource.getUpcomingWorkouts();

    return result.when(
      success: (upcomingWorkouts) {
        final recommendationItems = upcomingWorkouts.exercises != null
            ? upcomingWorkouts.exercises!
                .map((exercise) => exercise.toDailyRecommendationItem())
                .toList()
            : <DailyRecommendationItem>[];

        return ApiSuccess(recommendationItems);
      },
      failure: (failure) => ApiFailure(failure),
    );
  }

  @override
  Future<ApiResult<List<DailyRecommendationItem>>>
      getFoodRecommendations() async {
    final result = await _remoteDataSource.getFoodRecommendations();

    return result.when(
      success: (foodRecommendations) {
        final recommendationItems = foodRecommendations.categories != null
            ? foodRecommendations.categories!
                .map(
                  (category) => DailyRecommendationItem(
                    id: category.idCategory ?? '',
                    name: category.strCategory ?? '',
                    imageUrl: category.strCategoryThumb ?? '',
                  ),
                )
                .toList()
            : <DailyRecommendationItem>[];

        return ApiSuccess(recommendationItems);
      },
      failure: (failure) => ApiFailure(failure),
    );
  }
}
