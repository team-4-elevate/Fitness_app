import 'package:fitness_app/core/helper/handle_cubit_states.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_request/login_request.dart';
import 'package:fitness_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:fitness_app/features/auth/presentation/login/login_intent.dart';
import 'package:fitness_app/features/auth/presentation/login/login_state.dart';
import 'package:flutter/widgets.dart'
    show FormState, GlobalKey, TextEditingController, ValueNotifier;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  LoginViewModel(this._loginUseCase) : super(const LoginState());
  final LoginUseCase _loginUseCase;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(true);

  void loginIntent(LoginIntent intent) {
    switch (intent) {
      case LoginIntent.loginButtonPressed:
        if (formKey.currentState?.validate() ?? false) {
          _doLogin();
        }
        break;

      case LoginIntent.forgotPasswordButtonPressed:
        emit(state.copyWith(navigateToResetPassword: true));
        break;

      case LoginIntent.socialLoginButtonPressed:
        emit(state.copyWith(showSocialLoginMessage: true));
        break;

      case LoginIntent.registerButtonPressed:
        emit(state.copyWith(navigateToSignUp: true));
        break;

      case LoginIntent.changePasswordVisibility:
        _changePasswordVisibility();
        break;
    }
  }

  Future<void> _doLogin() async {
    return await handleCubitStates(
      request:
          () => _loginUseCase.call(
            LoginRequest(
              email: emailController.text,
              password: passwordController.text,
            ),
          ),
      emit: (newState) {
        emit(state.copyWith(loginState: newState));
      },
    );
  }

  void _changePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void resetStates() {
    emit(const LoginState());
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    isPasswordVisible.dispose();
    return super.close();
  }
}
