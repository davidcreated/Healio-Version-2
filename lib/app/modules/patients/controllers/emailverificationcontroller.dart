import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:healio_version_2/Screens/PatientSection/signup/signup2.dart';

class EmailVerifiedController extends GetxController {
  // Loading state for navigation
  var isNavigating = false.obs;
  
  // Animation controller for success animation
  var showContent = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Trigger content animation after a small delay
    Future.delayed(const Duration(milliseconds: 300), () {
      showContent.value = true;
    });
  }
  
  /// Navigate to sign in page
  void navigateToSignIn() async {
    try {
      isNavigating.value = true;
      
      // Add a small delay for better UX
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Navigate to sign in page and clear all previous routes
      // Use named route
      // Or if using direct navigation:
       Get.offAll(() => const PatientProfileCompletionPage());
      
    } catch (e) {
      // Handle navigation error
      Get.snackbar(
        'Error',
        'Failed to navigate. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isNavigating.value = false;
    }
  }
  
  /// Show celebration animation (optional)
  void showCelebration() {
    Get.snackbar(
      'Success!',
      'Your email has been verified successfully',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF007F67),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }
}