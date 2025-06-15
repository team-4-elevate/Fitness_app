// features/auth/data/model/goal_option.dart
// Goal option model class to represent each goal option
class GoalOption {
  final String id;
  final String label;

  const GoalOption({required this.id, required this.label});

  static List<GoalOption> getGoalOptions() {
    return [
      const GoalOption(id: 'gain_weight', label: 'Gain Weight'),
      const GoalOption(id: 'lose_weight', label: 'Lose Weight'),
      const GoalOption(id: 'get_fitter', label: 'Get Fitter'),
      const GoalOption(id: 'gain_flexibility', label: 'Gain More Flexible'),
      const GoalOption(id: 'learn_basics', label: 'Learn The Basic'),
    ];
  }
}
