import 'package:fitness_app/features/app_sections/Workouts_Page/domain/usecase/get_workout_by_id.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/cubit/Workouts_intent.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/cubit/Workouts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/muscles_by_muscle_group_id_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/domain/usecase/workouts_use_case.dart';

@injectable
class WorkoutRecommendationViewModel extends Cubit<WorkoutRecommendationState> {
  WorkoutRecommendationViewModel(
    this._workoutsUseCase,
    this._getWorkoutsByIdUseCase,
  ) : super(const WorkoutRecommendationState());

  final WorkoutsUseCase _workoutsUseCase;
  final GetWorkoutsByIdUseCase _getWorkoutsByIdUseCase;

  void doIntent(WorkoutIntent intent) {
    switch (intent) {
      case GetMuscleGroupsIntent():
        _handleGetMuscleGroups();
        break;
      case GetMusclesByGroupIntent(groupId: final id):
        _handleGetMusclesByGroup(id);
        break;
      case ChangeSelectedGroupIntent(index: final index):
        _handleChangeSelectedGroup(index);
        break;
    }
  }

  Future<void> _handleGetMuscleGroups() async {
    emit(state.copyWith(muscleGroupsState: const LoadingState()));
    final result = await _workoutsUseCase.getAllWorkouts();
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            muscleGroupsState: SuccessState(data.musclesGroup ?? []),
          ),
        );
      },
      failure: (message) {
        emit(state.copyWith(muscleGroupsState: ErrorState(message)));
      },
    );
  }

  Future<void> _handleGetMusclesByGroup(String groupId) async {
    if (state.cachedMuscles.containsKey(groupId)) return;

    emit(state.copyWith(loadingGroups: {...state.loadingGroups, groupId}));

    final result = await _getWorkoutsByIdUseCase.call(groupId);
    result.when(
      success: (muscles) {
        final updatedCache =
            Map<String, List<MusclesByMuscleGroupIdMusclesDto>>.from(
              state.cachedMuscles,
            );
        final updatedLoading = Set<String>.from(state.loadingGroups);

        updatedCache[groupId] = muscles;
        updatedLoading.remove(groupId);

        emit(
          state.copyWith(
            musclesByGroupState: SuccessState(muscles),
            cachedMuscles: updatedCache,
            loadingGroups: updatedLoading,
          ),
        );
      },
      failure: (message) {
        final updatedLoading = Set<String>.from(state.loadingGroups);
        updatedLoading.remove(groupId);

        emit(
          state.copyWith(
            musclesByGroupState: ErrorState(message),
            loadingGroups: updatedLoading,
          ),
        );
      },
    );
  }

  void _handleChangeSelectedGroup(int index) {
    emit(state.copyWith(selectedGroupIndex: index));
  }
}
