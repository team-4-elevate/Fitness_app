// features/edit_profile/widgets/goal_page.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/auth/domain/entities/goal_option.dart';
import 'package:fitness_app/features/auth/presentation/register/widget/selection_option_step.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class GoalPage extends StatefulWidget {
  final String? initialGoalId;

  const GoalPage({
    super.key,
    this.initialGoalId,
  });

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  String? _selectedGoalId;

  @override
  void initState() {
    super.initState();
    _selectedGoalId = widget.initialGoalId;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final goalOptions = GoalOption.getGoalOptions(localization: localization);

    final optionItems = goalOptions
        .map((option) => OptionItem(
              id: option.id,
              label: option.label,
            ))
        .toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "WHAT IS YOUR GOAL?",
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
              fontSize: 20.r,
            ),
          ),
          SizedBox(height: 8.r),
          Text(
            "This helps us create your personalized plan",
            style: TextStyle(
              color: AppColors.white.withOpacity(0.8),
              fontSize: 14.r,
            ),
          ),
          SizedBox(height: 30.r),
          SelectionOptionStep(
            options: optionItems,
            selectedOptionId: _selectedGoalId,
            onOptionSelected: (id) {
              setState(() {
                _selectedGoalId = id;
              });
            },
          ),
          SizedBox(height: 20.r),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _selectedGoalId);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
