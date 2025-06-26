import 'package:fitness_app/features/exercise/data/models/exercise/model/exercise_dm.dart';

class GetExerciseResponse {
  final String message;
  final int totalExercises;
  final int totalPages;
  final int currentPage;
  final List<ExerciseDM> exercises;

  GetExerciseResponse({
    required this.message,
    required this.totalExercises,
    required this.totalPages,
    required this.currentPage,
    required this.exercises,
  });

  factory GetExerciseResponse.fromJson(Map<String, dynamic> json) {
    return GetExerciseResponse(
      message: json['message'] ?? '',
      totalExercises: json['totalExercises'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
      exercises: (json['exercises'] as List<dynamic>?)
              ?.map((x) => ExerciseDM.fromJson(x))
              .toList() ??
          [],
    );
  }
}
