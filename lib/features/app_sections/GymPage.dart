import 'package:flutter/material.dart';

class GymPage extends StatefulWidget {
  const GymPage({super.key});

  @override
  State<GymPage> createState() => _GymPageState();
}

class _GymPageState extends State<GymPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Gym Page",
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}
