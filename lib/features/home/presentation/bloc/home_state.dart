// features/home/presentation/bloc/home_state.dart
part of 'home_bloc.dart';

class HomeData {
  final List<DailyRecommendationItem> dailyRecommendations;
  final List<DailyRecommendationItem> foodRecommendations;
  final List<MusclesGroup> muscleGroups;
  final List<WorkoutByGroupItem> workoutsByGroup;

  const HomeData({
    required this.dailyRecommendations,
    required this.foodRecommendations,
    required this.muscleGroups,
    this.workoutsByGroup = const [],
  });

  HomeData copyWith({
    List<DailyRecommendationItem>? dailyRecommendations,
    List<DailyRecommendationItem>? foodRecommendations,
    List<MusclesGroup>? muscleGroups,
    List<WorkoutByGroupItem>? workoutsByGroup,
  }) {
    return HomeData(
      dailyRecommendations: dailyRecommendations ?? this.dailyRecommendations,
      foodRecommendations: foodRecommendations ?? this.foodRecommendations,
      muscleGroups: muscleGroups ?? this.muscleGroups,
      workoutsByGroup: workoutsByGroup ?? this.workoutsByGroup,
    );
  }
}

typedef HomeStateType = BaseState<HomeData>;
