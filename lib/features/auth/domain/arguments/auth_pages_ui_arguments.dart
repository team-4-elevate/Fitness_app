// features/auth/domain/arguments/auth_pages_ui_arguments.dart
import 'package:flutter/material.dart';

class AuthPagesUiArguments {
  final AuthPageTitleArguments? firstTitleArguments;
  final AuthPageTitleArguments? secondTitleArguments;
  final bool isRegister;
  final int? registerStep;
  final Widget content;
  final bool showSocialLogin;
  final Widget? footerContent;
  final String? primaryButtonText;
  final VoidCallback? primaryButtonAction;

  const AuthPagesUiArguments({
    required this.firstTitleArguments,
    required this.secondTitleArguments,
    required this.isRegister,
    required this.content,
    this.registerStep,
    this.showSocialLogin = false,
    this.footerContent,
    this.primaryButtonText,
    this.primaryButtonAction,
  }) : assert(
          !isRegister || registerStep != null,
          'you should provide register step if isRegister is true',
        );
}

class AuthPageTitleArguments {
  final bool isBold;
  final String text;
  const AuthPageTitleArguments({required this.isBold, required this.text});
}
