import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  const TabItem({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.r,
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
