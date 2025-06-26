// features/home/domain/entities/workout_by_group_item.dart
import 'package:equatable/equatable.dart';

class WorkoutByGroupItem extends Equatable {
  final String id;
  final String name;
  final String image;

  const WorkoutByGroupItem({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, image];

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image};
  }
}
