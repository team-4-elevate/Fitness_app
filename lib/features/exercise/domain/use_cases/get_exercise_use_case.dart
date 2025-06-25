import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/exercise/domain/repo_interface/exercise_repo_interface.dart';
import 'package:injectable/injectable.dart';
import '../entites/exercise_entity.dart';

@injectable
class GetExercisesUseCase {
  final ExerciseRepoInterface _repo;
  GetExercisesUseCase(this._repo);
  Future<ApiResult<List<ExerciseEntity>>> call(
    String muscleGroupId,
    String levelId, {
    int? page,
  }) async {
    final res = await _repo.fetchExercises(
      levelId: levelId,
      muscleGroupId: muscleGroupId,
      page: page,
    );
    return res.map((e) => e.map((e) => e.toEntity()).toList());
  }
}
