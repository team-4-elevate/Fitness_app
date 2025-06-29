// features/edit_profile/widgets/physical_info_text.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class PhysicalInfoText extends StatefulWidget {
  final String title;
  void Function()? onTap;

  PhysicalInfoText({super.key, required this.title, required this.onTap});

  @override
  State<PhysicalInfoText> createState() => _PhysicalInfoTextState();
}

class _PhysicalInfoTextState extends State<PhysicalInfoText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16.r,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: widget.onTap,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "(",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14.r,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: "tap to Edit",
                  style: TextStyle(
                    color: AppColors.primaryOrange,
                    fontSize: 14.r,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: ")",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14.r,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
