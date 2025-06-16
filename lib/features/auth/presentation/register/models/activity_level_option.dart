// features/auth/data/model/activity_level_option.dart
class ActivityLevelOption {
  final String id;
  final String label;

  const ActivityLevelOption({required this.id, required this.label});

  static List<ActivityLevelOption> getActivityLevelOptions() {
    return [
      const ActivityLevelOption(id: 'level1', label: 'Rookie'),
      const ActivityLevelOption(id: 'level2', label: 'Beginner'),
      const ActivityLevelOption(id: 'level3', label: 'Intermediate'),
      const ActivityLevelOption(id: 'level4', label: 'Advance'),
      const ActivityLevelOption(id: 'level5', label: 'True Beast'),
    ];
  }
}
