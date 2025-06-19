import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/utils/app_validator.dart';
import 'package:fitness_app/features/auth/presentation/forget_password/bloc/forget_password_event.dart';
import 'package:fitness_app/features/auth/presentation/forget_password/bloc/forget_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/routes/app_routes.dart';
import '../../../../domain/arguments/auth_pages_ui_arguments.dart';
import '../../../auth_common_widgets/custom_auth_view.dart';
import '../../bloc/forget_password_state.dart';

class CreateNewPasswordPage extends StatefulWidget {
  final ForgetPasswordBloc bloc;
  const CreateNewPasswordPage({super.key, required this.bloc});

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final ForgetPasswordBloc _bloc;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _bloc = context.read<ForgetPasswordBloc>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAuthScreensView(
      args: AuthPagesUiArguments(
        firstTitleArguments: const AuthPageTitleArguments(
          isBold: false,
          text: 'Make Sure Its 8 Characters Or More',
        ),
        secondTitleArguments: const AuthPageTitleArguments(
          isBold: true,
          text: 'Create New Password',
        ),
        isRegister: false,
        primaryButtonText: 'Done',
        primaryButtonAction: () {
          if (_formKey.currentState!.validate()) {
            _bloc.add(
              ResetPasswordEvent(newPassword: _passwordController.text.trim()),
            );
          }
        },
        content: BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
          listenWhen: (p, c) {
            _handleLoading(p, c, context);
            return c.resetPasswordStatus.isSuccess ||
                c.resetPasswordStatus.isError;
          },
          listener: (context, state) {
            final status = state.resetPasswordStatus;
            status.isError
                ? context.showSnackBar(state.errorMessage)
                : Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(AppRoutes.homePage, (route) => false);
          },
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(size: 20, Icons.lock_outline),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: AppValidators.validatePassword,
                ),
                SizedBox(height: 16.r),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(size: 20, Icons.lock_outline),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLoading(
    ForgetPasswordState p,
    ForgetPasswordState c,
    BuildContext context,
  ) {
    if (!c.resetPasswordStatus.isLoading && p.resetPasswordStatus.isLoading) {
      context.hideLoading();
    }
    if (c.resetPasswordStatus.isLoading) {
      context.showLoading();
    }
  }
}
