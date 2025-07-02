// features/home/domain/usecases/get_muscle_groups_use_case.dart

import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/data/model/upcoming_workouts/tabs/upcoming_tapbar/muscles_group.dart';
import 'package:fitness_app/features/home/domain/repo/home_repository_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMuscleGroupsUseCase {
  final HomeRepository _homeRepository;

  GetMuscleGroupsUseCase(this._homeRepository);

  Future<ApiResult<List<MusclesGroup>>> call() async {
    return await _homeRepository.getMuscleGroups();
  }
}
