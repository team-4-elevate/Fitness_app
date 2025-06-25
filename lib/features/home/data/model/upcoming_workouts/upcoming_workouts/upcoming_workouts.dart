// features/home/data/model/upcoming_workouts/upcoming_workouts/upcoming_workouts.dart
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/exercise.dart';

class UpcomingWorkouts {
  String? message;
  int? totalExercises;
  int? totalPages;
  int? currentPage;
  List<Exercise>? exercises;

  UpcomingWorkouts({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    this.exercises,
  });

  factory UpcomingWorkouts.fromJson(Map<String, dynamic> json) {
    return UpcomingWorkouts(
      message: json['message'] as String?,
      totalExercises: json['totalExercises'] as int?,
      totalPages: json['totalPages'] as int?,
      currentPage: json['currentPage'] as int?,
      exercises:
          (json['exercises'] as List<dynamic>?)
              ?.map((e) => Exercise.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'totalExercises': totalExercises,
    'totalPages': totalPages,
    'currentPage': currentPage,
    'exercises': exercises?.map((e) => e.toJson()).toList(),
  };
}
