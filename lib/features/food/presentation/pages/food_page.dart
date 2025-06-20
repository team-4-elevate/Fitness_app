import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/generated/assets.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/food/data/models/category.dart';
import 'package:fitness_app/features/food/presentation/cubit/food_cubit.dart';

import 'package:fitness_app/features/food/presentation/widgets/food_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Food Recommendation',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(Assets.iconsCustomBack),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: AppSectionFake(),
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesFoodRectangle),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          BlocProvider(
            create: (context) => getIt<FoodCubit>(),
            child: FoodPageBody(
              categories: [
                Category(name: 'Beef', id: '1'),
                Category(name: 'Chicken', id: '2'),
                Category(name: 'Dessert', id: '3'),
                Category(name: 'Lamb', id: '4'),
                Category(name: 'Miscellaneous', id: '5'),
                Category(name: 'Pasta', id: '6'),
                Category(name: 'Pork', id: '7'),
                Category(name: 'Seafood', id: '8'),
                Category(name: 'Side', id: '9'),
                Category(name: 'Starter', id: '10'),
                Category(name: 'Vegan', id: '11'),
                Category(name: 'Vegetarian', id: '12'),
                Category(name: 'Breakfast', id: '13'),
                Category(name: 'Goat', id: '14'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppSectionFake extends StatelessWidget {
  const AppSectionFake({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      margin: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Color(0xff242424),
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(icon: Image.asset(Assets.iconsHome), onPressed: () {}),
          IconButton(icon: Image.asset(Assets.iconsChatAi), onPressed: () {}),
          IconButton(icon: Image.asset(Assets.iconsGym), onPressed: () {}),
          IconButton(icon: Image.asset(Assets.iconsProfile), onPressed: () {}),
        ],
      ),
    );
  }
}
