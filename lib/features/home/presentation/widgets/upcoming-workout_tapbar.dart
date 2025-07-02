// features/home/presentation/widgets/upcoming-workout_tapbar.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class UpcomingWorkoutTabBar extends StatelessWidget {
  final List<String> tabNames;
  final Function(int)? onTabSelected;

  const UpcomingWorkoutTabBar({
    super.key,
    this.tabNames = const ['Full Body', 'Chest', 'Arm', 'Leg', 'Abs'],
    this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabNames.length,
      child: TabBar(
        physics: const BouncingScrollPhysics(),
        labelStyle: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicator: BoxDecoration(
          color: AppColors.primaryOrange,
          borderRadius: BorderRadius.circular(20),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        dividerColor: Colors.transparent,
        onTap: onTabSelected,
        tabs: List.generate(
          tabNames.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Tab(height: 32.r, text: tabNames[index]),
          ),
        ),
      ),
    );
  }
}
