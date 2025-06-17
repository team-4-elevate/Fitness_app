import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/onboarding/presentation/widgets/on_boarding_buttons.dart';
import 'package:fitness_app/features/onboarding/presentation/widgets/skip_widget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.index,
    required this.pageController,
  });

  final String imagePath;
  final String title;
  final String description;
  final int index;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        index != 2 ? SkipWidget() : SizedBox(height: 72.h),
        Expanded(
          child: Image.asset(
            key: ValueKey('on_boarding_image_$index'),
            imagePath,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          height: 272.h,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                key: Key('on_boarding_title_$index'),
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                key: Key('on_boarding_desc_$index'),
                description,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              SmoothPageIndicator(
                controller: pageController,
                count: 3,
                effect: const ExpandingDotsEffect(
                  spacing: 8.0,
                  radius: 20.0,
                  dotWidth: 8.0,
                  dotHeight: 8.0,
                  strokeWidth: 1.5,
                  dotColor: Colors.grey,
                  activeDotColor: Color(0xffFF4100),
                ),
                onDotClicked: (index) {
                  pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              const SizedBox(height: 20),
              OnboardingButtons(index: index, pageController: pageController),
            ],
          ),
        ),
      ],
    );
  }
}
