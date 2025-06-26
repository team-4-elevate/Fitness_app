import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/Constant/app_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/theme/app_font_style.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/food_details/presentation/cubit/food_details_cubit.dart';
import 'package:fitness_app/features/food_details/presentation/widgets/nutrition_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HeaderDetailsWidget extends StatelessWidget {
  const HeaderDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FoodDetailsCubit>();

    return Container(
      height: MediaQuery.of(context).size.height * 0.42,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(cubit.state.meal?.coverUrl ??
              'https://fileinfo.com/img/ss/xl/jpeg_43-2.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 600,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black.withOpacity(0),
                    AppColors.surfaceDark,
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            top: 32,
            start: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                AppConstants.backIconSVG,
                height: 48.h,
                width: 48.w,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cubit.state.meal?.title ?? '',
                  style: AppFontStyle.customAppFont.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  cubit.state.meal?.description ?? '',
                  style: AppFontStyle.customAppFont.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                const NutritionInfoWidget()
              ],
            ),
          )
        ],
      ),
    );
  }
}
