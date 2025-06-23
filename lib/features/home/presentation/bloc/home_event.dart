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

class FetchUpcomingWorkouts extends HomeEvent {
  const FetchUpcomingWorkouts();
}

class FetchFoodRecommendations extends HomeEvent {
  const FetchFoodRecommendations();
}
