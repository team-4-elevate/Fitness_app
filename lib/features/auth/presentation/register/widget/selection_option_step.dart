// features/auth/presentation/register/widget/selection_option_step.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class OptionItem {
  final String id;
  final String label;
  final String? description;

  const OptionItem({required this.id, required this.label, this.description});
}

class SelectionOptionStep extends StatelessWidget {
  final List<OptionItem> options;
  final String? selectedOptionId;
  final Function(String) onOptionSelected;

  const SelectionOptionStep({
    super.key,
    required this.options,
    required this.selectedOptionId,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10.r),
        SizedBox(
          height: 300.r,
          width: double.infinity,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options[index];
              return _buildOption(
                title: option.description != null
                    ? '${option.label} - ${option.description}'
                    : option.label,
                isSelected: selectedOptionId == option.id,
                onTap: () => onOptionSelected(option.id),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOption({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.r),
        width: double.infinity,
        height: 40.r,
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryOrange : Colors.transparent,
            width: 1.r,
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 20.r),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.r,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.r),
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.r,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10.r,
                        height: 10.r,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
