import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/auth/domain/arguments/auth_pages_ui_arguments.dart';
import 'package:fitness_app/features/auth/presentation/auth_common_widgets/custom_auth_view.dart';
import 'package:fitness_app/features/update_password/presentation/bloc/update_password_bloc.dart';
import 'package:fitness_app/features/update_password/presentation/bloc/update_password_event.dart';
import 'package:fitness_app/features/update_password/presentation/bloc/update_password_state.dart';
import 'package:fitness_app/features/update_password/presentation/view/widgets/update_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

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
        secondTitleArguments: AuthPageTitleArguments(
          isBold: false,
          text: context.l10n.enter_old_new_passwords,
        ),
        firstTitleArguments: AuthPageTitleArguments(
          isBold: true,
          text: context.l10n.update_password,
        ),
        isRegister: false,
        primaryButtonText: context.l10n.update_password,
        primaryButtonAction: () {
          _bloc.add(
            UpdatePasswordSubmitEvent(
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
            } else if (!c.updatePasswordStatus.isLoading &&
                p.updatePasswordStatus.isLoading) {
              context.hideLoading();
            }
            return c.updatePasswordStatus.isSuccess ||
                c.updatePasswordStatus.isError;
          },
          listener: (context, state) {
            final isSuccess = state.updatePasswordStatus.isSuccess;
            context.showSnackBar(isSuccess
                ? context.l10n.password_updated_successfully
                : state.errorMessage);
            if (isSuccess && mounted) Navigator.pop(context);
          },
          builder: (context, state) {
            return UpdatePasswordForm(
              oldPasswordController: _oldPasswordController,
              newPasswordController: _newPasswordController,
              confirmPasswordController: _confirmPasswordController,
            );
          },
        ),
      ),
    );
  }
}
