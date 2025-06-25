import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/get_all_workout_by_id_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/muscles_by_muscle_group_id_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/workouts_response_dto.dart';

abstract class WorkoutsDataSourceContract {
  Future<ApiResult<WorkoutsResponseDto>> getAllWorkouts();
  Future<ApiResult<GetAllWorkoutsByIdDto>> getWorkoutById(String id);
  Future<ApiResult<List<MusclesByMuscleGroupIdMusclesDto>>> getMusclesByMuscleGroupId(String id);

  


}
