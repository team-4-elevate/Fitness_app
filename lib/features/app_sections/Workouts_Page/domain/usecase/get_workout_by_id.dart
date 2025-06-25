
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/get_all_workout_by_id_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/muscles_by_muscle_group_id_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/domain/repository/contract/workouts__contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetWorkoutsByIdUseCase {
  final WorkoutsRepo _repository;

  GetWorkoutsByIdUseCase(this._repository);

  Future<ApiResult<GetAllWorkoutsByIdDto>> getWorkoutById(String id) {
    var response = _repository.getWorkoutById(id);
    return response;
  }

  Future<ApiResult<List<MusclesByMuscleGroupIdMusclesDto>>> call(String id) {
    var response = _repository.getMusclesByMuscleGroupId(id);
    return response;
     }
}
