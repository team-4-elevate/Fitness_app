// features/edit_profile/pages/profile.dart
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.editProfile);
              },
              child: Text("EditProfile"))
        ],
      )),
    );
  }
}
