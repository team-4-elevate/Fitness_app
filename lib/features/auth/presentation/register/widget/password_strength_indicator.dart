// features/auth/presentation/register/widget/password_strength_indicator.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final int strength;

  const PasswordStrengthIndicator({super.key, required this.strength});

  // Get color based on password strength
  Color _getStrengthColor(int strength) {
    switch (strength) {
      case 1:
        return AppColors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.grey.withOpacity(0.5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Expanded(
          child: Container(
            height: 4.r,
            margin: EdgeInsets.symmetric(horizontal: 2.r),
            decoration: BoxDecoration(
              color: index < strength
                  ? _getStrengthColor(strength)
                  : Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        );
      }),
    );
  }
}
