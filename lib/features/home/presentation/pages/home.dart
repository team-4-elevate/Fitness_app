// features/home/presentation/pages/home.dart
import 'dart:ui' as ui;
import 'package:fitness_app/core/base_states/base_state.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/home/domain/entities/daily_recommendation_item.dart';
import 'package:fitness_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:fitness_app/features/home/presentation/widgets/category_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/user_info.dart';
import '../widgets/shared_section.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Load daily recommendations when the screen initializes
    context.read<HomeBloc>().add(const LoadHomeData());
  }

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
    {'name': 'Jogging', 'image': 'assets/images/cat.jpg'},
    {'name': 'Push-Up', 'image': 'assets/images/cat.jpg'},
    {'name': 'Squat', 'image': 'assets/images/cat.jpg'},
    {'name': 'Lunges', 'image': 'assets/images/cat.jpg'},
  ];

  // List of upcoming workouts
  static const List<Map<String, dynamic>> _upcomingWorkouts = [
    {'name': 'Morning Run', 'image': 'assets/images/cat.jpg'},
    {'name': 'Evening Yoga', 'image': 'assets/images/cat.jpg'},
    {'name': 'Core Workout', 'image': 'assets/images/cat.jpg'},
    {'name': 'Arm Day', 'image': 'assets/images/cat.jpg'},
  ];

  // List of recommendations for you
  static const List<Map<String, dynamic>> _recommendationsForYou = [
    {'name': 'HIIT Training', 'image': 'assets/images/cat.jpg'},
    {'name': 'Stretching', 'image': 'assets/images/cat.jpg'},
    {'name': 'Pilates', 'image': 'assets/images/cat.jpg'},
    {'name': 'Cardio', 'image': 'assets/images/cat.jpg'},
  ];

  // List of popular trainings
  static const List<Map<String, dynamic>> _popularTrainings = [
    {
      'name': 'Chest Workout',
      'image': 'assets/images/cat.jpg',
      'tasks': '24 Tasks',
      'level': 'Beginner',
    },
    {
      'name': 'Arm Workout',
      'image': 'assets/images/cat.jpg',
      'tasks': '18 Tasks',
      'level': 'Intermediate',
    },
    {
      'name': 'Leg Day',
      'image': 'assets/images/cat.jpg',
      'tasks': '15 Tasks',
      'level': 'Beginner',
    },
    {
      'name': 'Core Strength',
      'image': 'assets/images/cat.jpg',
      'tasks': '30 Tasks',
      'level': 'Advanced',
    },
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
                    BlocBuilder<HomeBloc, HomeStateType>(
                      builder: (context, state) {
                        return switch (state) {
                          BaseInitialState() => const SizedBox(),
                          BaseLoadingState() => const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          SuccessState<HomeData>() =>
                            (() {
                              final data = (state).data;
                              final recommendations =
                                  data.dailyRecommendations
                                      .map(
                                        (item) => {
                                          'name': item.name,
                                          'image': item.imageUrl,
                                        },
                                      )
                                      .toList();

                              return SharedSection(
                                sectionTitle: "Daily To Recommendations",
                                showSeeAll: false,
                                recommendations: recommendations,
                              );
                            })(),
                          BaseErrorState() => Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'Error loading recommendations: ${(state as BaseErrorState).error}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        };
                      },
                    ),
                    SizedBox(height: 16.r),

                    //------------------------------------upcoming workouts
                    SharedSection(
                      sectionTitle: "Upcoming Workouts",
                      recommendations: _upcomingWorkouts,
                      onSeeAllPressed: () {
                        debugPrint('See All pressed for Upcoming Workouts');
                      },
                    ),
                    SizedBox(height: 16.r),

                    //------------------------------------ Recommendations for you
                    SharedSection(
                      sectionTitle: "Recommendation For You",
                      recommendations: _recommendationsForYou,
                      onSeeAllPressed: () {
                        debugPrint(
                          'See All pressed for Recommendations For You',
                        );
                      },
                    ),
                    SizedBox(height: 16.r),

                    //--------------------------------------popular training
                    SharedSection(
                      sectionTitle: "popular training",
                      showSeeAll: false,
                      isPopularTraining: true,
                      recommendations: _popularTrainings,
                    ),
                    SizedBox(height: 16.r),

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
