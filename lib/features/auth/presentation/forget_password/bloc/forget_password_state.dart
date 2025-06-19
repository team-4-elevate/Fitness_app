import 'dart:developer';
import 'package:equatable/equatable.dart';

import '../../../../../core/app_manger/bloc_handler_mixin.dart';

class ForgetPasswordState extends Equatable {
  final Status forgetPasswordStatus;

  final Status resetPasswordStatus;
  final Status verifyResetCodeStatus;
  final String userEmail;
  final bool? shouldVerify;
  final String errorMessage;
  const ForgetPasswordState({
    this.forgetPasswordStatus = Status.initial,
    this.verifyResetCodeStatus = Status.initial,
    this.resetPasswordStatus = Status.initial,
    this.userEmail = '',
    this.errorMessage = '',
    this.shouldVerify = false,
  });

  ForgetPasswordState copyWith({
    Status? forgetPasswordStatus,
    Status? verifyOtpStatus,
    Status? resetPasswordStatus,
    String? errorMessage,
    bool? shouldVerify,
    String? userEmail,
  }) {
    log('copy with + ${forgetPasswordStatus.toString()}');
    log('copy with + ${verifyOtpStatus.toString()}');
    log('copy with + ${userEmail.toString()}');
    return ForgetPasswordState(
      userEmail: userEmail ?? this.userEmail,
      errorMessage: errorMessage ?? '',
      shouldVerify: shouldVerify,
      forgetPasswordStatus: forgetPasswordStatus ?? this.forgetPasswordStatus,
      verifyResetCodeStatus: verifyOtpStatus ?? this.verifyResetCodeStatus,
      resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
    );
  }

  @override
  List get props => [
    userEmail,
    errorMessage,
    shouldVerify,
    forgetPasswordStatus,
    verifyResetCodeStatus,
    resetPasswordStatus,
  ];
}
