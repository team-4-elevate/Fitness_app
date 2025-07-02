import 'package:fitness_app/core/generated/assets.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/chat_bot/domain/entity/message_entity.dart';
import 'package:fitness_app/features/chat_bot/presentation/widgets/typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageWidget extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  final MessageType type;

  const MessageWidget({
    super.key,
    required this.isUser,
    required this.message,
    required this.date,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      backgroundColor: AppColors.backgroundDark,
      backgroundImage:
          isUser
              ? Image.network(
                'https://mir-s3-cdn-cf.behance.net/user/276/6f4f341119178147.66e08d23e23a4.png',
              ).image
              : Image.asset(Assets.imagesBotEllipse).image,
      radius: 20.r,
    );

    Widget messageContent() {
      switch (type) {
        case MessageType.typing:
          return const TypingIndicator();
        case MessageType.error:
          return Text(
            message,
            style: context.textTheme.titleMedium?.copyWith(
              color: AppColors.error,
            ),
          );
        case MessageType.normal:
          return isUser
              ? Text(message.trim(), style: context.textTheme.titleMedium)
              : MarkdownBody(
                data: message.trim(),
                selectable: true,
                styleSheet: MarkdownStyleSheet.fromTheme(
                  Theme.of(context),
                ).copyWith(
                  p: context.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
                  h1: context.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                  ),
                  codeblockDecoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  code: context.textTheme.bodyMedium?.copyWith(
                    fontFamily: 'monospace',
                    color: Colors.cyanAccent,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              );
      }
    }

    final messageBubble = Flexible(
      fit: FlexFit.loose,
      child: Padding(
        padding: EdgeInsetsDirectional.all(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color:
                isUser
                    ? AppColors.primaryOrange.withAlpha(120)
                    : AppColors.backgroundDark.withAlpha(120),
            borderRadius: BorderRadiusDirectional.only(
              topStart: isUser ? const Radius.circular(30) : Radius.zero,
              bottomStart: const Radius.circular(30),
              topEnd: isUser ? Radius.zero : const Radius.circular(30),
              bottomEnd: const Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              messageContent(),
              if (type == MessageType.normal) ...[
                const SizedBox(height: 4),
                Text(
                  date,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );

    return Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          isUser
              ? [messageBubble, const SizedBox(width: 8), avatar]
              : [avatar, const SizedBox(width: 8), messageBubble],
    );
  }
}
