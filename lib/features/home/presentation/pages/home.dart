// features/home/presentation/pages/home.dart
import 'package:fitness_app/core/base_states/base_state.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/services/navigation_service.dart';
import 'package:fitness_app/features/exercise/domain/arguments/exercise_page_arguments.dart';
import 'package:fitness_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:fitness_app/features/home/presentation/widgets/category_section.dart';
import 'package:fitness_app/features/home/presentation/widgets/skeleton.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart';
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
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const LoadHomeData());
    context.read<HomeBloc>().add(const FetchMuscleGroups());
  }

  List<Map<String, dynamic>> _getLocalizedCategories(BuildContext context) {
    return [
      {
        'name': AppLocalizations.of(context).category_gym,
        'icon': 'assets/images/onboarding_vector_1.png',
      },
      {
        'name': AppLocalizations.of(context).category_fitness,
        'icon': 'assets/images/onboarding_vector_1.png',
      },
      {
        'name': AppLocalizations.of(context).category_yoga,
        'icon': 'assets/images/onboarding_vector_1.png',
      },
      {
        'name': AppLocalizations.of(context).category_aerobics,
        'icon': 'assets/images/onboarding_vector_1.png',
      },
      {
        'name': AppLocalizations.of(context).category_trainer,
        'icon': 'assets/images/onboarding_vector_1.png',
      },
    ];
  }

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
    return PopScope(
      canPop: false,
      child: Scaffold(
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
              child: RefreshIndicator(
                color: Theme.of(context).primaryColor,
                onRefresh: () async {
                  context.read<HomeBloc>().add(const LoadHomeData());
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //------------------------------------ User info
                        const UserInfo(
                          userName: 'shimaa',
                          profileImagePath:
                              'assets/images/onboarding_vector_1.png',
                        ),

                        SizedBox(height: 16.r),

                        //------------------------------------ Categories
                        CategorySection(
                          categories: _getLocalizedCategories(context),
                        ),

                        SizedBox(height: 16.r),

                        //------------------------------------ Daily Recommendations
                        BlocBuilder<HomeBloc, HomeStateType>(
                          builder: (context, state) {
                            return switch (state) {
                              BaseInitialState() ||
                              BaseLoadingState() =>
                                const Skeleton(),
                              SuccessState<HomeData>() => (() {
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
                                    sectionTitle: AppLocalizations.of(
                                      context,
                                    ).dailyToRecommendations,
                                    showSeeAll: false,
                                    recommendations: recommendations,
                                    onItemPressed: (item, index) {
                                      final exerciseItem =
                                          data.dailyRecommendations[index];
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.exercisePage,
                                        arguments: ExercisePageArguments(
                                          muscleGroupId: exerciseItem.id,
                                          muscleGroupName: exerciseItem.name,
                                          muscleGroupImage:
                                              exerciseItem.imageUrl,
                                        ),
                                      );
                                    },
                                  );
                                })(),
                              BaseErrorState() => Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      ).home_error_loading_daily_recommendations(
                                        (state as BaseErrorState).error,
                                      ),
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                            };
                          },
                        ),
                        SizedBox(height: 16.r),

                        //------------------------------------upcoming workouts
                        BlocBuilder<HomeBloc, HomeStateType>(
                          builder: (context, state) {
                            return switch (state) {
                              BaseInitialState() ||
                              BaseLoadingState() =>
                                const Skeleton(),
                              SuccessState<HomeData>() => (() {
                                  final data = (state).data;
                                  final muscleGroups = ['Full Body'];
                                  final muscleGroupIds = ['all'];

                                  muscleGroups.addAll(
                                    data.muscleGroups.map(
                                      (group) => group.name ?? 'Other',
                                    ),
                                  );

                                  muscleGroupIds.addAll(
                                    data.muscleGroups.map(
                                      (group) => group.id ?? '',
                                    ),
                                  );

                                  if (data.workoutsByGroup.isEmpty &&
                                      _selectedCategoryIndex == 0) {
                                    context.read<HomeBloc>().add(
                                          const FetchWorkoutsByMuscleGroupId(
                                            muscleGroupId: 'all',
                                          ),
                                        );
                                  }

                                  final workoutsToDisplay = data.workoutsByGroup
                                      .map(
                                        (workout) => {
                                          'name': workout.name,
                                          'image': workout.image,
                                        },
                                      )
                                      .toList();

                                  return SharedSection(
                                    sectionTitle: AppLocalizations.of(
                                      context,
                                    ).home_upcoming_workouts,
                                    recommendations: workoutsToDisplay,
                                    onSeeAllPressed: () {
                                      NavigationService().navigateToTab(2);
                                    },
                                    onItemPressed: (item, index) {
                                      if (index < data.workoutsByGroup.length) {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.exercisePage,
                                          arguments: ExercisePageArguments(
                                            muscleGroupId:
                                                data.workoutsByGroup[index].id,
                                            muscleGroupName: data
                                                .workoutsByGroup[index].name,
                                            muscleGroupImage: data
                                                .workoutsByGroup[index].image,
                                          ),
                                        );
                                      }
                                    },
                                    upcomingWorkoutsTabs: muscleGroups,
                                    onUpcomingWorkoutsSelected: (index) {
                                      setState(() {
                                        _selectedCategoryIndex = index;
                                      });
                                      if (index >= 0 &&
                                          index < muscleGroupIds.length) {
                                        final muscleGroupId =
                                            muscleGroupIds[index];

                                        context.read<HomeBloc>().add(
                                              FetchWorkoutsByMuscleGroupId(
                                                muscleGroupId: muscleGroupId,
                                              ),
                                            );
                                      }
                                    },
                                  );
                                })(),
                              BaseErrorState() => Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      ).home_error_loading_upcoming_workouts(
                                        (state as BaseErrorState).error,
                                      ),
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                            };
                          },
                        ),
                        SizedBox(height: 16.r),

                        //------------------------------------ Food Recommendations for you
                        BlocBuilder<HomeBloc, HomeStateType>(
                          builder: (context, state) {
                            return switch (state) {
                              BaseInitialState() ||
                              BaseLoadingState() =>
                                const Skeleton(),
                              SuccessState<HomeData>() => (() {
                                  final data = (state).data;
                                  final foodRecommendations =
                                      data.foodRecommendations
                                          .map(
                                            (item) => {
                                              'name': item.name,
                                              'image': item.imageUrl,
                                            },
                                          )
                                          .toList();

                                  return SharedSection(
                                    sectionTitle: AppLocalizations.of(
                                      context,
                                    ).home_recommendations_for_you,
                                    recommendations: foodRecommendations,
                                    onSeeAllPressed: () {
                                      debugPrint(
                                        'See All pressed for Food Recommendations',
                                      );
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.foodRecommendationScreen,
                                      );
                                    },
                                    onItemPressed: (item, index) {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.foodRecommendationScreen,
                                        arguments: {'selectedTabIndex': index},
                                      );
                                    },
                                  );
                                })(),
                              BaseErrorState() => Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      ).home_error_loading_food_recommendations(
                                        (state as BaseErrorState).error,
                                      ),
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                            };
                          },
                        ),
                        SizedBox(height: 16.r),

                        //--------------------------------------popular training
                        SharedSection(
                          sectionTitle: AppLocalizations.of(
                            context,
                          ).home_popular_training,
                          showSeeAll: false,
                          isPopularTraining: true,
                          recommendations: _popularTrainings,
                          onItemPressed: (item, index) {
                            debugPrint(
                              'Popular Training Item pressed: ${item['name']} at index $index',
                            );
                          },
                        ),

                        SizedBox(height: 100.r),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
