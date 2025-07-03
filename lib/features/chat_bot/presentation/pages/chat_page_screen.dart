import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/core/generated/assets.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/chat_bot/presentation/bloc/chat_bloc.dart';
import 'package:fitness_app/features/chat_bot/presentation/widgets/chat_drawer.dart';
import 'package:fitness_app/features/chat_bot/presentation/widgets/chat_screen.dart';
import 'package:fitness_app/features/chat_bot/presentation/widgets/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ChatWithCoachScreen extends StatelessWidget {
  final bool showAppBar;

  const ChatWithCoachScreen({
    super.key,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      endDrawer: BlocProvider.value(
        value: context.read<ChatBloc>(),
        child: ChatDrawer(),
      ),
      appBar: showAppBar
          ? AppBar(
              title: Text(context.l10n.smartCoachTitle),
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: SvgPicture.asset(Assets.iconsBackIcon, height: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                Builder(
                  builder: (context) => IconButton(
                    icon: SvgPicture.asset(Assets.iconsMenuIcon, height: 30.h),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ),
              ],
            )
          : null,
      // drawer: ,
      body: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.imagesChatRectangle),
            fit: BoxFit.fill,
          ),
        ),
        child: ChatPage(
          chatBloc: context.read<ChatBloc>(),
        ),
      ),
    );
  }
}
