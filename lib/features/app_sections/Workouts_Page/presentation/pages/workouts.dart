import 'package:fitness_app/core/Constant/app_constants.dart';
import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/cubit/Workouts_ViewModel.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/cubit/Workouts_intent.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/cubit/Workouts_state.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/widgets/Workouts_categories_tabbar.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/widgets/Workouts_error_view.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/widgets/Workouts_grid_loading.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/widgets/Workouts_grid_view_widget.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/widgets/Workouts_tab_bar_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() =>
      _WorkoutPageState();
}

class _WorkoutPageState
    extends State<WorkoutPage> with TickerProviderStateMixin {
  late TabController _tabController;
  bool _hasLoadedInitialMuscles = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 0, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WorkoutRecommendationViewModel>().doIntent(
            const GetMuscleGroupsIntent(),
          );
    });
  }

  void _updateTabController(int tabCount) {
    if (tabCount <= 0) return;
    final previousIndex = _tabController.length > 0 ? _tabController.index : 0;
    _tabController.dispose();
    _tabController = TabController(
      length: tabCount,
      vsync: this,
      initialIndex: previousIndex < tabCount ? previousIndex : 0,
    );
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        context.read<WorkoutRecommendationViewModel>().doIntent(
              ChangeSelectedGroupIntent(_tabController.index),
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkoutRecommendationViewModel, WorkoutRecommendationState>(
      buildWhen: (prev, curr) =>
          prev.selectedGroupIndex != curr.selectedGroupIndex ||
          prev.muscleGroupsState != curr.muscleGroupsState ||
          prev.musclesByGroupState != curr.musclesByGroupState ||
          prev.cachedMuscles != curr.cachedMuscles ||
          prev.loadingGroups != curr.loadingGroups,
      listenWhen: (prev, curr) =>
          prev.muscleGroupsState != curr.muscleGroupsState ||
          prev.selectedGroupIndex != curr.selectedGroupIndex,
      listener: (context, state) {
        state.muscleGroupsState?.whenOrNull(
          success: (data) {
            final groups = data ?? [];
            if (groups.isNotEmpty &&
                _tabController.length != groups.length) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) _updateTabController(groups.length);
              });

              if (!_hasLoadedInitialMuscles) {
                _hasLoadedInitialMuscles = true;
                final firstGroupId = groups[0].id ?? '';
                context.read<WorkoutRecommendationViewModel>().doIntent(
                      GetMusclesByGroupIntent(firstGroupId),
                    );
              }
            }
          },
          error: (error) {
            context.showErrorSnackBar(error ?? '');
          },
        );

        state.musclesByGroupState?.whenOrNull(
          error: (error) => context.showErrorSnackBar(error ?? ''),
        );

        if (_tabController.length > 0 &&
            _tabController.index != state.selectedGroupIndex &&
            state.selectedGroupIndex < _tabController.length) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && !_tabController.indexIsChanging) {
              _tabController.animateTo(state.selectedGroupIndex);
            }
          });
        }
      },
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppConstants.workoutBgImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(context.l10n.food_Recommendation_title),
              leadingWidth: 35.r,
              leading: SvgPicture.asset(AppConstants.customBackIcon)
                  .onTap(() => Navigator.of(context).pop())
                  .paddingAll(2.r),
            ),
            body: Column(
              children: [
                state.muscleGroupsState?.whenOrNull(
                      loading: () => const WorkoutTabBarLoading(),
                      initial: () => const WorkoutTabBarLoading(),
                      success: (groups) {
                        final groupList = groups ?? [];
                        if (_tabController.length == groupList.length) {
                          return WorkoutsCategoriesTabbar(
                            tabController: _tabController,
                             IdMuscles: [], selectedCategoryIndex: _tabController.index,
                          );
                        } else {
                          return const WorkoutTabBarLoading();
                        }
                      },
                    ) ??
                    const SizedBox.shrink(),
                SizedBox(height: R.spaceMD),
                Expanded(
                  child: state.muscleGroupsState?.when(
                        initial: () => const WorkoutGridLoading(),
                        loading: () => const WorkoutGridLoading(),
                        success: (groups) {
                          final groupList = groups ?? [];
                          if (groupList.isEmpty ||
                              _tabController.length != groupList.length) {
                            return const WorkoutGridLoading();
                          }
                          return state.musclesByGroupState?.when(
                                initial: () => const WorkoutGridLoading(),
                                loading: () => const WorkoutGridLoading(),
                                success: (_) => WorkoutGridViewWidget(
                                  tabController: _tabController,
                                  muscleGroups:  groupList,
                                  cachedWorkouts: state.cachedMuscles,
                                  loadingGroups: state.loadingGroups,
                                  selectedGroupIndex: state.selectedGroupIndex,
                                ),
                                error: (error) => WorkoutErrorView(
                                  categoryList: groupList, 
                                  error: error,
                                  workoutsViewModel: context.read<WorkoutRecommendationViewModel>(),
                                  selectedCategoryIndex: state.selectedGroupIndex,
                                  onPressed: () {
                                    final groupId = groupList[state.selectedGroupIndex].id ?? '';
                                    context.read<WorkoutRecommendationViewModel>().doIntent(
                                          GetMusclesByGroupIntent(groupId),
                                        );
                                  }, 
                                ),
                              ) ??
                              const WorkoutGridLoading();
                        },
                        error: (error) => WorkoutErrorView(
                          categoryList: [],
                          error: error,
                          workoutsViewModel: context.read<WorkoutRecommendationViewModel>(),
                          selectedCategoryIndex: state.selectedGroupIndex,
                          onPressed: () {
                            context.read<WorkoutRecommendationViewModel>().doIntent(
                                  const GetMuscleGroupsIntent(),
                                );
                          },
                        ),
                      ) ??
                      const WorkoutGridLoading(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
