import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class GridViewCustomWidget extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  const GridViewCustomWidget({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: R.paddingMDValue),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            R.gridColumns, // Number of columns in the grid by The Device Type
        childAspectRatio: 1.11,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
      ),
      itemBuilder: itemBuilder,
      itemCount: itemCount,
    );
  }
}
