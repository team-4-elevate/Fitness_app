import 'package:equatable/equatable.dart';

abstract class WorkoutIntent extends Equatable {
  const WorkoutIntent();
}

class GetMuscleGroupsIntent extends WorkoutIntent {
  const GetMuscleGroupsIntent();

  @override
  List<Object?> get props => [];
}

class GetMusclesByGroupIntent extends WorkoutIntent {
  final String groupId;

  const GetMusclesByGroupIntent(this.groupId);

  @override
  List<Object?> get props => [groupId];
}

class ChangeSelectedGroupIntent extends WorkoutIntent {
  final int index;

  const ChangeSelectedGroupIntent(this.index);

  @override
  List<Object?> get props => [index];
}
