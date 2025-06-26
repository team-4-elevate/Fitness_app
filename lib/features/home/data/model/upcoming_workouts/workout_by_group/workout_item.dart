// features/home/data/model/workout_by_group/workout_item.dart
import 'package:fitness_app/features/home/domain/entities/workout_by_group_item.dart';

class WorkoutItem {
  final String id;
  final String name;
  final String image;

  const WorkoutItem({
    required this.id,
    required this.name,
    required this.image,
  });

  factory WorkoutItem.fromJson(Map<String, dynamic> json) {
    return WorkoutItem(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
    };
  }

  // Convert to domain entity
  WorkoutByGroupItem toEntity() {
    return WorkoutByGroupItem(
      id: id,
      name: name,
      image: image,
    );
  }
}
