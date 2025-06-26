// features/home/domain/entities/muscle_group.dart
import 'package:equatable/equatable.dart';

class MuscleGroup extends Equatable {
  final String id;
  final String name;

  const MuscleGroup({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}
