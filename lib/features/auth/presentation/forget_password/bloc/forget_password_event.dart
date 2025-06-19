import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();
}

class ForgetPasswordSubmitEvent extends ForgetPasswordEvent {
  final String email;
  final GlobalKey<FormState>? formKey;

  const ForgetPasswordSubmitEvent(this.email, {this.formKey});

  @override
  List<Object> get props => [email];
}

class VerifyResetCodeEvent extends ForgetPasswordEvent {
  final String code;

  const VerifyResetCodeEvent(this.code);

  @override
  List<Object> get props => [code];
}

class ResetPasswordEvent extends ForgetPasswordEvent {
  final String newPassword;

  const ResetPasswordEvent({required this.newPassword});

  @override
  List<Object> get props => [newPassword];
}

class ResendOtpEvent extends ForgetPasswordEvent {
  final String email;

  const ResendOtpEvent({required this.email});

  @override
  List<Object> get props => [email];
}
