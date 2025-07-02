// features/home/presentation/widgets/user_info.dart
import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({
    super.key,
  });

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final AppSecureStorage _secureStorage = GetIt.instance<AppSecureStorage>();
  String? _userName;
  String? _profileImageUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final firstName = await _secureStorage.getUserData('firstName');
      final photo = await _secureStorage.getUserData('photo');
      
      debugPrint('Loaded user data: firstName=$firstName, photo=$photo');
      
      if (mounted) {
        setState(() {
          _userName = firstName;
          _profileImageUrl = photo;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
              'Hi ${_userName ?? 'User'},',
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
              image: _profileImageUrl != null && _profileImageUrl!.isNotEmpty
                ? NetworkImage(_profileImageUrl!) as ImageProvider
                : const AssetImage('assets/images/onboarding_vector_1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
  }

