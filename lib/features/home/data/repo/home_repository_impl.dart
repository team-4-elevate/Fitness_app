// features/home/data/repo/home_repository_impl.dart
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/data/datasource/remote_data_source/home_remote_data_source_contract.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/daily_recommendation_response.dart';
import 'package:fitness_app/features/home/data/model/upcoming_workouts/tabs/upcoming_tapbar/muscles_group.dart';
import 'package:fitness_app/features/home/domain/entities/daily_recommendation_item.dart';
import 'package:fitness_app/features/home/domain/entities/workout_by_group_item.dart';
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

  @override
  Future<ApiResult<List<MusclesGroup>>> getMuscleGroups() async {
    final result = await _remoteDataSource.getMuscleGroups();

    return result.when(
      success: (muscleGroupResponse) {
        final muscleGroups = muscleGroupResponse.musclesGroup != null
            ? muscleGroupResponse.musclesGroup!.toList()
            : <MusclesGroup>[];

        return ApiSuccess(muscleGroups);
      },
      failure: (failure) => ApiFailure(failure),
    );
  }

  @override
  Future<ApiResult<List<WorkoutByGroupItem>>> getWorkoutsByMuscleGroupId(
    String muscleGroupId,
  ) async {
    final result = await _remoteDataSource.getWorkoutsByMuscleGroupId(
      muscleGroupId,
    );

    return result.when(
      success: (response) {
        final workoutItems =
            response.muscles.map((item) => item.toEntity()).toList();
        return ApiSuccess(workoutItems);
      },
      failure: (failure) => ApiFailure(failure),
    );
  }
}
