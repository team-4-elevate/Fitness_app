import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../../../../core/theme/app_colors.dart';

class OtpTextField extends StatelessWidget {
  final TextEditingController pinController ;
  const OtpTextField({super.key,required this.pinController});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      controller: pinController,
      length: 4,
      defaultPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: Theme.of(context).textTheme.headlineLarge!
            .copyWith(color: AppColors.primaryOrange),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color:
              pinController.text == ''
                  ? Colors.white
                  : AppColors.primaryOrange,
              width: 2,
            ),
          ),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: Theme.of(context).textTheme.headlineLarge!
            .copyWith(color: AppColors.primaryOrange),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.primaryOrange,
              width: 2,
            ),
          ),
        ),
      ),
      submittedPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: Theme.of(context).textTheme.headlineLarge!
            .copyWith(color: AppColors.primaryOrange),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.primaryOrange,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}