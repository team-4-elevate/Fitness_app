import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/update_password/domain/enums/update_password_ui_fields.dart';
import 'package:fitness_app/features/update_password/presentation/bloc/update_password_bloc.dart';
import 'package:fitness_app/features/update_password/presentation/bloc/update_password_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordForm extends StatelessWidget {
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  const UpdatePasswordForm(
      {super.key,
      required this.oldPasswordController,
      required this.newPasswordController,
      required this.confirmPasswordController});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UpdatePasswordBloc>();
    final state = bloc.state;
    return Column(
      children: [
        SizedBox(height: 16.r),
        TextFormField(
          controller: oldPasswordController,
          obscureText: !state.isOldPasswordVisible,
          decoration: InputDecoration(
            prefixIcon: const Icon(size: 20, Icons.lock_outline),
            hintText: context.l10n.current_password,
            errorText: state.oldPasswordError,
            suffixIcon: IconButton(
              icon: Icon(
                state.isOldPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
              ),
              onPressed: () {
                bloc.add(
                    TogglePassVisibilityEvent(type: UpdatePassUiType.oldPass));
              },
            ),
          ),
        ),
        SizedBox(height: 16.r),
        TextFormField(
          controller: newPasswordController,
          obscureText: !state.isNewPasswordVisible,
          decoration: InputDecoration(
            prefixIcon: const Icon(size: 20, Icons.lock_outline),
            hintText: context.l10n.new_password,
            errorText: state.newPasswordError,
            suffixIcon: IconButton(
              icon: Icon(
                state.isNewPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
              ),
              onPressed: () {
                bloc.add(
                    TogglePassVisibilityEvent(type: UpdatePassUiType.newPass));
              },
            ),
          ),
        ),
        SizedBox(height: 16.r),
        TextFormField(
          controller: confirmPasswordController,
          obscureText: !state.isConfirmPasswordVisible,
          decoration: InputDecoration(
            prefixIcon: const Icon(size: 20, Icons.lock_outline),
            hintText: context.l10n.confirm_new_password,
            errorText: state.confirmPasswordError,
            suffixIcon: IconButton(
              icon: Icon(
                state.isConfirmPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
              ),
              onPressed: () {
                bloc.add(TogglePassVisibilityEvent(
                    type: UpdatePassUiType.confirmPass));
              },
            ),
          ),
          onChanged: (value) {
            bloc.add(ValidateConfirmPasswordEvent(
              confirmPassword: value,
              newPassword: newPasswordController.text,
            ));
          },
        ),
      ]);
  }
}
