import 'package:fitness_app/core/app_data/app_bloc.dart';
import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/core/generated/assets.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/chat_bot/presentation/bloc/chat_bloc.dart';
import 'package:fitness_app/features/chat_bot/presentation/widgets/chat_drawer.dart';
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
        endDrawer: BlocProvider.value(
          value: context.read<ChatBloc>(),
          child: ChatDrawer(),
        ),
        appBar: AppBar(
          title: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state.uiState is SuccessState) {
                return Text(context.l10n.smartCoachTitle);
              } else {
                return Column(
                  children: [
                    Text(
                      '${context.l10n.smartCoachGreeting}${context.read<AppBloc>().state.cachedUserData?.firstName},',
                      style: context.textTheme.titleSmall?.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      context.l10n.smartCoachAppBarDesc,
                      style: context.textTheme.titleMedium,
                    ),
                  ],
                );
              }
            },
          ),
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
                icon: SvgPicture.asset(Assets.iconsMenuIcon, height: 30),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imagesChatRectangle),
              fit: BoxFit.fill,
            ),
          ),
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state.uiState is InitialState) {
                return WelcomePage(
                  chatBloc: context.read<ChatBloc>(),
                ).paddingOnly(bottom: 80.h);
              } else {
                return ChatPage(
                  chatBloc: context.read<ChatBloc>(),
                ).paddingOnly(bottom: 100.h);
              }
            },
          ),
        ));
  }
}
