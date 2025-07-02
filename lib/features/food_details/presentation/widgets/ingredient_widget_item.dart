import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/theme/app_font_style.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/food_details/domain/entities/ingredient_entity.dart';
import 'package:flutter/material.dart';

class IngredientWidgetItem extends StatelessWidget {
  final IngredientEntity ingredientItem;
  const IngredientWidgetItem({
    super.key,
    required this.ingredientItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                ingredientItem.title,
                style: AppFontStyle.customAppFont.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              ingredientItem.value,
              style: AppFontStyle.customAppFont.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryOrange,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Divider(
          color: Color(0xff2D2D2D),
          thickness: 1,
          height: 0,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
