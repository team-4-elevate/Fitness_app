import 'dart:ui';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/home/home.dart';
import 'package:fitness_app/features/onboarding/presentation/widgets/custom_elevated_btn.dart';
import 'package:fitness_app/features/onboarding/presentation/widgets/custom_outlined_btn.dart';
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
    return Stack(
      children: [
        index != 2
            ? PositionedDirectional(
              top: 50,
              end: 10,
              child: TextButton(
                onPressed: () {
                  context.pushAndRemoveUntil(Home());
                },
                child: Text(
                  context.l10n.skip,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            )
            : SizedBox(),
        Positioned(
          top: 100,
          left: 0,
          right: 0,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                // height: 300,
                constraints: BoxConstraints(minHeight: 250),
                alignment: Alignment.center,

                color: Colors.black.withValues(alpha: 0.3),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                    SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
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
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    index == 0
                        ? SizedBox(
                          width: double.infinity,
                          child: CustomElevatedBtn(
                            onPressed: () {
                              pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            text: context.l10n.next,
                          ),
                        )
                        : index == 1
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 70,

                              child: CustomOutlinedBtn(
                                onPressed: () {
                                  pageController.previousPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                text: context.l10n.back,
                              ),
                            ),
                            SizedBox(
                              width: 70,
                              child: CustomElevatedBtn(
                                onPressed: () {
                                  pageController.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                text: context.l10n.next,
                              ),
                            ),
                          ],
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 70,
                              child: CustomOutlinedBtn(
                                onPressed: () {
                                  pageController.previousPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                text: context.l10n.back,
                              ),
                            ),
                            SizedBox(
                              width: 70,
                              child: CustomElevatedBtn(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/login',
                                  );
                                },
                                text: context.l10n.doIt,
                              ),
                            ),
                          ],
                        ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
