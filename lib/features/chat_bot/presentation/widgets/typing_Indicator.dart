import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/core/theme/app_colors.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<int> _dotCountAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _dotCountAnimation = StepTween(
      begin: 1,
      end: 5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _dotCountAnimation,
      builder: (context, child) {
        final dots = '.' * _dotCountAnimation.value;
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            // width: 90.w,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.backgroundDark.withAlpha(120),
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.zero,
                bottomStart: Radius.circular(30),
                topEnd: Radius.circular(30),
                bottomEnd: Radius.circular(30),
              ),
            ),
            child: Text(
              'Typing $dots',
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryOrange,
              ),
            ),
          ),
        );
      },
    );
  }
}
