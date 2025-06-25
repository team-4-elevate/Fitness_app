import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/workouts_response_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/domain/repository/contract/workouts__contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class WorkoutsUseCase {
  final WorkoutsRepo _repository;

  WorkoutsUseCase(this._repository);

  Future<ApiResult<WorkoutsResponseDto>> getAllWorkouts() {
    var response = _repository.getAllWorkouts();
    return response;
  }
}
