// features/home/domain/usecases/get_workouts_by_muscle_group_id.dart

import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/domain/entities/workout_by_group_item.dart';
import 'package:fitness_app/features/home/domain/repo/home_repository_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetWorkoutsByMuscleGroupId {
  final HomeRepository _homeRepository;

  const GetWorkoutsByMuscleGroupId(this._homeRepository);

  Future<ApiResult<List<WorkoutByGroupItem>>> call({
    required String muscleGroupId,
  }) async {
    return await _homeRepository.getWorkoutsByMuscleGroupId(muscleGroupId);
  }
}
