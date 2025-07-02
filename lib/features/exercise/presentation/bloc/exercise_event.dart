import 'package:equatable/equatable.dart';

abstract class ExercisePageEvent extends Equatable {
  const ExercisePageEvent();

  @override
  List<Object> get props => [];
}

class GetLevelsEvent extends ExercisePageEvent {}

class GetExercisesEvent extends ExercisePageEvent {
  final String muscleGroupId;
  final String levelId;
  final int? page;
  final bool showLoading;

  const GetExercisesEvent({
    required this.muscleGroupId,
    required this.levelId,
    required this.showLoading,
    this.page,
  });

  @override
  List<Object> get props => [muscleGroupId, levelId, showLoading, page ?? 0];
}

class ShowYoutubeVideoEvent extends ExercisePageEvent {
  final String? link;
  const ShowYoutubeVideoEvent({required this.link});
}

class CloseYoutubeVideoEvent extends ExercisePageEvent {}

class LoadMoreExercisesEvent extends ExercisePageEvent {
  final String levelId;
  final String muscleGroupId;
  const LoadMoreExercisesEvent({
    required this.levelId,
    required this.muscleGroupId,
  });
}
