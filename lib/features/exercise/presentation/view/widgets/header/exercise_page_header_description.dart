import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class ExercisePageHeaderDescription extends StatelessWidget {
  final TextTheme textTheme;
  const ExercisePageHeaderDescription({super.key, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        textAlign: TextAlign.center,
        context.l10n.motivational_quote,
        style: textTheme.titleSmall!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
