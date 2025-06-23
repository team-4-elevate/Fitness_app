// features/home/presentation/bloc/home_state.dart
part of 'home_bloc.dart';

class HomeData {
  final List<DailyRecommendationItem> dailyRecommendations;

  const HomeData({required this.dailyRecommendations});

  HomeData copyWith({List<DailyRecommendationItem>? dailyRecommendations}) {
    return HomeData(
      dailyRecommendations: dailyRecommendations ?? this.dailyRecommendations,
      upcomingWorkouts: upcomingWorkouts ?? this.upcomingWorkouts,
      foodRecommendations: foodRecommendations ?? this.foodRecommendations,
    );
  }
}

typedef HomeStateType = BaseState<HomeData>;

typedef DailyRecommendationStateType = BaseState<List<DailyRecommendationItem>>;
