// features/auth/domain/models/activity_level_option.dart
class ActivityLevelOption {
  final String id;
  final String label;
  
  const ActivityLevelOption({
    required this.id,
    required this.label,
  });
  
  // Factory to create a list of all available activity levels
  static List<ActivityLevelOption> getActivityLevelOptions() {
    return [
      const ActivityLevelOption(
        id: 'rookie', 
        label: 'Rookie'
      ),
      const ActivityLevelOption(
        id: 'beginner', 
        label: 'Beginner'
      ),
      const ActivityLevelOption(
        id: 'intermediate', 
        label: 'Intermediate'
      ),
      const ActivityLevelOption(
        id: 'advance', 
        label: 'Advance'
      ),
      const ActivityLevelOption(
        id: 'true_beast', 
        label: 'True Beast'
      ),
    ];
  }
}
