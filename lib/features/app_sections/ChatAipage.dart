import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/features/food_details/presentation/pages/food_details_page.dart';
import 'package:flutter/material.dart';

class ChatAipage extends StatefulWidget {
  const ChatAipage({super.key});

  @override
  State<ChatAipage> createState() => _ChatAipageState();
}

class _ChatAipageState extends State<ChatAipage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            AppRoutes.foodDetailsScreen,
            arguments: FoodDetailsArgs(
              mealID: '52959',
              meals: [],
            ),
          );
        },
        child: Text(
          "Home Page",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
