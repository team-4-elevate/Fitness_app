import 'package:fitness_app/core/helper/api_result.dart';
import 'package:injectable/injectable.dart';
import '../entites/difficulty_level.dart';
import '../repo_interface/exercise_repo_interface.dart';

@injectable
class GetLevelsUseCase {
  final ExerciseRepoInterface _repo;
  GetLevelsUseCase(this._repo);
  Future<ApiResult<List<DifficultyLevelEntity>>> call() async {
    final res = await _repo.fetchLevels();
    return res.map((e) => e.map((e) => e.toEntity()).toList());
  }
}
