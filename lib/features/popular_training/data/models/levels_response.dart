import 'package:json_annotation/json_annotation.dart';
part 'levels_response.g.dart';

@JsonSerializable()
class LevelsResponse {
  final String message;
  final int totalLevels;
  @JsonKey(name: 'difficulty_levels')
  final List<Level> levels;

  LevelsResponse({
    required this.message,
    required this.totalLevels,
    required this.levels,
  });

  factory LevelsResponse.fromJson(Map<String, dynamic> json) =>
      _$LevelsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LevelsResponseToJson(this);
}

@JsonSerializable()
class Level {
  final String id;
  final String name;

  Level({required this.id, required this.name});

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelToJson(this);
}
