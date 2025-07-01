// features/edit_profile/domain/entities/activity_level_constants.dart

class ActivityLevelConstants {
  static const List<String> validLevels = [
    'level1',
    'level2',
    'level3',
    'level4',
    'level5'
  ];
  
  static String getLabel(String activityLevel) {
    switch (activityLevel) {
      case 'level1': return 'Rookie';
      case 'level2': return 'Beginner';
      case 'level3': return 'Intermediate';
      case 'level4': return 'Advanced';
      default: return 'True Beast';  // level5
    }
  }
}
