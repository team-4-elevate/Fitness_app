import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/muscles_by_muscle_group_id_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/workouts_response_dto.dart';

class WorkoutRecommendationState extends Equatable {
  final AppStates<List<MusclesGroup>>? muscleGroupsState;
  final AppStates<List<MusclesByMuscleGroupIdMusclesDto>>? musclesByGroupState;
  final int selectedGroupIndex;
  final Map<String, List<MusclesByMuscleGroupIdMusclesDto>> cachedMuscles;
  final Set<String> loadingGroups;
  final List<MusclesGroup> groups;

  const WorkoutRecommendationState({
    this.muscleGroupsState,
    this.musclesByGroupState,
    this.selectedGroupIndex = 0,
    this.cachedMuscles = const {},
    this.loadingGroups = const {},
    this.groups = const [],
  });

  WorkoutRecommendationState copyWith({
    AppStates<List<MusclesGroup>>? muscleGroupsState,
    AppStates<List<MusclesByMuscleGroupIdMusclesDto>>? musclesByGroupState,
    int? selectedGroupIndex,
    Map<String, List<MusclesByMuscleGroupIdMusclesDto>>? cachedMuscles,
    Set<String>? loadingGroups,
    List<MusclesGroup>? groups,
  }) {
    return WorkoutRecommendationState(
      muscleGroupsState: muscleGroupsState ?? this.muscleGroupsState,
      musclesByGroupState: musclesByGroupState ?? this.musclesByGroupState,
      selectedGroupIndex: selectedGroupIndex ?? this.selectedGroupIndex,
      cachedMuscles: cachedMuscles ?? this.cachedMuscles,
      loadingGroups: loadingGroups ?? this.loadingGroups,
      groups: groups ?? this.groups,
    );
  }

  @override
  List<Object?> get props => [
    muscleGroupsState,
    musclesByGroupState,
    selectedGroupIndex,
    cachedMuscles,
    loadingGroups,
    groups,
  ];
}
