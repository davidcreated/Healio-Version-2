import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/Screens/Generalonboarding/welcomepage2.dart';
import 'package:healio_version_2/app/routes/approutes.dart';
import 'package:healio_version_2/core/constants/appcolors.dart';
import 'package:healio_version_2/core/constants/appsizes.dart';
import 'package:healio_version_2/core/constants/apptextstyles.dart';

/// GetX Controller for WelcomePage1
/// Manages navigation logic and user interactions for the first onboarding screen
class WelcomePage1Controller extends GetxController {
  
  // NAVIGATION METHODS - Clean separation of navigation logic

  /// Navigate to the next onboarding page (WelcomePage2)
  /// Uses Get.to() to maintain navigation stack for back navigation
  void navigateToNextPage() {
    Get.to(() => const WelcomePage2());
  }

  /// Navigate to WelcomePage2 via dot indicator tap
  /// Same functionality as next page but specifically for dot interaction
  void navigateToPage2() {
    Get.to(() => const WelcomePage2());
  }

  /// Skip onboarding and go directly to main app
  /// Uses Get.offAllNamed() to clear navigation stack and prevent back navigation
  void skipOnboarding() {
    Get.offAllNamed(AppRoutes.splashPage3);
  }

  /// Handle back navigation if needed (for future use)
  void goBack() {
    if (Get.global(null).currentState?.canPop() ?? false) {
      Get.back();
    }
  }

  // ANALYTICS AND TRACKING (for future implementation)
  
  /// Track user interaction with skip button
  void trackSkipAction() {
    // TODO: Add analytics tracking
    print('User skipped onboarding from page 1');
  }

  /// Track user interaction with next/arrow button
  void trackNextAction() {
    // TODO: Add analytics tracking
    print('User proceeded to next onboarding page');
  }

  /// Track user interaction with dot indicators
  void trackDotInteraction(int pageNumber) {
    // TODO: Add analytics tracking
    print('User tapped on dot indicator for page $pageNumber');
  }

  /// Handle skip with tracking
  void handleSkip() {
    trackSkipAction();
    skipOnboarding();
  }

  /// Handle next page navigation with tracking
  void handleNext() {
    trackNextAction();
    navigateToNextPage();
  }

  /// Handle dot tap with tracking
  void handleDotTap() {
    trackDotInteraction(2);
    navigateToPage2();
  }
}

/// First Onboarding Page - Clean UI focused widget
/// This page introduces users to the app and allows them to proceed or skip onboarding
class WelcomePage1 extends StatelessWidget {
  const WelcomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller with GetX dependency injection
    return GetBuilder<WelcomePage1Controller>(
      init: WelcomePage1Controller(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              _buildBackgroundImage(context),
              _buildForegroundContent(controller),
            ],
          ),
        );
      },
    );
  }

  /// Background image that covers the entire screen
  /// Uses Positioned.fill for better performance and proper scaling
  Widget _buildBackgroundImage(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        'lib/assets/images/onboarding/Onboarding 1.png', // Fixed path (removed extra slash)
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
        // Add error handling for missing images
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppColors.primaryAccent,
            child: const Center(
              child: Icon(
                Icons.image_not_supported,
                size: 50,
                color: Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }

  /// Foreground content with navigation controls
  /// Positioned at the bottom of the screen
  Widget _buildForegroundContent(WelcomePage1Controller controller) {
    return Column(
      children: [
        const Spacer(), // Push content to bottom
        _buildNavigationControls(controller),
      ],
    );
  }

  /// Navigation controls section (skip, dots, arrow)
  /// Contains all user interaction elements
  Widget _buildNavigationControls(WelcomePage1Controller controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.welcomePagePaddingHorizontal,
        vertical: AppSizes.welcomePagePaddingVertical,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSkipButton(controller),
          _buildPageIndicators(controller),
          _buildArrowButton(controller),
        ],
      ),
    );
  }

  /// Skip button - allows users to bypass onboarding
  /// Styled as text button with custom styling from constants
  Widget _buildSkipButton(WelcomePage1Controller controller) {
    return GestureDetector(
      onTap: controller.handleSkip,
      // Add feedback for better user experience
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: const Text(
          'Skip',
          style: AppTextStyles.welcomePageSkipTextStyle,
        ),
      ),
    );
  }

  /// Page indicators (dots) showing current page and allowing navigation
  /// Active dot represents current page, inactive dot can be tapped to navigate
  Widget _buildPageIndicators(WelcomePage1Controller controller) {
    return Row(
      children: [
        // Active dot (page 1 - current page)
        _buildActiveDot(),
        const SizedBox(width: AppSizes.welcomePageDotSpacing),
        // Inactive dot (page 2 - can tap to navigate)
        _buildInactiveDot(controller),
      ],
    );
  }

  /// Active dot indicator for current page
  /// Larger and uses active color to show current position
  Widget _buildActiveDot() {
    return Container(
      width: AppSizes.welcomePageDotWidthActive,
      height: AppSizes.welcomePageDotHeight,
      decoration: BoxDecoration(
        color: AppColors.welcomePageActiveDotColor,
        borderRadius: BorderRadius.circular(AppSizes.welcomePageDotBorderRadius),
        // Add subtle shadow for better visual hierarchy
        boxShadow: [
          BoxShadow(
            color: AppColors.welcomePageActiveDotColor.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }

  /// Inactive dot indicator for next page
  /// Smaller and uses inactive color, tappable to navigate
  Widget _buildInactiveDot(WelcomePage1Controller controller) {
    return GestureDetector(
      onTap: controller.handleDotTap,
      child: Container(
        width: AppSizes.welcomePageDotWidthInactive,
        height: AppSizes.welcomePageDotHeight,
        decoration: BoxDecoration(
          color: AppColors.welcomePageInactiveDotColor,
          borderRadius: BorderRadius.circular(AppSizes.welcomePageDotBorderRadius),
          // Add border for better visibility
          border: Border.all(
            color: AppColors.welcomePageActiveDotColor.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
    );
  }

  /// Arrow button for proceeding to next page
  /// Circular button with forward arrow icon
  Widget _buildArrowButton(WelcomePage1Controller controller) {
    return GestureDetector(
      onTap: controller.handleNext,
      child: Container(
        width: AppSizes.welcomePageArrowButtonSize,
        height: AppSizes.welcomePageArrowButtonSize,
        decoration: BoxDecoration(
          color: AppColors.welcomePageActiveDotColor,
          borderRadius: BorderRadius.circular(AppSizes.welcomePageArrowButtonBorderRadius),
          // Add elevation for better Material Design compliance
          boxShadow: [
            BoxShadow(
              color: AppColors.welcomePageActiveDotColor.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
          size: 24, // Explicit size for consistency
        ),
      ),
    );
  }
}
