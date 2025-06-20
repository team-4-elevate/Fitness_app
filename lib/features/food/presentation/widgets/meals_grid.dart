import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/food/data/models/meal.dart';
import 'package:fitness_app/features/food/presentation/cubit/food_cubit.dart';
import 'package:fitness_app/features/food/presentation/cubit/food_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MealsGrid extends StatefulWidget {
  const MealsGrid({super.key, required this.realMeals});

  final List<Meal> realMeals;

  @override
  State<MealsGrid> createState() => _MealsGridState();
}

class _MealsGridState extends State<MealsGrid> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final meals =
        (context.read<FoodCubit>().state is Loading)
            ? List.filled(6, Meal(name: 'John Doe', imageUrl: ''))
            : widget.realMeals;
    return Skeletonizer(
      enabled: context.watch<FoodCubit>().state is Loading,
      effect: ShimmerEffect(
        baseColor: AppColors.black.withValues(alpha: 0.4),
        highlightColor: AppColors.gray.withValues(alpha: 0.4),
        duration: Duration(seconds: 1),
      ),
      enableSwitchAnimation: true,
      switchAnimationConfig: SwitchAnimationConfig(
        duration: Duration(milliseconds: 300),
        switchInCurve: Curves.fastOutSlowIn,
      ),

      child: GridView.builder(
        padding: EdgeInsets.all(16.r),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 1,
        ),
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return Container(
            height: 160.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    height: double.infinity,
                    imageUrl:
                        meal.imageUrl == null || meal.imageUrl!.isEmpty
                            ? 'https://st4.depositphotos.com/17828278/24401/v/450/depositphotos_244011872-stock-illustration-image-vector-symbol-missing-available.jpg'
                            : meal.imageUrl!,
                    colorBlendMode: BlendMode.darken,
                    color: Colors.black.withValues(alpha: 0.4),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        meal.name!,
                        style: TextStyle(
                          fontSize: 18.r,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
