import '../../../../domain/entites/difficulty_level.dart';

class DifficultyLevelDM {
  final String id;
  final String name;
  DifficultyLevelDM({required this.id, required this.name});

  factory DifficultyLevelDM.fromJson(Map<String, dynamic> json) {

    return DifficultyLevelDM(id: json['_id'] ?? '', name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name};
  }

  DifficultyLevelEntity toEntity() {
    return DifficultyLevelEntity(id: id, name: name);
  }
}
