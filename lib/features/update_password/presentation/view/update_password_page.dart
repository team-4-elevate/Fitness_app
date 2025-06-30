import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/auth/domain/arguments/auth_pages_ui_arguments.dart';
import 'package:fitness_app/features/auth/presentation/auth_common_widgets/custom_auth_view.dart';
import 'package:fitness_app/features/update_password/presentation/bloc/update_password_bloc.dart';
import 'package:fitness_app/features/update_password/presentation/bloc/update_password_event.dart';
import 'package:fitness_app/features/update_password/presentation/bloc/update_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordPage extends StatefulWidget {
  final String email;
  const UpdatePasswordPage({super.key, required this.email});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  late final TextEditingController _oldPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  late final UpdatePasswordBloc _bloc;

  @override
  void initState() {
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _bloc = context.read<UpdatePasswordBloc>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAuthScreensView(
      args: AuthPagesUiArguments(
        firstTitleArguments: const AuthPageTitleArguments(
          isBold: false,
          text: 'Enter your current password',
        ),
        secondTitleArguments: const AuthPageTitleArguments(
          isBold: true,
          text: 'Update Password',
        ),
        isRegister: false,
        primaryButtonText: 'Update Password',
        primaryButtonAction: () {
          _bloc.add(
            UpdatePasswordSubmitEvent(
              email: widget.email,
              oldPassword: _oldPasswordController.text.trim(),
              newPassword: _newPasswordController.text.trim(),
            ),
          );
        },
        content: BlocConsumer<UpdatePasswordBloc, UpdatePasswordState>(
          listenWhen: (p, c) {
            if (c.updatePasswordStatus.isLoading &&
                !p.updatePasswordStatus.isLoading) {
              context.showLoading();
            }
            if (!c.updatePasswordStatus.isLoading &&
                p.updatePasswordStatus.isLoading) {
              context.hideLoading();
            }
            return c.updatePasswordStatus.isSuccess ||
                c.updatePasswordStatus.isError;
          },
          listener: (context, state) {
            final isSuccess = state.updatePasswordStatus.isSuccess;
            context.showSnackBar(isSuccess
                ? 'Password updated successfully'
                : state.errorMessage);
            if (isSuccess && mounted) Navigator.pop(context);
          },
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(height: 16.r),
                TextFormField(
                  controller: _oldPasswordController,
                  obscureText: !state.isOldPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(size: 20, Icons.lock_outline),
                    hintText: 'Current Password',
                    errorText: state.oldPasswordError,
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isOldPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                      ),
                      onPressed: () {
                        _bloc.add(ToggleOldPasswordVisibilityEvent());
                      },
                    ),
                  ),
                  onChanged: (value) {
                    _bloc.add(ValidateOldPasswordEvent(value));
                  },
                ),
                SizedBox(height: 16.r),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: !state.isNewPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(size: 20, Icons.lock_outline),
                    hintText: 'New Password',
                    errorText: state.newPasswordError,
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isNewPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                      ),
                      onPressed: () {
                        _bloc.add(ToggleNewPasswordVisibilityEvent());
                      },
                    ),
                  ),
                  onChanged: (value) {
                    _bloc.add(ValidateNewPasswordEvent(value));
                    if (_confirmPasswordController.text.isNotEmpty) {
                      _bloc.add(ValidateConfirmPasswordEvent(
                        confirmPassword: _confirmPasswordController.text,
                        newPassword: value,
                      ));
                    }
                  },
                ),
                SizedBox(height: 16.r),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !state.isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(size: 20, Icons.lock_outline),
                    hintText: 'Confirm New Password',
                    errorText: state.confirmPasswordError,
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isConfirmPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                      ),
                      onPressed: () {
                        _bloc.add(ToggleConfirmPasswordVisibilityEvent());
                      },
                    ),
                  ),
                  onChanged: (value) {
                    _bloc.add(ValidateConfirmPasswordEvent(
                      confirmPassword: value,
                      newPassword: _newPasswordController.text,
                    ));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
