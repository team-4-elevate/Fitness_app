import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/chat_bot/presentation/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationsDrawerItem extends StatelessWidget {
  final String id;
  final String? title;

  const ConversationsDrawerItem({super.key, required this.id, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          horizontalTitleGap: 0,
          leading: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryOrange,
          ),
          title: Text(
            title ?? '',
            style: const TextStyle(color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
          trailing: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.delete, color: AppColors.primaryOrange),
            onPressed: () {
              context.read<ChatBloc>().add(DeleteConversation(id));
            },
          ),
          contentPadding: EdgeInsets.zero,
          onTap: () {
            context.read<ChatBloc>().add(SelectConversation(id));
            Scaffold.of(context).closeEndDrawer();
          },
        ),
        Divider(
          color: Color(0xFF2D2D2D),
          height: 1,
          thickness: 1,
          indent: 8,
          endIndent: 8,
        ),
      ],
    );
  }
}
