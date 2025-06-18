import 'package:fitness_app/core/helper/handle_cubit_states.dart';
import 'package:fitness_app/core/utils/app_validator.dart';
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

  String? emailError;
  String? passwordError;
  bool isFormValid = false;

  void loginIntent(LoginIntent intent) {
    switch (intent) {
      case LoginIntent.loginButtonPressed:
        if (_validateForm()) {
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

      case LoginIntent.validateEmail:
        _validateEmailOnly();
        break;

      case LoginIntent.validatePassword:
        _validatePasswordOnly();
        break;

      case LoginIntent.clearValidationErrors:
        _clearValidationErrors();
        break;

      case LoginIntent.resetStates:
        _resetStates();
        break;
    }
  }

  void _validateEmailOnly() {
    final email = emailController.text.trim();
    emailError = AppValidators.validateEmail(email);
    _updateValidationState();
  }

  void _validatePasswordOnly() {
    passwordError = AppValidators.validatePassword(passwordController.text);
    _updateValidationState();
  }

  bool _validateForm() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    emailError = AppValidators.validateEmail(email);
    passwordError = AppValidators.validatePassword(password);

    isFormValid = emailError == null && passwordError == null;

    emit(
      state.copyWith(
        emailError: emailError,
        passwordError: passwordError,
        isFormValid: isFormValid,
        clearEmailError: emailError == null,
        clearPasswordError: passwordError == null,
      ),
    );

    return isFormValid;
  }

  void _updateValidationState() {
    isFormValid = emailError == null && passwordError == null;
    emit(
      state.copyWith(
        emailError: emailError,
        passwordError: passwordError,
        isFormValid: isFormValid,
        clearEmailError: emailError == null,
        clearPasswordError: passwordError == null,
      ),
    );
  }

  void _clearValidationErrors() {
    emailError = null;
    passwordError = null;
    isFormValid = false;
    emit(
      state.copyWith(
        isFormValid: false,
        clearEmailError: true,
        clearPasswordError: true,
      ),
    );
  }

  void _resetStates() {
    emailController.clear();
    passwordController.clear();
    emailError = null;
    passwordError = null;
    isFormValid = false;
    emit(const LoginState());
  }

  Future<void> _doLogin() async {
    return await handleCubitStates(
      request:
          () => _loginUseCase.call(
            LoginRequest(
              email: emailController.text.trim(),
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

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    isPasswordVisible.dispose();
    return super.close();
  }
}
