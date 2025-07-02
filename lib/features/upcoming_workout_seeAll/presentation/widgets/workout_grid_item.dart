// features/upcoming_workout_seeAll/presentation/widgets/workout_grid_item.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WorkoutGridItem extends StatelessWidget {
  final dynamic workout;
  final int index;
  final VoidCallback? onTap;

  const WorkoutGridItem({
    super.key,
    required this.workout,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String workoutName = "Workout";
    try {
      workoutName = workout.name ?? "Untitled Workout";
    } catch (e) {
      workoutName = "Workout ${index + 1}";
    }

    return InkWell(
      onTap: onTap ?? () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.black54,
              child: Image.network(
                workout.image ??
                    'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=1000',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.black54,
                  child: Center(
                    child: Icon(Icons.fitness_center,
                        size: 40, color: Colors.deepOrange),
                  ),
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Shimmer.fromColors(
                    baseColor: AppColors.backgroundDark,
                    highlightColor: AppColors.shimmerBaseColor,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(color: AppColors.blurBackground),
                          Positioned(
                            left: 10,
                            right: 10,
                            bottom: 10,
                            child: Container(
                              height: 16,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: Text(
                workoutName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
