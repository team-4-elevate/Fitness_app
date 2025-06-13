import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: context.textTheme.headlineMedium?.copyWith(
            color: AppColors.primaryOrange,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Page!',
          style: context.textTheme.bodyLarge?.copyWith(
            color: AppColors.primaryOrange,
          ),
        ),
      ),
    );
  }
}
