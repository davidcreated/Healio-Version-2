// SEPARATE FILE: lib/src/utils/navigation_helper.dart
// ==============================================================================
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Helper class for navigation with GetX
class NavigationHelper {
  /// Navigate to a page with slide transition
  static void navigateWithSlideTransition(Widget page) {
    Get.to(
      () => page,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }

  /// Navigate and replace current page
  static void navigateAndReplace(Widget page) {
    Get.off(() => page);
  }

  /// Navigate and clear all previous routes
  static void navigateAndClearAll(Widget page) {
    Get.offAll(() => page);
  }

  /// Go back to previous page
  static void goBack() {
    Get.back();
  }
}
