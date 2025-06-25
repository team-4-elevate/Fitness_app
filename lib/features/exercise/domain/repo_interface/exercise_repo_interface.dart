import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/exercise/data/models/difficulty_level/model/difficulty_level_dm.dart';
import 'package:fitness_app/features/exercise/data/models/exercise/model/exercise_dm.dart';

abstract class ExerciseRepoInterface {
  Future<ApiResult<List<ExerciseDM>>> fetchExercises({
    required String levelId,
    required String muscleGroupId,
    required int? page,
  });
  Future<ApiResult<List<DifficultyLevelDM>>> fetchLevels();
}
