import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../core/app_manger/bloc_handler_mixin.dart';
import '../../domain/entites/difficulty_level.dart';
import '../../domain/entites/exercise_entity.dart';
import '../../domain/use_cases/get_exercise_use_case.dart';
import '../../domain/use_cases/get_levels_use_case.dart';
import 'exercise_event.dart';
import 'exercise_state.dart';

@injectable
class ExercisePageBloc extends Bloc<ExercisePageEvent, ExercisePageState> {
  final GetLevelsUseCase _getLevelsUseCase;
  final GetExercisesUseCase _getExercisesUseCase;

  ExercisePageBloc({
    required GetLevelsUseCase getLevelsUseCase,
    required GetExercisesUseCase getExercisesUseCase,
  }) : _getExercisesUseCase = getExercisesUseCase,
       _getLevelsUseCase = getLevelsUseCase,
       super(const ExercisePageState()) {
    _mapEvents();
  }

  Future<void> _onGetLevels(
    GetLevelsEvent event,
    Emitter<ExercisePageState> emit,
  ) async {
    emit(state.copyWith(levelsStatus: Status.loading));
    final resp = await _getLevelsUseCase();
    resp.when(
      success:
          (levels) => emit(
            state.copyWith(
              levelsStatus: Status.success,
              levelExerciseMap: Map.fromIterable(levels, value: (_) => []),
              selectedLevelId: levels.first.id,
              levelIdAndPagesMap: {for (final level in levels) level.id: 1},
            ),
          ),
      failure:
          (message) => emit(
            state.copyWith(errorMessage: message, levelsStatus: Status.error),
          ),
    );
  }

  Future<void> _onGetExercises(
    GetExercisesEvent event,
    Emitter<ExercisePageState> emit,
  ) async {
    emit(state.copyWith(selectedLevelId: event.levelId));
    final currentLevel = state.levelExerciseMap.keys.firstWhere(
      (level) => level.id == event.levelId,
    );

    final currentExercises = state.levelExerciseMap[currentLevel] ?? [];
    final requestedPage = event.page ?? 1;
    if (currentExercises.isNotEmpty && requestedPage == 1) {
      emit(state.copyWith(exercisesStatus: Status.success));
      return;
    }
    if (event.showLoading)
      emit(state.copyWith(exercisesStatus: Status.loading));
    final exercisesResult = await _getExercisesUseCase(
      event.muscleGroupId,
      event.levelId,
      page: requestedPage,
    );

    exercisesResult.when(
      success: (newExercises) {
        List<ExerciseEntity> updatedExercises;

        if (requestedPage == 1) {
          updatedExercises = newExercises;
        } else {
          updatedExercises = [...currentExercises, ...newExercises];
        }
        emit(
          state.copyWith(
            exercisesStatus: Status.success,
            levelExerciseMap: {
              ...state.levelExerciseMap,
              currentLevel: updatedExercises,
            },
            levelIdAndPagesMap: {
              ...state.levelIdAndPagesMap,
              event.levelId: requestedPage,
            },
            hasMoreExercises: newExercises.isNotEmpty,
          ),
        );
        log(state.levelIdAndPagesMap[event.levelId].toString());
      },
      failure:
          (message) => emit(
            state.copyWith(
              errorMessage: message,
              exercisesStatus: Status.error,
            ),
          ),
    );
  }


  Future<void> _onLoadMoreExercises(
      LoadMoreExercisesEvent event,
      Emitter<ExercisePageState> emit,
      ) async {
    if (state.hasMoreExercises == true && state.isLoadingMore != true) {
      emit(state.copyWith(isLoadingMore: true));

      final currentPage = state.levelIdAndPagesMap[event.levelId] ?? 0;
      final result = await _getExercisesUseCase(
        event.muscleGroupId,
        event.levelId,
        page: currentPage + 1,
      );

      result.when(
        success: (newExercises) {
          final currentLevel = state.levelExerciseMap.keys.firstWhere(
                (level) => level.id == event.levelId,
          );
          final currentExercises = state.levelExerciseMap[currentLevel] ?? [];

          emit(state.copyWith(
            isLoadingMore: false,
            levelExerciseMap: {
              ...state.levelExerciseMap,
              currentLevel: [...currentExercises, ...newExercises],
            },
            levelIdAndPagesMap: {
              ...state.levelIdAndPagesMap,
              event.levelId: currentPage + 1,
            },
            hasMoreExercises: newExercises.isNotEmpty,
          ));
        },
        failure: (message) => emit(state.copyWith(
          isLoadingMore: false,
          errorMessage: message,
        )),
      );
    }
  }
  void _onShowYoutubeVideo(
    ShowYoutubeVideoEvent event,
    Emitter<ExercisePageState> emit,
  ) {
    final videoId = YoutubePlayer.convertUrlToId(event.link ?? '');
    emit(
      state.copyWith(
        currentVideoId: videoId,
        shouldShowYoutubeVideo: true,
        currentVideoLink: event.link,
      ),
    );
  }

  void _onHideYoutubeVideo(
    CloseYoutubeVideoEvent event,
    Emitter<ExercisePageState> emit,
  ) {
    emit(
      state.copyWith(
        currentVideoId: null,
        shouldShowYoutubeVideo: false,
        currentVideoLink: null,
      ),
    );
  }

  void _mapEvents() {
    on<GetLevelsEvent>(_onGetLevels);
    on<GetExercisesEvent>(_onGetExercises);
    on<LoadMoreExercisesEvent>(_onLoadMoreExercises);
    on<ShowYoutubeVideoEvent>(_onShowYoutubeVideo);
    on<CloseYoutubeVideoEvent>(_onHideYoutubeVideo);
  }
}
