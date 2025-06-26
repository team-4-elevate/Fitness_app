import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../bloc/forget_password_bloc.dart';

class OtpFooterTextWidget extends StatelessWidget {
  final void Function() onResendCode;
  const OtpFooterTextWidget({super.key, required this.onResendCode});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Didn't Receive Verification Code?",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 30,
            child: TextButton(
              onPressed: onResendCode,
              child: Text(
                'Resend Code?',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryOrange,
                      decorationColor: AppColors.primaryOrange,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
