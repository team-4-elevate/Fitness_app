// features/auth/data/model/activity_level_option.dart
import 'package:fitness_app/generated/l10n/app_localizations.dart';

class ActivityLevelOption {
  final String id;
  final String label;

  const ActivityLevelOption({required this.id, required this.label});

  static List<ActivityLevelOption> getActivityLevelOptions({
    required AppLocalizations localization,
  }) {
    return [
      ActivityLevelOption(id: 'level1', label: localization.activityRookie),
      ActivityLevelOption(id: 'level2', label: localization.activityBeginner),
      ActivityLevelOption(
        id: 'level3',
        label: localization.activityIntermediate,
      ),
      ActivityLevelOption(id: 'level4', label: localization.activityAdvanced),
      ActivityLevelOption(id: 'level5', label: localization.activityTrueBeast),
    ];
  }
}
