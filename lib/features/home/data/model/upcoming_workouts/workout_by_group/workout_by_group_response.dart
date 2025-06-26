// features/home/data/model/workout_by_group/workout_by_group_response.dart
import 'workout_item.dart';

class WorkoutByGroupResponse {
  final String message;
  final int totalMuscles;
  final List<WorkoutItem> muscles;

  const WorkoutByGroupResponse({
    required this.message,
    required this.totalMuscles,
    required this.muscles,
  });

  factory WorkoutByGroupResponse.fromJson(Map<String, dynamic> json) {
    return WorkoutByGroupResponse(
      message: json['message'] ?? '',
      totalMuscles: json['totalMuscles'] ?? 0,
      muscles:
          (json['muscles'] as List?)
              ?.map((muscle) => WorkoutItem.fromJson(muscle))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'totalMuscles': totalMuscles,
      'muscles': muscles.map((muscle) => muscle.toJson()).toList(),
    };
  }
}
