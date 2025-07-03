import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogout;
  final VoidCallback onCancel;
  final ProfileBloc profileBloc;
  const LogoutDialog({
    super.key,
    required this.onLogout,
    required this.onCancel,
    required this.profileBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Container(
        width: context.width * 0.8,
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.surfaceDark,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.logout, size: 48.r, color: AppColors.primaryOrange),
            R.spaceH16,
            Text(
              context.l10n.logout_confirmation_title,
              style: context.textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            R.spaceH12,
            Text(
              context.l10n.logout_message_body,
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            R.spaceH20,
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel,
                    child: Text(context.l10n.cancel),
                  ),
                ),
                R.spaceW12,
                Expanded(
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    bloc: profileBloc,
                    builder: (context, state) {
                      final isLoading = state.logoutState?.whenOrNull(
                            loading: () => true,
                          ) ??
                          false;
                      return ElevatedButton(
                        onPressed: isLoading ? null : onLogout,
                        child: isLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: const CircularProgressIndicator(),
                              )
                            : Text(context.l10n.logout),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
