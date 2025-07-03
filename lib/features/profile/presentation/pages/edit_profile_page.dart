import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('edit profile page content goes here'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle save action
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
