// features/home/presentation/bloc/home_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:fitness_app/core/base_states/base_state.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/exercise.dart';
import 'package:fitness_app/features/home/domain/entities/daily_recommendation_item.dart';
import 'package:fitness_app/features/home/domain/usecases/get_daily_recommendations_usecase.dart';
import 'package:fitness_app/features/home/domain/usecases/get_food_recommendations.dart';
import 'package:fitness_app/features/home/domain/usecases/get_upcoming_workouts.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeStateType> {
  final GetDailyRecommendationsUseCase _getDailyRecommendationsUseCase;
  final GetUpcomingWorkouts _getUpcomingWorkouts;
  final GetFoodRecommendations _getFoodRecommendations;

  HomeBloc(
    this._getDailyRecommendationsUseCase,
    this._getUpcomingWorkouts,
    this._getFoodRecommendations,
  ) : super(const BaseInitialState()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<FetchDailyRecommendations>(_onFetchDailyRecommendations);
    on<FetchUpcomingWorkouts>(_onFetchUpcomingWorkouts);
    on<FetchFoodRecommendations>(_onFetchFoodRecommendations);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeStateType> emit,
  ) async {
    emit(const BaseLoadingState());

    try {
      String targetMuscleGroupId = '67c79f3526895f87ce0aa96b';
      String difficultyLevelId = '67c797e226895f87ce0aa94b';

      //daily recommendations
      final dailyResult = await _getDailyRecommendationsUseCase.call(
        targetMuscleGroupId: targetMuscleGroupId,
        difficultyLevelId: difficultyLevelId,
      );
      final upcomingResult = await _getUpcomingWorkouts.call();
      final foodResult = await _getFoodRecommendations.call();

      List<DailyRecommendationItem> dailyRecommendations = [];
      List<DailyRecommendationItem> upcomingWorkouts = [];
      List<DailyRecommendationItem> foodRecommendations = [];

      dailyResult.when(
        success: (data) {
          dailyRecommendations = Exercise.toDailyRecommendationItems(
            data.exercises,
          );
        },
        failure: (message) => emit(BaseErrorState(message)),
      );
      upcomingResult.when(
        success: (data) {
          upcomingWorkouts = data;
        },
        failure: (message) => emit(BaseErrorState(message)),
      );

      foodResult.when(
        success: (data) {
          foodRecommendations = data;
        },
        failure: (message) => emit(BaseErrorState(message)),
      );

      final homeData = HomeData(
        dailyRecommendations: dailyRecommendations,
        upcomingWorkouts: upcomingWorkouts,
        foodRecommendations: foodRecommendations,
      );

      emit(SuccessState(homeData));
    } catch (e) {
      emit(BaseErrorState(e.toString()));
    }
  }

  //-------------------------------------------------------daily recommendations
  Future<void> _onFetchDailyRecommendations(
    FetchDailyRecommendations event,
    Emitter<HomeStateType> emit,
  ) async {
    if (state is SuccessState) {
      final currentData = (state as SuccessState).data;
      emit(const BaseLoadingState());

      try {
        final targetMuscleGroupId = event.targetMuscleGroupId;
        final difficultyLevelId = event.difficultyLevelId;

        final result = await _getDailyRecommendationsUseCase.call(
          targetMuscleGroupId: targetMuscleGroupId,
          difficultyLevelId: difficultyLevelId,
        );

        result.when(
          success: (data) {
            final recommendations = Exercise.toDailyRecommendationItems(
              data.exercises,
            );

            final homeData = currentData.copyWith(
              dailyRecommendations: recommendations,
            );
            emit(SuccessState(homeData));
          },
          failure: (message) => emit(BaseErrorState(message)),
        );
      } catch (e) {
        emit(BaseErrorState(e.toString()));
      }
    }
  }

  //-------------------------------------------------------upcoming workouts
  Future<void> _onFetchUpcomingWorkouts(
    FetchUpcomingWorkouts event,
    Emitter<HomeStateType> emit,
  ) async {
    if (state is SuccessState) {
      final currentData = (state as SuccessState).data;
      emit(const BaseLoadingState());

      try {
        final result = await _getUpcomingWorkouts.call();

        result.when(
          success: (upcomingWorkouts) {
            final homeData = currentData.copyWith(
              upcomingWorkouts: upcomingWorkouts,
            );
            emit(SuccessState(homeData));
          },
          failure: (message) => emit(BaseErrorState(message)),
        );
      } catch (e) {
        emit(BaseErrorState(e.toString()));
      }
    }
  }

  //-------------------------------------------------------food recommendations
  Future<void> _onFetchFoodRecommendations(
    FetchFoodRecommendations event,
    Emitter<HomeStateType> emit,
  ) async {
    if (state is SuccessState) {
      final currentData = (state as SuccessState).data;
      emit(const BaseLoadingState());

      try {
        final result = await _getFoodRecommendations.call();

        result.when(
          success: (foodRecommendations) {
            final homeData = currentData.copyWith(
              foodRecommendations: foodRecommendations,
            );
            emit(SuccessState(homeData));
          },
          failure: (message) => emit(BaseErrorState(message)),
        );
      } catch (e) {
        emit(BaseErrorState(e.toString()));
      }
    }
  }
}
