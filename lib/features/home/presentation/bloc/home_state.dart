// features/home/presentation/bloc/home_state.dart
part of 'home_bloc.dart';

class HomeData {
  final List<DailyRecommendationItem> dailyRecommendations;
  final List<DailyRecommendationItem> upcomingWorkouts;
  final List<DailyRecommendationItem> foodRecommendations;
  
  const HomeData({
    required this.dailyRecommendations,
    required this.upcomingWorkouts,
    required this.foodRecommendations,
  });
  
  HomeData copyWith({
    List<DailyRecommendationItem>? dailyRecommendations,
    List<DailyRecommendationItem>? upcomingWorkouts,
    List<DailyRecommendationItem>? foodRecommendations,
  }) {
    return HomeData(
      dailyRecommendations: dailyRecommendations ?? this.dailyRecommendations,
      upcomingWorkouts: upcomingWorkouts ?? this.upcomingWorkouts,
      foodRecommendations: foodRecommendations ?? this.foodRecommendations,
    );
  }
}

typedef HomeStateType = BaseState<HomeData>;


