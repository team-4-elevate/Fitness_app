import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/exercise/data/models/difficulty_level/model/difficulty_level_dm.dart';
import 'package:fitness_app/features/exercise/data/models/difficulty_level/response/get_difficulty_level_response.dart';
import 'package:fitness_app/features/exercise/data/models/exercise/model/exercise_dm.dart';
import 'package:fitness_app/features/exercise/data/models/exercise/response/get_exercises_response.dart';
import 'package:injectable/injectable.dart';
import 'exercise_remote_ds_interface.dart';

@Injectable(as: ExerciseRemoteDsInterface)
class ExerciseRemoteDsImpl implements ExerciseRemoteDsInterface {
  final ApiClient _apiClient;
  ExerciseRemoteDsImpl(this._apiClient);

  @override
  Future<ApiResult<List<ExerciseDM>>> getExercises({
    required String levelId,
    required String muscleGroupId,
    required int? page,
  }) async {
    final response = await _apiClient.get(
      ApiConstants.exercises,
      queryParameters: {
        'primeMoverMuscleId': muscleGroupId,
        'difficultyLevelId': levelId,
        'page': page,
      },
    );
    return response.map((r) => GetExerciseResponse.fromJson(r).exercises);
  }

  @override
  Future<ApiResult<List<DifficultyLevelDM>>> getLevels() async {
    final response = await _apiClient.get(ApiConstants.difficultyLevel);
    return response.map((r) => DifficultyLevelsResponse.fromJson(r).levels);
  }
}
