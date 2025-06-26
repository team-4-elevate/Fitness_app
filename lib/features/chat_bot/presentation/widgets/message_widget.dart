import 'package:fitness_app/core/generated/assets.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/chat_bot/presentation/widgets/typing_Indicator.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  const MessageWidget({
    super.key,
    required this.isUser,
    required this.message,
    required this.date,
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

    final messageBubble = Expanded(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: isUser ? 30 : 10,
          end: isUser ? 10 : 30,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              Text(message.trim(), style: context.textTheme.titleMedium),
              Text(
                date,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          isUser
              ? [messageBubble, avatar]
              : [
                avatar,
                message == 'Typing' ? TypingIndicator() : messageBubble,
              ],
    );
  }
}
