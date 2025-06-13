import 'package:flutter/material.dart';

class AuthPagesUiArguments {
  final AuthPageTitleArguments? firstTitleArguments;
  final AuthPageTitleArguments? secondTitleArguments;
  final bool isRegister;
  final int? registerStep;
  final Widget content;

  const AuthPagesUiArguments({
    required this.firstTitleArguments,
    required this.secondTitleArguments,
    required this.isRegister,
    required this.content,
    this.registerStep,
  }) : assert(!isRegister || registerStep != null,
            'you should provide register step if isRegister is true');
}

class AuthPageTitleArguments {
  final bool isBold;
  final String text;
  const AuthPageTitleArguments({required this.isBold, required this.text});
}
