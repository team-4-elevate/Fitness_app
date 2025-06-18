// features/auth/presentation/register/widget/gender_step.dart
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/auth/data/model/register_details.dart';
import 'package:fitness_app/features/auth/presentation/register/pages/register_details_view.dart' as v;
import 'package:fitness_app/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class GenderStep extends StatelessWidget {
  final RegisterDetailsData userData;
  final Function(String) onGenderSelected;

  const GenderStep({
    super.key,
    required this.userData,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 40.r),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGenderOption(
                label: AppLocalizations.of(context).male,
                icon: Icons.male,
                isSelected: userData.gender == Gender.male,
                onTap:
                    () => onGenderSelected(AppLocalizations.of(context).male),
              ),
              SizedBox(height: 40.r),
              _buildGenderOption(
                label: AppLocalizations.of(context).female,
                icon: Icons.female,
                isSelected: userData.gender == Gender.female,
                onTap:
                    () => onGenderSelected(AppLocalizations.of(context).female),
              ),
            ],
          ),

          SizedBox(height: 60.r),
        ],
      ),
    );
  }

  Widget _buildGenderOption({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 100.r,
            height: 100.r,
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? Colors.deepOrange
                      : Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    isSelected
                        ? Colors.deepOrange
                        : Colors.white.withOpacity(0.5),
                width: 2.r,
              ),
            ),
            child: Center(child: Icon(icon, color: Colors.white, size: 40.r)),
          ),
          SizedBox(height: 8.r),
          Text(label, style: TextStyle(color: Colors.white, fontSize: 14.r)),
        ],
      ),
    );
  }
}
