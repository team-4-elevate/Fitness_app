// features/edit_profile/widgets/editprofile_text.dart
import 'package:fitness_app/core/Constant/app_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditprofileText extends StatelessWidget {
  const EditprofileText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          icon: SvgPicture.asset(AppConstants.customBackIcon),
          onPressed: () {
            Navigator.pop(context);
          },
        ).safeArea,
        Text(
          context.l10n.edit_profile,
          style: TextStyle(
              color: AppColors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 50.r),
      ],
    );
  }
}
