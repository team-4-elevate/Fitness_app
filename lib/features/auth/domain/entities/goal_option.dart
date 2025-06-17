// features/auth/domain/entities/goal_option.dart
import 'package:fitness_app/generated/l10n/app_localizations.dart';

class GoalOption {
  final String id;
  final String label;

  const GoalOption({required this.id, required this.label});

  static List<GoalOption> getGoalOptions({
    required AppLocalizations localization,
  }) {
    return [
      GoalOption(id: 'gain_weight', label: localization.goalGainWeight),
      GoalOption(id: 'lose_weight', label: localization.goalLoseWeight),
      GoalOption(id: 'get_fitter', label: localization.goalGetFitter),
      GoalOption(
        id: 'gain_flexibility',
        label: localization.goalGainFlexibility,
      ),
      GoalOption(id: 'learn_basics', label: localization.goalLearnBasics),
    ];
  }
}
