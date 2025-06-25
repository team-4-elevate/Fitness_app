import 'exercise.dart';

class DailyRecomendationExercise {
  String? message;
  int? totalExercises;
  List<Exercise>? exercises;

  DailyRecomendationExercise({
    this.message,
    this.totalExercises,
    this.exercises,
  });

  factory DailyRecomendationExercise.fromJson(Map<String, dynamic> json) {
    return DailyRecomendationExercise(
      message: json['message'] as String?,
      totalExercises: json['totalExercises'] as int?,
      exercises:
          (json['exercises'] as List<dynamic>?)
              ?.map((e) => Exercise.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'totalExercises': totalExercises,
    'exercises': exercises?.map((e) => e.toJson()).toList(),
  };
}
