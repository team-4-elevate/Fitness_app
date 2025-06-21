// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'levels_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelsResponse _$LevelsResponseFromJson(Map<String, dynamic> json) =>
    LevelsResponse(
      message: json['message'] as String,
      totalLevels: (json['totalLevels'] as num).toInt(),
      levels:
          (json['difficulty_levels'] as List<dynamic>)
              .map((e) => Level.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$LevelsResponseToJson(LevelsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'totalLevels': instance.totalLevels,
      'difficulty_levels': instance.levels,
    };

Level _$LevelFromJson(Map<String, dynamic> json) =>
    Level(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$LevelToJson(Level instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};
