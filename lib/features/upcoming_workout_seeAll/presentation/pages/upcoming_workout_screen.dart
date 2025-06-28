// features/upcoming_workout_seeAll/presentation/pages/upcoming_workout_screen.dart
import 'package:fitness_app/core/Constant/app_constants.dart';
import 'package:fitness_app/core/base_states/base_state.dart';
import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/exercise/domain/arguments/exercise_page_arguments.dart';
import 'package:fitness_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:fitness_app/features/upcoming_workout_seeAll/presentation/widgets/workout_refresh_mixin.dart';
import 'package:fitness_app/features/upcoming_workout_seeAll/presentation/widgets/workout_error_view.dart';
import 'package:fitness_app/features/upcoming_workout_seeAll/presentation/widgets/workout_grid_item.dart';
import 'package:fitness_app/features/upcoming_workout_seeAll/presentation/widgets/workout_list_grid.dart';
import 'package:fitness_app/features/upcoming_workout_seeAll/presentation/widgets/workout_shimmer_grid_item.dart';
import 'package:fitness_app/features/upcoming_workout_seeAll/presentation/widgets/workout_tab_controller.dart';
import 'package:fitness_app/features/upcoming_workout_seeAll/presentation/widgets/workout_tab_bar_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpComingWorkoutScreen extends StatefulWidget {
  final int? selectedTabIndex;

  const UpComingWorkoutScreen({super.key, this.selectedTabIndex});

  @override
  State<UpComingWorkoutScreen> createState() => _FoodRecommendationScreen();
}

class _FoodRecommendationScreen extends State<UpComingWorkoutScreen>
    with WorkoutRefreshMixin<UpComingWorkoutScreen>, TickerProviderStateMixin {
  bool _hasLoadedInitialExercise = false;

  @override
  void dispose() {
    workoutTabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    workoutTabController = WorkoutTabController(
      vsync: this,
      context: context,
      initialSelectedTabIndex: widget.selectedTabIndex,
    );
    workoutTabController.initialize();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const FetchMuscleGroups());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStateType>(
      buildWhen: (previous, current) {
        if (previous.runtimeType != current.runtimeType) {
          return true;
        }
        if (previous is SuccessState && current is SuccessState) {
          final prevData = (previous as SuccessState).data;
          final currData = (current as SuccessState).data;
          return prevData.muscleGroups != currData.muscleGroups ||
              prevData.workoutsByGroup != currData.workoutsByGroup;
        }
        return false;
      },
      listenWhen: (previous, current) {
        if (previous.runtimeType != current.runtimeType) {
          return true;
        }
        if (previous is SuccessState && current is SuccessState) {
          return (previous as SuccessState).data.muscleGroups !=
              (current as SuccessState).data.muscleGroups;
        }
        return false;
      },
      listener: (context, state) {
        if (state is BaseErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              (state as BaseErrorState).error,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red.shade800,
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () {
                context.read<HomeBloc>().add(const LoadHomeData());
              },
            ),
            duration: const Duration(seconds: 5),
          ));
        } else if (state is SuccessState) {
          final muscleGroups = (state as SuccessState).data.muscleGroups;
          if (muscleGroups.isNotEmpty &&
              workoutTabController.tabController.length !=
                  muscleGroups.length) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                workoutTabController.updateTabController(muscleGroups.length);
              }
            });

            if (!_hasLoadedInitialExercise) {
              _hasLoadedInitialExercise = true;
              int indexToLoad = 0;
              if (widget.selectedTabIndex != null &&
                  widget.selectedTabIndex! < muscleGroups.length) {
                indexToLoad = widget.selectedTabIndex!;
                if (muscleGroups.isNotEmpty &&
                    indexToLoad < muscleGroups.length) {
                  final selectedMuscleGroupId =
                      muscleGroups[indexToLoad].id ?? '';
                  context.read<HomeBloc>().add(
                        FetchWorkoutsByMuscleGroupId(
                            muscleGroupId: selectedMuscleGroupId),
                      );
                }
              } else if (muscleGroups.isNotEmpty) {
                final selectedMuscleGroupId = muscleGroups[0].id ?? '';
                context.read<HomeBloc>().add(
                      FetchWorkoutsByMuscleGroupId(
                          muscleGroupId: selectedMuscleGroupId),
                    );
              }
            }
          }
        }
      },

      //------------------------------------------------body
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppConstants.foodBgImage),
              fit: BoxFit.cover,
            ),
          ),
          child: PopScope(
            canPop: false,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Text(
                  "Upcoming Workouts",
                  style: TextStyle(fontSize: 25.r),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                toolbarHeight: 60.r,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WorkoutTabBarBuilder(
                    state: state,
                  ),
                  SizedBox(height: R.spaceMD),
                  Expanded(
                    child: state is BaseInitialState ||
                            state is BaseLoadingState
                        ? GridView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.85,
                              crossAxisSpacing: 16.w,
                              mainAxisSpacing: 16.h,
                            ),
                            itemCount: 6,
                            itemBuilder: (context, index) =>
                                const WorkoutShimmerGridItem(),
                          )
                        : state is SuccessState
                            ? WorkoutListGrid(
                                workouts: (state as SuccessState)
                                    .data
                                    .workoutsByGroup,
                                onRefresh: refreshWorkouts,
                                buildWorkoutItem: (workout, index) =>
                                    WorkoutGridItem(
                                  workout: workout,
                                  index: index,
                                  onTap: () {
                                      if (workout != null) {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.exercisePage,
                                          arguments: ExercisePageArguments(
                                            muscleGroupId: workout.id,
                                            muscleGroupName: workout.name ?? 'Workout',
                                            muscleGroupImage: workout.image ?? '',
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Cannot open workout details')),
                                        );
                                      }
                                    }
                                  
                                ),
                              )
                            : state is BaseErrorState
                                ? WorkoutErrorView(
                                    errorMessage:
                                        (state as BaseErrorState).error,
                                    onRetry: () => context
                                        .read<HomeBloc>()
                                        .add(const LoadHomeData()))
                                : const SizedBox.shrink(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
