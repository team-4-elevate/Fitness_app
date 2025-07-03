// features/home/presentation/widgets/user_info.dart
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  final String? userName;
  final String? profileImagePath;
  const UserInfo({
    super.key,
    this.userName,
    this.profileImagePath,
  });

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  void initState() {
    super.initState();
    //  var
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //------------------------------------------ Username text
            Text(
              'Hi ${widget.userName ?? 'User'},',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              AppLocalizations.of(context).let_s_start_your_day,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        //------------------------------------------ Profile picture
        Container(
          width: 50.r,
          height: 50.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1),
            image: DecorationImage(
              image: widget.profileImagePath != null &&
                      widget.profileImagePath!.isNotEmpty
                  ? NetworkImage(widget.profileImagePath ?? '') as ImageProvider
                  : const AssetImage('assets/images/onboarding_vector_1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
