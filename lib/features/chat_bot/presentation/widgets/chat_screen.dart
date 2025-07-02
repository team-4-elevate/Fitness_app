import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/chat_bot/presentation/bloc/chat_bloc.dart';
import 'package:fitness_app/features/chat_bot/presentation/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController userMessageController = TextEditingController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    userMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state.messageState is SuccessState) {
          _scrollToBottom();
        }
      },
      builder: (context, state) {
        final messages = state.messages ?? [];

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: context.topPadding),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                physics: const BouncingScrollPhysics(),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];

                  return MessageWidget(
                    isUser: message.isUser,
                    message: message.message ?? '',
                    date: DateFormat(
                      'HH:mm',
                    ).format(message.date ?? DateTime.now()),
                    type: message.type,
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 16,
                    child: TextFormField(
                      controller: userMessageController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hint: Text(context.l10n.smartCoachHintTxt),
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsets.all(12),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        AppColors.primaryOrange,
                      ),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(const CircleBorder()),
                    ),
                    onPressed:
                        state.messageState is LoadingState
                            ? null
                            : () {
                              final message = userMessageController.text.trim();
                              if (message.isNotEmpty) {
                                context.read<ChatBloc>().add(
                                  SendUserMessage(message),
                                );
                                userMessageController.clear();
                              }
                            },
                    iconSize: 30,
                    icon: const Icon(
                      Icons.send,
                      key: ValueKey("send"),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
