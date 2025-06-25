import '../../../../../core/helper/api_result.dart';
import '../../models/difficulty_level/model/difficulty_level_dm.dart';
import '../../models/exercise/model/exercise_dm.dart';

abstract class ExerciseRemoteDsInterface {
  Future<ApiResult<List<DifficultyLevelDM>>> getLevels();
  Future<ApiResult<List<ExerciseDM>>> getExercises({
    required String levelId,
    required String muscleGroupId,
    required int? page,
  });
}
