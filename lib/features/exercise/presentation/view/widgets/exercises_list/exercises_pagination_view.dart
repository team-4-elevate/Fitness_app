import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entites/exercise_entity.dart';
import '../../../bloc/exercise_bloc.dart';
import '../../../bloc/exercise_event.dart';
import '../../../bloc/exercise_state.dart';
import '../header/gradient_blur_header_widget.dart';
import 'exercise_widget/exercise_widget.dart';

class ExercisesPaginationView extends StatefulWidget {
  final List<ExerciseEntity?> stateExercises;
  final String muscleGroupId;
  final String levelId;
  const ExercisesPaginationView({
    super.key,
    required this.stateExercises,
    required this.muscleGroupId,
    required this.levelId,
  });

  @override
  State<ExercisesPaginationView> createState() =>
      _ExercisesPaginationViewState();
}

class _ExercisesPaginationViewState extends State<ExercisesPaginationView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ExercisePageBlurWidget(
        sigma: 16,
        radius: BorderRadius.circular(20),
        child: BlocBuilder<ExercisePageBloc, ExercisePageState>(
          builder: (context, state) {
            final currentExercises =
                state.levelExerciseMap[state.levelExerciseMap.keys.firstWhere(
                  (level) => level.id == widget.levelId,
                  orElse: () => state.levelExerciseMap.keys.first,
                )] ??
                [];

            return ListView.separated(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount:
                  currentExercises.length +
                  (state.isLoadingMore == true ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == currentExercises.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final exercise = currentExercises[index];
                return TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 150 + (index * 100)),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ExerciseWidget(exercise: exercise),
                        ),
                      ),
                    );
                  },
                );
              },
              separatorBuilder:
                  (context, index) =>
                      index == currentExercises.length - 1 &&
                              state.isLoadingMore == true
                          ? const SizedBox.shrink()
                          : SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            height: 0.4,
                            child: ColoredBox(color: Colors.grey),
                          ),
            );
          },
        ),
      ),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ExercisePageBloc>().add(
        LoadMoreExercisesEvent(
          muscleGroupId: widget.muscleGroupId,
          levelId: widget.levelId,
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
