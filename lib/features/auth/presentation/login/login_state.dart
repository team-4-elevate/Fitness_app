import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/login_response.dart';

class LoginState extends Equatable {
  final AppStates<LoginResponse>? loginState;
  final bool navigateToResetPassword;
  final bool navigateToSignUp;
  final bool navigateToHome;
  final bool showSocialLoginMessage;
  final String? emailError;
  final String? passwordError;
  final bool isFormValid;

  const LoginState({
    this.loginState,
    this.navigateToResetPassword = false,
    this.navigateToSignUp = false,
    this.navigateToHome = false,
    this.showSocialLoginMessage = false,
    this.emailError,
    this.passwordError,
    this.isFormValid = false,
  });

  LoginState copyWith({
    AppStates<LoginResponse>? loginState,
    bool? navigateToResetPassword,
    bool? navigateToSignUp,
    bool? navigateToHome,
    bool? showSocialLoginMessage,
    String? emailError,
    String? passwordError,
    bool? isFormValid,
    bool clearEmailError = false,
    bool clearPasswordError = false,
  }) {
    return LoginState(
      loginState: loginState ?? this.loginState,
      navigateToResetPassword:
          navigateToResetPassword ?? this.navigateToResetPassword,
      navigateToSignUp: navigateToSignUp ?? this.navigateToSignUp,
      navigateToHome: navigateToHome ?? this.navigateToHome,
      showSocialLoginMessage:
          showSocialLoginMessage ?? this.showSocialLoginMessage,
      emailError: clearEmailError ? null : (emailError ?? this.emailError),
      passwordError:
          clearPasswordError ? null : (passwordError ?? this.passwordError),
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  @override
  List<Object?> get props => [
        loginState,
        navigateToResetPassword,
        navigateToSignUp,
        navigateToHome,
        showSocialLoginMessage,
        emailError,
        passwordError,
        isFormValid,
      ];
}
