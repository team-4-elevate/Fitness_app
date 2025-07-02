// features/home/presentation/bloc/home_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base_states/base_state.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/exercise.dart';
import 'package:fitness_app/features/home/data/model/upcoming_workouts/tabs/upcoming_tapbar/muscles_group.dart';
import 'package:fitness_app/features/home/domain/entities/daily_recommendation_item.dart';
import 'package:fitness_app/features/home/domain/entities/workout_by_group_item.dart';
import 'package:fitness_app/features/home/domain/usecases/get_daily_recommendations_usecase.dart';
import 'package:fitness_app/features/home/domain/usecases/get_food_recommendations.dart';
import 'package:fitness_app/features/home/domain/usecases/get_muscle_groups_use_case.dart';
import 'package:fitness_app/features/home/domain/usecases/get_workouts_by_muscle_group_id.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeStateType> {
  final GetDailyRecommendationsUseCase _getDailyRecommendationsUseCase;
  final GetFoodRecommendations _getFoodRecommendations;
  final GetMuscleGroupsUseCase _getMuscleGroupsUseCase;
  final GetWorkoutsByMuscleGroupId _getWorkoutsByMuscleGroupId;

  HomeBloc(
    this._getDailyRecommendationsUseCase,
    this._getFoodRecommendations,
    this._getMuscleGroupsUseCase,
    this._getWorkoutsByMuscleGroupId,
  ) : super(const BaseInitialState()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<FetchDailyRecommendations>(_onFetchDailyRecommendations);
    on<FetchFoodRecommendations>(_onFetchFoodRecommendations);
    on<FetchMuscleGroups>(_onFetchMuscleGroups);
    on<FetchWorkoutsByMuscleGroupId>(_onFetchWorkoutsByMuscleGroupId);
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
      final foodResult = await _getFoodRecommendations.call();
      final muscleGroupsResult = await _getMuscleGroupsUseCase.call();

      List<DailyRecommendationItem> dailyRecommendations = [];
      List<DailyRecommendationItem> foodRecommendations = [];
      List<MusclesGroup> muscleGroups = [];

      dailyResult.when(
        success: (data) {
          dailyRecommendations = Exercise.toDailyRecommendationItems(
            data.exercises,
          );
        },
        failure: (message) => emit(BaseErrorState(message)),
      );

      foodResult.when(
        success: (data) {
          foodRecommendations = data;
        },
        failure: (message) => emit(BaseErrorState(message)),
      );

      muscleGroupsResult.when(
        success: (data) {
          muscleGroups = data;
        },
        failure: (message) => emit(BaseErrorState(message)),
      );

      final homeData = HomeData(
        dailyRecommendations: dailyRecommendations,
        foodRecommendations: foodRecommendations,
        muscleGroups: muscleGroups,
        workoutsByGroup: [],
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

  //-------------------------------------------------------muscle groups
  Future<void> _onFetchMuscleGroups(
    FetchMuscleGroups event,
    Emitter<HomeStateType> emit,
  ) async {
    if (state is SuccessState) {
      final currentData = (state as SuccessState).data;
      emit(const BaseLoadingState());

      try {
        final result = await _getMuscleGroupsUseCase.call();

        result.when(
          success: (muscleGroups) {
            final homeData = currentData.copyWith(muscleGroups: muscleGroups);
            emit(SuccessState(homeData));
          },
          failure: (message) => emit(BaseErrorState(message)),
        );
      } catch (e) {
        emit(BaseErrorState(e.toString()));
      }
    }
  }

  //-------------------------------------------------------workouts by muscle group
  Future<void> _onFetchWorkoutsByMuscleGroupId(
    FetchWorkoutsByMuscleGroupId event,
    Emitter<HomeStateType> emit,
  ) async {
    if (state is SuccessState) {
      final currentData = (state as SuccessState).data;
      try {
        if (event.muscleGroupId.toLowerCase() == 'all') {
          await _handleFullBodyTab(currentData, emit);
        } else {
          final result = await _getWorkoutsByMuscleGroupId.call(
            muscleGroupId: event.muscleGroupId,
          );

          result.when(
            success: (workoutsByGroup) {
              final homeData = currentData.copyWith(
                workoutsByGroup: workoutsByGroup,
              );
              emit(SuccessState(homeData));
            },
            failure: (message) {
              debugPrint('Error fetching workouts by group: $message');
            },
          );
        }
      } catch (e) {
        debugPrint('Exception fetching workouts by group: ${e.toString()}');
      }
    }
  }

  Future<void> _handleFullBodyTab(
    HomeData currentData,
    Emitter<HomeStateType> emit,
  ) async {
    final muscleGroups = currentData.muscleGroups;
    final combinedWorkouts = <WorkoutByGroupItem>[];

    for (int i = 0; i < muscleGroups.length && i < 3; i++) {
      final muscleGroup = muscleGroups[i];
      if (muscleGroup.id == null || muscleGroup.id!.isEmpty) continue;
      final result = await _getWorkoutsByMuscleGroupId.call(
        muscleGroupId: muscleGroup.id!,
      );

      result.when(
        success: (workouts) {
          final workoutsToAdd =
              workouts.length > 2 ? workouts.sublist(0, 2) : workouts;
          combinedWorkouts.addAll(workoutsToAdd);
        },
        failure: (message) {
          debugPrint(
            'Failed to fetch workouts for ${muscleGroup.name}: $message',
          );
        },
      );
    }

    if (combinedWorkouts.isNotEmpty) {
      final homeData = currentData.copyWith(workoutsByGroup: combinedWorkouts);
      emit(SuccessState(homeData));
    } else {
      if (muscleGroups.isNotEmpty && muscleGroups.first.id != null) {
        final result = await _getWorkoutsByMuscleGroupId.call(
          muscleGroupId: muscleGroups.first.id!,
        );

        result.when(
          success: (workouts) {
            final homeData = currentData.copyWith(workoutsByGroup: workouts);
            emit(SuccessState(homeData));
          },
          failure: (_) {},
        );
      }
    }
  }
}
