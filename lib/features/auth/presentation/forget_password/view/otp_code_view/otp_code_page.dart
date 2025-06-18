import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/auth/presentation/forget_password/bloc/forget_password_bloc.dart';
import 'package:fitness_app/features/auth/presentation/forget_password/view/otp_code_view/widgets/otp_text_footer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/arguments/auth_pages_ui_arguments.dart';
import '../../../auth_common_widgets/custom_auth_view.dart';
import '../../bloc/forget_password_event.dart';
import '../../bloc/forget_password_state.dart';

class ForgetPassOtpCodePage extends StatefulWidget {
  final ForgetPasswordBloc bloc;

  const ForgetPassOtpCodePage({super.key, required this.bloc});

  @override
  State<ForgetPassOtpCodePage> createState() => _ForgetPassOtpCodePage();
}

class _ForgetPassOtpCodePage extends State<ForgetPassOtpCodePage> {
  late final TextEditingController _pinController;
  late final ForgetPasswordBloc _bloc;

  @override
  void initState() {
    _pinController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _bloc = widget.bloc;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAuthScreensView(
      args: AuthPagesUiArguments(
        firstTitleArguments: const AuthPageTitleArguments(
          isBold: true,
          text: 'OTP CODE',
        ),
        secondTitleArguments: const AuthPageTitleArguments(
          isBold: false,
          text: 'Enter Your OTP Check Your Email',
        ),
        isRegister: false,
        primaryButtonText: 'Confirm',
        footerContent: OtpFooterTextWidget(
          onResendCode: () => _bloc.add(VerifyResetCodeEvent('2222')),
        ),
        primaryButtonAction: () {

          _bloc.add(VerifyResetCodeEvent(_pinController.text));
        },
        content: BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
          listenWhen: (p, c) {
            _handleLoading(p, c, context);
            return c.verifyResetCodeStatus.isSuccess ||
                c.verifyResetCodeStatus.isError;
          },
          listener:
              (context, state) =>
                  state.verifyResetCodeStatus.isError
                      ? context.showSnackBar(state.errorMessage)
                      : Navigator.of(context).pushNamed(
                        AppRoutes.createNewPasswordPage,
                        arguments: _bloc,
                      ),
          child: Container(height: 100, width: 100, color: Colors.red),
          // child: OtpTextField(pinController: _pinController),
        ),
      ),
    );
  }

  void _handleLoading(
    ForgetPasswordState p,
    ForgetPasswordState c,
    BuildContext context,
  ) {
    // if (!c.verifyResetCodeStatus.isLoading &&
    //     p.verifyResetCodeStatus.isLoading) {
    //   log('hide loading');
    //
    //   context.hideLoading();
    //   // return;k
    // }
    if (c.verifyResetCodeStatus.isLoading && !p.verifyResetCodeStatus.isLoading) {
      context.showLoading();
    }
    if (!c.verifyResetCodeStatus.isLoading && p.verifyResetCodeStatus.isLoading) {
      context.hideLoading();
    }
  }
}
