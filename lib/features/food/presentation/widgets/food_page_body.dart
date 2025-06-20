import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/food/data/models/category.dart';
import 'package:fitness_app/features/food/presentation/cubit/food_cubit.dart';
import 'package:fitness_app/features/food/presentation/widgets/meals_grid.dart';
import 'package:fitness_app/features/food/presentation/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key, required this.categories});
  final List<Category> categories;

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  @override
  void initState() {
    super.initState();
    context.read<FoodCubit>().fetchMeals(widget.categories.first.name);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppBar().preferredSize.height + 64.h),
        DefaultTabController(
          length: widget.categories.length,
          child: TabBar(
            isScrollable: true,
            tabs:
                widget.categories
                    .map((category) => TabItem(title: category.name))
                    .toList(),
            indicator: BoxDecoration(
              color: AppColors.primaryOrange,
              borderRadius: BorderRadius.circular(20.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            labelPadding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            tabAlignment: TabAlignment.start,

            onTap: (value) {
              context.read<FoodCubit>().fetchMeals(
                widget.categories[value].name,
              );
            },
          ),
        ),

        R.spaceH12,
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.67,
          child: DefaultTabController(
            length: widget.categories.length,
            child: MealsGrid(realMeals: context.watch<FoodCubit>().realMeals),
          ),
        ),
        // R.spaceH60,
      ],
    );
  }
}
