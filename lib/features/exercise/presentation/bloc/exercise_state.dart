import 'package:equatable/equatable.dart';
import '../../../../core/app_manger/bloc_handler_mixin.dart';
import '../../domain/entites/difficulty_level.dart';
import '../../domain/entites/exercise_entity.dart';

class ExercisePageState extends Equatable {
  final Status getLevelsStatus;
  final Status getExercisesStatus;
  final Map<DifficultyLevelEntity, List<ExerciseEntity>> levelExerciseMap;
  final Map<String, int> levelIdAndPagesMap;
  final String? errorMessage;
  final String? currentLevelId;
  final bool? shouldShowYoutubeVideo;
  final String? currentVideoId;
  final String? currentVideoLink;
  final bool? hasMoreExercises;
  final bool? isLoadingMore;

  const ExercisePageState({
    this.getLevelsStatus = Status.initial,
    this.getExercisesStatus = Status.initial,
    this.levelExerciseMap = const {},
    this.levelIdAndPagesMap = const {},
    this.errorMessage,
    this.currentLevelId,
    this.shouldShowYoutubeVideo,
    this.currentVideoId,
    this.currentVideoLink,
    this.hasMoreExercises,
    this.isLoadingMore,
  });

  ExercisePageState copyWith({
    Status? levelsStatus,
    Status? exercisesStatus,
    Map<DifficultyLevelEntity, List<ExerciseEntity>>? levelExerciseMap,
    Map<String, int>? levelIdAndPagesMap,
    List<DifficultyLevelEntity>? levels,
    List<ExerciseEntity>? exercises,
    String? errorMessage,
    String? selectedLevelId,
    bool? shouldShowYoutubeVideo,
    String? currentVideoId,
    String? currentVideoLink,
    bool? hasMoreExercises,
    bool? isLoadingMore,
  }) {
    return ExercisePageState(
      getLevelsStatus: levelsStatus ?? this.getLevelsStatus,
      levelIdAndPagesMap: levelIdAndPagesMap ?? this.levelIdAndPagesMap,
      getExercisesStatus: exercisesStatus ?? this.getExercisesStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      currentLevelId: selectedLevelId ?? this.currentLevelId,
      levelExerciseMap: levelExerciseMap ?? this.levelExerciseMap,
      hasMoreExercises: hasMoreExercises ?? this.hasMoreExercises,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentVideoId: currentVideoId,
      shouldShowYoutubeVideo: shouldShowYoutubeVideo,
      currentVideoLink: currentVideoLink,
    );
  }

  @override
  List<Object?> get props => [
    getLevelsStatus,
    getExercisesStatus,
    errorMessage,
    currentLevelId,
    levelExerciseMap,
    shouldShowYoutubeVideo,
    currentVideoId,
    currentVideoLink,
    levelIdAndPagesMap,
    hasMoreExercises,
    isLoadingMore,
  ];
}
