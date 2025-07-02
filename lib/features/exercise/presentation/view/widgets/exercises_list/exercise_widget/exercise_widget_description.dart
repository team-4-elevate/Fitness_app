import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class ExerciseWidgetDescription extends StatelessWidget {
  final String? name;
  final String? targetMuscleGroup;
  final String? primeMoverMuscle;
  const ExerciseWidgetDescription({
    super.key,
    required this.name,
    required this.targetMuscleGroup,
    required this.primeMoverMuscle,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name ?? context.l10n.exercise,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 6),
          Text(
            targetMuscleGroup ?? '',
            style: textTheme.bodyMedium?.copyWith(
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            primeMoverMuscle ?? '',
            style: textTheme.bodyMedium?.copyWith(
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
