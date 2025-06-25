import 'package:fitness_app/core/Constant/app_constants.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/exercise/presentation/view/widgets/header/gradient_blur_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../domain/arguments/exercise_page_arguments.dart';
import 'exercise_page_header_body.dart';
import 'exercise_page_header_description.dart';

class ExercisePageHeaderWidget extends StatelessWidget {
  final ExercisePageArguments arguments;
  const ExercisePageHeaderWidget({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.45,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppConstants.exerciseHeaderBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '${arguments.muscleGroupName} ${context.l10n.exercise}',
                      style: textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ExercisePageBlurWidget(
                    child: Column(
                      children: [
                        ExercisePageHeaderDescription(textTheme: textTheme),
                        ExercisePageHeaderBody(arguments: arguments),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              left: 16,
              top: MediaQuery.paddingOf(context).top + 16,
              child: IconButton(
              onPressed: () => Navigator.pop(context),
                icon: SizedBox(
                  height: 30,
                    width: 30,
                  child: ClipOval(
                    child: ColoredBox(
                      color: AppColors.primaryOrange,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(AppConstants.appBackBtn,fit: BoxFit.cover),
                      ))))))])
    );
  }
}
