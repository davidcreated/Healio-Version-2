// Second Onboarding Page
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/routes/approutes.dart';
import 'package:healio_version_2/core/constants/appcolors.dart';
import 'package:healio_version_2/core/constants/appsizes.dart';
import 'package:healio_version_2/core/constants/apptextstyles.dart';

class WelcomePage2 extends StatelessWidget {
  const WelcomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.welcomePageBackgroundColor,
      body: Stack(
        children: [
          // Background image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'lib/assets/images/onboarding/Onboarding 2.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),

          // Foreground content
          Column(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.welcomePagePaddingHorizontal,
                  vertical: AppSizes.welcomePagePaddingVertical,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Skip button
                    GestureDetector(
                      onTap: () => Get.offAllNamed(AppRoutes.splashPage3),
                      child: const Text(
                        'Skip',
                        style: AppTextStyles.welcomePageSkipTextStyle,
                      ),
                    ),
  
                    // Page indicators
                    Row(
                      children: [
                        // Inactive dot (page 1)
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            width: AppSizes.welcomePageDotWidthInactive,
                            height: AppSizes.welcomePageDotHeight,
                            decoration: BoxDecoration(
                              color: AppColors.welcomePageInactiveDotColor,
                              borderRadius: BorderRadius.circular(AppSizes.welcomePageDotBorderRadius),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSizes.welcomePageDotSpacing),

                        // Active dot (page 2)
                        Container(
                          width: AppSizes.welcomePageDotWidthActive,
                          height: AppSizes.welcomePageDotHeight,
                          decoration: BoxDecoration(
                            color: AppColors.welcomePageActiveDotColor,
                            borderRadius: BorderRadius.circular(AppSizes.welcomePageDotBorderRadius),
                          ),
                        ),
                      ],
                    ),

                    // Arrow button to go to page 3
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.splashPage3),
                      child: Container(
                        width: AppSizes.welcomePageArrowButtonSize,
                        height: AppSizes.welcomePageArrowButtonSize,
                        decoration: BoxDecoration(
                          color: AppColors.welcomePageActiveDotColor,
                          borderRadius: BorderRadius.circular(AppSizes.welcomePageArrowButtonBorderRadius),
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}