// features/auth/presentation/auth_common_widgets/social_buttons.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 2.r),
            Container(
              height: .2.r,
              width: 80.r,
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            Text(
              "Or",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14.r,
              ),
            ),
            Container(
              height: .2.r,
              width: 80.r,
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 2.r),
          ],
        ),

        SizedBox(height: 24.r),

        // Social media buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Facebook
            _SocialButton(
              iconPath: 'assets/icons/facebook.svg',
              onTap: () {
              },
            ),

            // Google
            SizedBox(width: 16.r),
            _SocialButton(
              iconPath: 'assets/icons/google.svg',
              onTap: () {
              },
            ),

            // Apple
            SizedBox(width: 16.r),
            _SocialButton(
              iconPath: 'assets/icons/apple.svg',
              onTap: () {
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;

  const _SocialButton({required this.iconPath, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 20.r,
        backgroundColor: AppColors.surfaceDark,
        child: SvgPicture.asset(iconPath, height: 24.r, width: 24.r),
      ),
    );
  }
}
