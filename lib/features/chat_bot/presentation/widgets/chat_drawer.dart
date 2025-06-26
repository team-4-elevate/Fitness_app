import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/widgets/blurred_container.dart';
import 'package:fitness_app/features/chat_bot/domain/entity/conversations_entity.dart';
import 'package:fitness_app/features/chat_bot/presentation/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDrawer extends StatelessWidget {
  const ChatDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger loading conversations when the drawer is opened
    context.read<ChatBloc>().add(LoadAllConversations());

    return Drawer(
      backgroundColor: Colors.transparent,
      child: BlurredContainer(
        padding: const EdgeInsets.all(16.0),
        backgroundBlur: 10,
        backgroundColor: AppColors.backgroundDark.withValues(alpha: .8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Previous Conversations',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_square, color: AppColors.white),
                  onPressed: () {
                    Scaffold.of(context).closeEndDrawer();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 1,
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ChatError) {
                    return Center(child: Text(state.error));
                  }
                  if (state is ConversationsLoaded) {
                    final conversations = state.conversations;
                    if (conversations.isEmpty) {
                      return const Center(
                        child: Text('No conversations found'),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: conversations.length,
                      itemBuilder: (context, index) {
                        final conversation = conversations[index];
                        return ConversationsItem(
                          id: conversation.id,
                          title: conversation.title,
                          onTap: () {
                            context.read<ChatBloc>().add(
                              LoadConversation(conversation.id),
                            );
                            Scaffold.of(context).closeEndDrawer();
                          },
                        );
                      },
                    );
                  }
                  return const Center(child: Text('No conversations loaded'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConversationsItem extends StatelessWidget {
  final String? id;
  final String? title;
  final VoidCallback? onTap;

  const ConversationsItem({super.key, this.id, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryOrange,
          ),
          title: Text(
            title ?? '',
            style: const TextStyle(color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: onTap,
        ),
        Divider(
          color: Color(0xFF2D2D2D),
          height: 1,
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }
}
