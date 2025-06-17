import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/login_response.dart';

class LoginState extends Equatable {
  final AppStates<LoginResponse>? loginState;
  final bool navigateToResetPassword;
  final bool navigateToSignUp;
  final bool navigateToHome;
  final bool showSocialLoginMessage;

  const LoginState({
    this.loginState,
    this.navigateToResetPassword = false,
    this.navigateToSignUp = false,
    this.navigateToHome = false,
    this.showSocialLoginMessage = false,
  });

  LoginState copyWith({
    AppStates<LoginResponse>? loginState,
    bool? navigateToResetPassword,
    bool? navigateToSignUp,
    bool? navigateToHome,
    bool? showSocialLoginMessage,
  }) {
    return LoginState(
      loginState: loginState ?? this.loginState,
      navigateToResetPassword: navigateToResetPassword ?? false,
      navigateToSignUp: navigateToSignUp ?? false,
      navigateToHome: navigateToHome ?? false,
      showSocialLoginMessage: showSocialLoginMessage ?? false,
    );
  }

  @override
  List<Object?> get props => [
    loginState,
    navigateToResetPassword,
    navigateToSignUp,
    navigateToHome,
    showSocialLoginMessage,
  ];
}
