// features/app_sections/AppSections.dart
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/app_sections/ChatAipage.dart';
import 'package:fitness_app/features/app_sections/GymPage.dart';
import 'package:fitness_app/features/app_sections/ProfilePage.dart';
import 'package:fitness_app/features/home/home.dart';
import 'package:flutter/material.dart';

class MainNavigationScreen extends StatefulWidget {
  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = const [Home(), ChatAipage(), GymPage(), ProfilePage()];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildFloatingNavBar() {
    return Container(
      margin: EdgeInsets.all(32.w),
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      height: 80.h,
      decoration: BoxDecoration(
        color: Colors.grey[900]?.withOpacity(0.95),
        borderRadius: BorderRadius.circular(40.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 10.r),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavIcon("home.png", 0),
          _buildNavIcon("chat_ai.png", 1),
          _buildNavIcon("gym.png", 2),
          _buildNavIcon("profile.png", 3),
        ],
      ),
    );
  }

  Widget _buildNavIcon(String assetName, int index) {
    final isSelected = _selectedIndex == index;
    final List<String> labels = ["Explore", "Chat AI", "Gym", "Profile"];

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 1.0, end: isSelected ? 1.2 : 1.0),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/$assetName',
                  width: 28.w,
                  height: 28.h,
                  color: isSelected ? Colors.deepOrange : Colors.white,
                ),
                SizedBox(height: 4.h),
                if (isSelected)
                  Text(
                    labels[index],
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _pages[_selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildFloatingNavBar(),
          ),
        ],
      ),
    );
  }
}
