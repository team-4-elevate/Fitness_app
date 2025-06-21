import 'package:json_annotation/json_annotation.dart';

part 'training_model.g.dart';

@JsonSerializable()
class TrainingModel {
  final String id;
  final String imageUrl;
  final String title;
  final String tasksCount;
  final String level;

  TrainingModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.tasksCount,
    required this.level,
  });

  factory TrainingModel.fromJson(Map<String, dynamic> json) =>
      _$TrainingModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrainingModelToJson(this);
}
