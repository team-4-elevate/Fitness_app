// features/auth/presentation/register/widget/number_picker_step.dart
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberPickerStep extends StatelessWidget {
  final String label;
  final int value;
  final int minValue;
  final int maxValue;
  final int itemCount;
  final Function(int) onChanged;
  final double itemWidth;

  const NumberPickerStep({
    super.key,
    required this.label,
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    this.itemCount = 9,
    this.itemWidth = 35.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 20.r),

          Text(
            label,
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 14.r,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8.r),

          NumberPicker(
            value: value,
            minValue: minValue,
            maxValue: maxValue,
            step: 1,
            haptics: true,
            itemCount: itemCount,
            infiniteLoop: false,
            textStyle: TextStyle(color: Colors.white, fontSize: 14.r),
            selectedTextStyle: TextStyle(
              color: Colors.deepOrange,
              fontSize: 30.r,
              fontWeight: FontWeight.bold,
            ),
            textMapper: (numberText) => numberText,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
            ),
            onChanged: onChanged,
            axis: Axis.horizontal,
            itemWidth: itemWidth.r,
          ),

          Icon(Icons.arrow_drop_up, color: Colors.deepOrange, size: 24.r),
        ],
      ),
    );
  }
}
