// features/edit_profile/presentation/view/widgets/activity_level_page.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/auth/domain/entities/activity_level_option.dart';
import 'package:fitness_app/features/auth/presentation/register/widget/selection_option_step.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ActivityLevelPage extends StatefulWidget {
  final String? initialActivityLevelId;

  const ActivityLevelPage({
    super.key,
    this.initialActivityLevelId,
  });

  @override
  State<ActivityLevelPage> createState() => _ActivityLevelPageState();
}

class _ActivityLevelPageState extends State<ActivityLevelPage> {
  String? _selectedActivityLevelId;

  @override
  void initState() {
    super.initState();
    _selectedActivityLevelId = widget.initialActivityLevelId;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final activityLevelOptions =
        ActivityLevelOption.getActivityLevelOptions(localization: localization);

    final optionItems = activityLevelOptions
        .map((option) => OptionItem(id: option.id, label: option.label))
        .toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.l10n.what_is_your_activity_level,
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
              fontSize: 20.r,
            ),
          ),
          SizedBox(height: 8.r),
          Text(
            context.l10n.activity_level_help_text,
            style: TextStyle(
              color: AppColors.white.withOpacity(0.8),
              fontSize: 14.r,
            ),
          ),
          SizedBox(height: 30.r),
          SelectionOptionStep(
            options: optionItems,
            selectedOptionId: _selectedActivityLevelId,
            onOptionSelected: (id) {
              setState(() {
                _selectedActivityLevelId = id;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_selectedActivityLevelId != null) {
                Navigator.pop(context, _selectedActivityLevelId);
              } else {
                Navigator.pop(context);
              }
            },
            child: Text(context.l10n.done),
          ),
        ],
      ),
    );
  }
}
