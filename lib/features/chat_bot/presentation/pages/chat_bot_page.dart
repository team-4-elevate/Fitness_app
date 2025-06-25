import 'package:fitness_app/core/generated/assets.dart';
import 'package:fitness_app/features/chat_bot/presentation/bloc/chat_bloc.dart';
import 'package:fitness_app/features/chat_bot/presentation/widgets/chat_screen.dart';
import 'package:fitness_app/features/chat_bot/presentation/widgets/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _BotScreenState();
}

class _BotScreenState extends State<ChatBotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        title: const Text('Smart coach'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(Assets.iconsBackIcon, height: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(Assets.iconsMenuIcon, height: 30),
            onPressed: () {
              // Handle AI chat icon action
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.imagesChatRectangle),
            fit: BoxFit.fill,
          ),
        ),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatWelcome) {
              return WelcomePage();
            } else {
              return ChatPage();
            }
          },
        ),
      ),
    );
  }
}
