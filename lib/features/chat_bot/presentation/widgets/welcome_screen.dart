import 'package:fitness_app/core/generated/assets.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/widgets/blurred_container.dart';
import 'package:fitness_app/features/chat_bot/presentation/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: context.topPadding),
        Expanded(flex: 20, child: Image.asset(Assets.imagesRobot)),
        BlurredContainer(
          width: double.infinity,
          backgroundBlur: 15,
          backgroundColor: AppColors.blurBackground.withValues(alpha: .2),
          borderRadius: 50,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                context.l10n.welcomeTitle,
                style: context.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<ChatBloc>().add(StartChatPressed());
                },
                child: Text(context.l10n.welcomeBtn),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
