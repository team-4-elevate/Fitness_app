// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/data_source/contracts/workouts_data_source_contract.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/get_all_workout_by_id_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/muscles_by_muscle_group_id_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/workouts_response_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/domain/entities/get_all_workouts_by_id_entity.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/domain/entities/get_all_workouts_entity.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/domain/entities/muscles_by_muscle_group_id_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WorkoutsDataSourceContract)
class WorkoutsRepositoryImplementation implements WorkoutsDataSourceContract {
  final ApiClient apiClient;
  WorkoutsRepositoryImplementation({required this.apiClient});

  @override
  Future<ApiResult<WorkoutsResponseDto>> getAllWorkouts() async {
    var response = await apiClient.get(ApiConstants.getAllWorkoutsEndpoint);
    return response.map((data) {
      return WorkoutsResponseDto.fromJson(data);
    });
  }

  @override
  Future<ApiResult<GetAllWorkoutsByIdDto>> getWorkoutById(String id) async {
    var response = await apiClient.get(
      ApiConstants.getWorkoutsByIdEndpoint,
      queryParameters: {'id': id},
    );
    return response.map((data) {
      return GetAllWorkoutsByIdDto.fromJson(data);
    });
  }

  @override
  Future<ApiResult<List<MusclesByMuscleGroupIdMusclesDto>>>
  getMusclesByMuscleGroupId(String id) async {
    var response = await apiClient.get(
      ApiConstants.getWorkoutsByMuscleGroupIdEndpoint,
      queryParameters: {'id': id},
    );
    return response.map((data) {
      return (data as List)
          .map((item) => MusclesByMuscleGroupIdMusclesDto.fromJson(item))
          .toList();
    });
  }
}
