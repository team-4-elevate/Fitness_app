import 'package:fitness_app/core/generated/assets.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/onboarding/presentation/widgets/page_view_item.dart';
import 'package:flutter/material.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.imagesOnboardingRectangle),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: PageView(
              allowImplicitScrolling: false,
              controller: pageController,
              children: [
                PageViewItem(
                  key: ValueKey('firstPageKey'),
                  index: 0,
                  pageController: pageController,
                  imagePath: Assets.imagesOnboardingVector1,
                  title: context.l10n.onBoardingTitle1,
                  description: context.l10n.onBoardingDesc1,
                ),
                // SkipWidget(),
                PageViewItem(
                  key: ValueKey('secondPageKey'),
                  index: 1,
                  pageController: pageController,
                  imagePath: Assets.imagesOnboardingVector2,
                  title: context.l10n.onBoardingTitle2,
                  description: context.l10n.onBoardingDesc2,
                ),
                PageViewItem(
                  key: ValueKey('thirdPageKey'),
                  index: 2,
                  pageController: pageController,
                  imagePath: Assets.imagesOnboardingVector3,
                  title: context.l10n.onBoardingTitle3,
                  description: context.l10n.onBoardingDesc3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
