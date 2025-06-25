// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/get_all_workout_by_id_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/muscles_by_muscle_group_id_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/workouts_response_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/domain/repository/contract/workouts__contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WorkoutsRepo)
class Workouts_Imp_Repo extends WorkoutsRepo {
  WorkoutsRepo obj_WorkoutsRepo;
  Workouts_Imp_Repo({required this.obj_WorkoutsRepo});

  @override
  Future<ApiResult<WorkoutsResponseDto>> getAllWorkouts() async {
    var response = await obj_WorkoutsRepo.getAllWorkouts();
    return response;
  }

  @override
  Future<ApiResult<GetAllWorkoutsByIdDto>> getWorkoutById(String id) {
    var response = obj_WorkoutsRepo.getWorkoutById(id);
    return response;
  }

  @override
  Future<ApiResult<List<MusclesByMuscleGroupIdMusclesDto>>>
  getMusclesByMuscleGroupId(String id) {
    var response = obj_WorkoutsRepo.getMusclesByMuscleGroupId(id);
    return response;
  }
}
