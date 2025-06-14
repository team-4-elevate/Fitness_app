import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class CustomOutlinedBtn extends StatelessWidget {
  const CustomOutlinedBtn({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final void Function() onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Color(0xffFF6A00), width: 1),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.sp),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
