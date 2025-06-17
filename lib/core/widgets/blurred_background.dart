import 'dart:ui';
import 'package:fitness_app/core/Constant/app_constants.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BlurredBackground extends StatelessWidget {
  final Widget child;
  final String? backgroundImage;
  final double blurSigma;
  final bool isScrollable;

  const BlurredBackground({
    super.key,
    required this.child,
    this.backgroundImage = AppConstants.authCustomBG,
    this.blurSigma = 0,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image:
            backgroundImage != null
                ? DecorationImage(
                  image: AssetImage(backgroundImage!),
                  fit: BoxFit.cover,
                )
                : null,
        color: backgroundImage == null ? AppColors.backgroundDark : null,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          child: isScrollable ? child.scrollable : child,
        ),
      ),
    );
  }
}
