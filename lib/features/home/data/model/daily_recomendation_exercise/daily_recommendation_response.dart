import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/exercise.dart';

class DailyRecommendationResponse {
  final String message;
  final int totalExercises;
  final List<Exercise> exercises;

  DailyRecommendationResponse({
    required this.message,
    required this.totalExercises,
    required this.exercises,
  });

  factory DailyRecommendationResponse.fromJson(Map<String, dynamic> json) {
    return DailyRecommendationResponse(
      message: json['message'] as String,
      totalExercises: json['totalExercises'] as int,
      exercises: (json['exercises'] as List)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'totalExercises': totalExercises,
      'exercises': exercises.map((e) => e.toJson()).toList(),
    };
  }
}
