import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/widgets/blurred_container.dart';
import 'package:fitness_app/features/chat_bot/presentation/bloc/chat_bloc.dart';
import 'package:fitness_app/features/chat_bot/presentation/widgets/conversations_drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDrawer extends StatefulWidget {
  const ChatDrawer({super.key});

  @override
  State<ChatDrawer> createState() => _ChatDrawerState();
}

class _ChatDrawerState extends State<ChatDrawer> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadAllConversations());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: BlurredContainer(
        padding: const EdgeInsets.all(16.0),
        backgroundBlur: 10,
        backgroundColor: AppColors.backgroundDark.withOpacity(0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.drawerTitle,
                  style: context.textTheme.titleLarge,
                ).expanded,
                IconButton(
                  icon: const Icon(Icons.edit_square, color: AppColors.white),
                  onPressed: () {
                    context.read<ChatBloc>().add(StartChatPressed());
                    Scaffold.of(context).closeEndDrawer();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  final conversationsState = state.conversationsState;

                  return conversationsState.when(
                    initial: () => const SizedBox(),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (msg) => Center(
                      child: Text(
                        msg!,
                        style: TextStyle(color: AppColors.error),
                      ),
                    ),
                    success: (conversations) {
                      if (conversations == null || conversations.isEmpty) {
                        return Center(
                          child: Text(
                            context.l10n.noConversations,
                            style: const TextStyle(
                              color: AppColors.secondaryOrange,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: conversations.length,
                        itemBuilder: (context, index) {
                          final conversation = conversations[index];
                          return ConversationsDrawerItem(
                            id: conversation.id,
                            title: conversation.title,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
