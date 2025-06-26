import 'dart:developer';
import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/routes/app_routes.dart';
import '../../../../../../core/utils/app_validator.dart';
import '../../../../domain/arguments/auth_pages_ui_arguments.dart';
import '../../../auth_common_widgets/custom_auth_view.dart';
import '../../bloc/forget_password_event.dart';
import '../../bloc/forget_password_bloc.dart';
import '../../bloc/forget_password_state.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final ForgetPasswordBloc _bloc;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _bloc = context.read<ForgetPasswordBloc>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAuthScreensView(
      args: AuthPagesUiArguments(
        firstTitleArguments: AuthPageTitleArguments(
          isBold: false,
          text: 'Enter your Email',
        ),
        secondTitleArguments: const AuthPageTitleArguments(
          isBold: true,
          text: 'Forget Password',
        ),
        isRegister: false,
        primaryButtonText: 'Send OTP',
        primaryButtonAction: () {
          log('message primary acation called ${(DateTime.now()).toString()}');
          _bloc.add(
            ForgetPasswordSubmitEvent(
              _emailController.text.trim(),
              formKey: _formKey,
            ),
          );
        },
        content: BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
          listenWhen: (p, c) {
            _handleLoading(p, c, context);
            return c.forgetPasswordStatus.isSuccess ||
                c.forgetPasswordStatus.isError;
          },
          listener: (context, state) => state.forgetPasswordStatus.isSuccess
              ? Navigator.of(
                  context,
                ).pushNamed(AppRoutes.forgetPassOtpPage, arguments: _bloc)
              : context.showSnackBar(state.errorMessage),
          child: Form(
            key: _formKey,
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(size: 20, Icons.email_outlined),
                hintText: context.l10n.email,
              ),
              validator: AppValidators.validateEmail,
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
    if (c.forgetPasswordStatus.isLoading && !p.forgetPasswordStatus.isLoading) {
      context.showLoading();
    }
    if (!c.forgetPasswordStatus.isLoading && p.forgetPasswordStatus.isLoading) {
      context.hideLoading();
    }
  }
}
