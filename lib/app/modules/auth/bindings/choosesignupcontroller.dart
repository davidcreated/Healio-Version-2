/// GetX Controller to manage the state and business logic
/// This separates UI from business logic following MVVM pattern
/// import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ✅ Added GetX
import 'package:flutter/material.dart';
import 'package:healio_version_2/Screens/PatientSection/signup/signup.dart';
import 'package:healio_version_2/core/constants/appdurations.dart';

enum Role { none, doctor, patient }
class ChooseSignupController extends GetxController
    with GetSingleTickerProviderStateMixin {
  
  // Reactive variables - these will automatically update the UI when changed
  final _selectedRole = Role.none.obs;
  Role get selectedRole => _selectedRole.value;
  
  // Animation controller and animations
  late final AnimationController animationController;
  late final Animation<Offset> slideAnimation;
  late final Animation<double> fadeAnimation;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
  }

  /// Initialize all animations in one place for better organization
  void _initializeAnimations() {
    animationController = AnimationController(
      duration: AppDurations.chooseSignupSlideAnimationDuration,
      vsync: this,
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from bottom
      end: Offset.zero, // End at normal position
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutQuart, // Smooth bounce-like curve
    ));

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        AppDurations.chooseSignupFadeAnimationIntervalStart,
        AppDurations.chooseSignupFadeAnimationIntervalEnd,
        curve: Curves.easeOut,
      ),
    );

    // Start the animation when controller initializes
    animationController.forward();
  }

  /// Update selected role and trigger reactive UI update
  void selectRole(Role role) {
    _selectedRole.value = role;
  }

  /// Handle continue button press with proper validation and navigation
  void handleContinue() {
    // Validate selection first
    if (selectedRole == Role.none) {
      _showSelectionRequiredSnackbar();
      return;
    }

    // Navigate based on selected role
    final destination = _getDestinationWidget();
    if (destination != null) {
      _navigateToSignup(destination);
    }
  }

  /// Show error snackbar when no role is selected
  void _showSelectionRequiredSnackbar() {
    Get.snackbar(
      'Selection Required',
      'Please select a role before continuing.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 500),
    );
  }

  /// Get the appropriate destination widget based on selected role
  Widget? _getDestinationWidget() {
     switch (selectedRole) {
       case Role.doctor:
       return const PatientSignupPage();
      case Role.patient:
        return const PatientSignupPage();
       case Role.none:
         return null;
     }
   }

  /// Navigate to signup page with smooth transition
  void _navigateToSignup(Widget destination) {
    Get.to(
      () => destination,
      transition: Transition.fadeIn,
      duration: AppDurations.chooseSignupPageTransitionDuration,
      curve: Curves.easeInOut,
    );
  }

  /// Navigate back to previous screen
  void goBack() {
    Get.back();
  }

  @override
  void onClose() {
    // Clean up animation controller to prevent memory leaks
    animationController.dispose();
    super.onClose();
  }
}
