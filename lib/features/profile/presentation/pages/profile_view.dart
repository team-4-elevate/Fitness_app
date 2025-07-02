import 'package:fitness_app/core/Constant/app_constants.dart';
import 'package:fitness_app/core/app_data/app_bloc.dart';
import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/services/localization_manager.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/widgets/app_network_image.dart';
import 'package:fitness_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:fitness_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:fitness_app/features/profile/presentation/bloc/profile_navigation.dart';
import 'package:fitness_app/features/profile/presentation/widgets/logout_dialog.dart';
import 'package:fitness_app/features/profile/presentation/widgets/profile_custom_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var userData = context.watch<AppBloc>().state.cachedUserData;
    var profileBloc = context.read<ProfileBloc>();
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) {
        return previous.navigationState != current.navigationState &&
            current.navigationState != null;
      },
      listener: (context, state) {
        profileBloc.add(ResetNavigationEvent());
        switch (state.navigationState) {
          case ToEditProfile():
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Scaffold(
                body: Center(
                  child: Text('edit profile page content goes here'),
                ),
              )),
            );
            break;
          case ToUpdatePassword():
            Navigator.pushNamed(context, AppRoutes.updatePasswordPage);
            break;
          case ToLoginAfterLogout():
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.loginPage,
              (route) => false,
            );
            break;
          case null:
            break;
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppConstants.profileCustomBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(context.l10n.profile_title),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppConstants.customBackIcon),
            ),
          ),
          body: Column(
            children: [
              AppNetworkImage(
                networkImage: userData?.photo ?? '',
                height: 100.h,
                width: 100.w,
                borderRadius: BorderRadius.circular(100.r),
              ),
              SizedBox(height: R.spaceMD),
              Text(
                '${userData?.firstName ?? ''} ${userData?.lastName ?? ''}',
                style: context.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: R.paddingMDValue,
                  vertical: R.paddingLGValue,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: R.paddingSMValue,
                  vertical: R.paddingSMValue,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark.withOpacity(.8),
                  borderRadius: BorderRadius.circular(R.borderLG),
                ),
                child: Column(
                  children: [
                    ProfileCustomRow(
                      title: context.l10n.edit_profile,
                      icon: Icons.person,
                      onTap: () => profileBloc.add(EditProfileTappedEvent()),
                    ),
                    ProfileCustomRow(
                      title: context.l10n.change_password,
                      icon: Icons.change_circle_outlined,
                      // isIConOrSwitch: false,
                      onTap: () => profileBloc.add(ChangePasswordTappedEvent()),
                    ),
                    ProfileCustomRow(
                      title: context.l10n.selectedLanguageValue(
                        context.read<LocalizationManager>().isEnglish
                            ? 'English'
                            : 'العربيه',
                      ),
                      icon: Icons.language_outlined,
                      isToggleSwitch: true,
                      initialToggleValue:
                          context.read<LocalizationManager>().isEnglish,
                      onToggleChanged: (lang) async {
                        profileBloc.add(ChangeLanguageTappedEvent());
                      },
                    ),
                    ProfileCustomRow(
                      title: context.l10n.settings,
                      icon: Icons.settings,
                    ),
                    ProfileCustomRow(
                      title: context.l10n.privacy,
                      icon: Icons.privacy_tip_outlined,
                    ),
                    ProfileCustomRow(
                      title: context.l10n.help,
                      icon: Icons.help_center_outlined,
                    ),
                    ProfileCustomRow(
                      title: context.l10n.logout,
                      icon: Icons.logout_outlined,
                      onTap: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (dialogContext) {
                            return LogoutDialog(
                              profileBloc: profileBloc,
                              onCancel: () {
                                Navigator.of(dialogContext).pop();
                              },
                              onLogout: () async {
                                profileBloc.add(
                                  LogoutTappedEvent(),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
