import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/generated/assets.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/onboarding/presentation/widgets/page_view_item.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
  final AppSecureStorage localStorageClient = getIt<AppSecureStorage>();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    // Check if the user has already seen the onboarding
    // widget.localStorageClient.saveBool(LocalConstants.onBoardingKey, true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Image.asset(
                Assets.imagesOnboardingRectangle,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    allowImplicitScrolling: false,
                    controller: pageController,
                    children: [
                      PageViewItem(
                        index: 0,
                        pageController: pageController,
                        imagePath: Assets.imagesO151,
                        title: context.l10n.onBoardingTitle1,
                        description: context.l10n.onBoardingDesc1,
                      ),

                      PageViewItem(
                        index: 1,
                        pageController: pageController,
                        imagePath: Assets.imagesO152,
                        title: context.l10n.onBoardingTitle2,
                        description: context.l10n.onBoardingDesc2,
                      ),
                      PageViewItem(
                        index: 2,
                        pageController: pageController,
                        imagePath: Assets.imagesO153,
                        title: context.l10n.onBoardingTitle3,
                        description: context.l10n.onBoardingDesc3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
