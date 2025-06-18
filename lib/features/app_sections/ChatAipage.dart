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
      child: Text(
        "Chat Ai Page ",
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}
