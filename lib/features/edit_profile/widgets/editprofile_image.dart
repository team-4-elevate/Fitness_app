// features/edit_profile/widgets/editprofile_image.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class EditprofileImage extends StatelessWidget {
  const EditprofileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryOrange.withOpacity(0.3),
                spreadRadius: 10,
                blurRadius: 15,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 60.r,
            backgroundImage:
                const AssetImage('assets/images/onboarding_vector_3.png'),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryOrange,
                width: 3.r,
              )),
          child: Icon(
            Icons.edit_outlined,
            size: 24.r,
            color: AppColors.primaryOrange,
          ),
        ),
      ],
    );
  }
}
