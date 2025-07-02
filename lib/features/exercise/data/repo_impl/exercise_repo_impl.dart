import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/exercise/data/models/difficulty_level/model/difficulty_level_dm.dart';
import 'package:fitness_app/features/exercise/data/models/exercise/model/exercise_dm.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repo_interface/exercise_repo_interface.dart';
import '../data_sources/remote/exercise_remote_ds_interface.dart';

@Injectable(as: ExerciseRepoInterface)
class ExerciseRepoImpl implements ExerciseRepoInterface {
  final ExerciseRemoteDsInterface _exerciseRemoteDsInterface;
  ExerciseRepoImpl(this._exerciseRemoteDsInterface);
  @override
  Future<ApiResult<List<ExerciseDM>>> fetchExercises({
    required String levelId,
    required String muscleGroupId,
    required int? page,
  }) {
    return _exerciseRemoteDsInterface.getExercises(
      levelId: levelId,
      muscleGroupId: muscleGroupId,
      page: page,
    );
  }

  @override
  Future<ApiResult<List<DifficultyLevelDM>>> fetchLevels() {
    return _exerciseRemoteDsInterface.getLevels();
  }
}
