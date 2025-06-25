import '../model/difficulty_level_dm.dart';

class DifficultyLevelsResponse {
  final String message;
  final List<DifficultyLevelDM> levels;

  DifficultyLevelsResponse({required this.message, required this.levels});

  factory DifficultyLevelsResponse.fromJson(Map<String, dynamic> json) {
    return DifficultyLevelsResponse(
      message: json['message'] ?? '',
      levels:
      (json['levels'] as List<dynamic>?)
          ?.map((x) => DifficultyLevelDM.fromJson(x))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'levels': levels.map((x) => x.toJson()).toList(),
    };
  }
}
