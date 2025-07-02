// features/home/presentation/bloc/home_event.dart
part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeData extends HomeEvent {
  const LoadHomeData();
}

class FetchDailyRecommendations extends HomeEvent {
  final String targetMuscleGroupId;
  final String difficultyLevelId;

  const FetchDailyRecommendations({
    required this.targetMuscleGroupId,
    required this.difficultyLevelId,
  });

  @override
  List<Object> get props => [targetMuscleGroupId, difficultyLevelId];
}

class FetchFoodRecommendations extends HomeEvent {
  const FetchFoodRecommendations();
}

class FetchMuscleGroups extends HomeEvent {
  const FetchMuscleGroups();
}

class FetchWorkoutsByMuscleGroupId extends HomeEvent {
  final String muscleGroupId;

  const FetchWorkoutsByMuscleGroupId({required this.muscleGroupId});

  @override
  List<Object> get props => [muscleGroupId];
}

class FetchFullBodyWorkouts extends HomeEvent {
  const FetchFullBodyWorkouts();
}
