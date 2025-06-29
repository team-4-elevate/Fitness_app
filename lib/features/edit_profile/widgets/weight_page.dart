// features/edit_profile/widgets/weight_page.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/auth/presentation/register/widget/number_picker_step.dart';
import 'package:flutter/material.dart';

class WeightPage extends StatefulWidget {
  final int initialWeight;
  final Function(int)? onWeightChanged;

  const WeightPage({
    super.key,
    required this.initialWeight,
    this.onWeightChanged,
  });

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  late int _selectedWeight;

  @override
  void initState() {
    super.initState();
    _selectedWeight = widget.initialWeight;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "WHAT IS YOUR WEIGHT?",
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
              fontSize: 20.r,
            ),
          ),
          SizedBox(height: 8.r),
          Text(
            "This helps us create your personalized plan",
            style: TextStyle(
              color: AppColors.white.withOpacity(0.8),
              fontSize: 14.r,
            ),
          ),
          SizedBox(height: 10.r),
          NumberPickerStep(
            minValue: 10,
            maxValue: 300,
            label: "Kg",
            onChanged: (value) {
              setState(() {
                _selectedWeight = value;
              });
              if (widget.onWeightChanged != null) {
                widget.onWeightChanged!(value);
              }
            },
            value: _selectedWeight,
            itemCount: 6,
            itemWidth: 60.r,
          ),
          SizedBox(height: 20.r),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _selectedWeight);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
