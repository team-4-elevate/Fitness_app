// features/home/home.dart
import 'dart:ui' as ui;
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/home/widgets/category_section.dart';
import 'package:flutter/material.dart';
import 'widgets/user_info.dart';
import 'widgets/shared_section.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // List of categories with their icons
  static const List<Map<String, dynamic>> _categories = [
    {'name': 'Gym', 'icon': 'assets/images/onboarding_vector_1.png'},
    {'name': 'Fitness', 'icon': 'assets/images/onboarding_vector_1.png'},
    {'name': 'Yoga', 'icon': 'assets/images/onboarding_vector_1.png'},
    {'name': 'Aerobics', 'icon': 'assets/images/onboarding_vector_1.png'},
    {'name': 'Trainer', 'icon': 'assets/images/onboarding_vector_1.png'},
  ];

  // List of daily recommendations
  static const List<Map<String, dynamic>> _dailyRecommendations = [
    {'name': 'Jogging', 'image': 'assets/images/onboarding_vector_1.png'},
    {'name': 'Push-Up', 'image': 'assets/images/onboarding_vector_1.png'},
    {'name': 'Squat', 'image': 'assets/images/onboarding_vector_1.png'},
    {'name': 'Lunges', 'image': 'assets/images/onboarding_vector_1.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //------------------------------------ User info
                    const UserInfo(
                      userName: 'Ahmed',
                      profileImagePath: 'assets/images/onboarding_vector_1.png',
                    ),

                    SizedBox(height: 16.r),

                    //------------------------------------ Categories
                    const CategorySection(categories: _categories),

                    SizedBox(height: 16.r),

                    //------------------------------------ Daily Recommendations
                    SharedSection(
                      sectionTitle: "Daily To Recommendations",
                      showSeeAll: false,
                    ),
                    SizedBox(height: 16.r),

                    //------------------------------------upcoming workouts
                    SharedSection(sectionTitle: "Upcoming Workouts"),
                    SizedBox(height: 16.r),

                    //------------------------------------ Recommendations for you
                    SharedSection(sectionTitle: "Recommendation For You"),

                    SizedBox(height: 100.r),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
