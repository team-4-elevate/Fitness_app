import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ExercisePageBlurWidget extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? sigma;
  final BorderRadiusGeometry? radius;
  const ExercisePageBlurWidget({
    super.key,
    required this.child,
    this.height,
    this.sigma,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: radius ??
            BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: sigma ?? 4, sigmaY: sigma ?? 4),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.1),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
