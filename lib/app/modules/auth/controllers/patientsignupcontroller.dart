import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/routes/approutes.dart';
import 'package:healio_version_2/core/constants/appdurations.dart';/// Enhanced ChooseSignupController for proper role-based navigation
/// This controller manages the state and behavior of the signup screen
class PatientSignupController extends GetxController
    with GetSingleTickerProviderStateMixin {
  
  // ====== REACTIVE STATE VARIABLES ======
  // This variable holds the currently selected role and automatically updates the UI when changed
  final _selectedRole = Role.none.obs;
  
  // Getter method to access the selected role from outside the controller
  Role get selectedRole => _selectedRole.value;
  
  // ====== ANIMATION CONTROLLERS ======
  // These control the slide and fade animations for the bottom panel
  late final AnimationController animationController;
  late final Animation<Offset> slideAnimation;   // Controls sliding from bottom
  late final Animation<double> fadeAnimation;    // Controls fade-in effect

  // ====== CONTROLLER LIFECYCLE METHODS ======
  @override
  void onInit() {
    super.onInit();
    // Initialize animations when the controller is created
    _initializeAnimations();
  }

  /// Initialize slide and fade animations for the bottom panel
  /// This creates smooth animations when the screen loads
  void _initializeAnimations() {
    // Create the main animation controller with specified duration
    animationController = AnimationController(
      duration: AppDurations.chooseSignupSlideAnimationDuration,
      vsync: this, // 'this' refers to the mixin that provides animation ticker
    );

    // Create slide animation that moves panel from bottom to normal position
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from bottom (off-screen)
      end: Offset.zero,          // End at normal position (on-screen)
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutQuart, // Smooth easing curve
    ));

    // Create fade animation that fades content in during slide
    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        AppDurations.chooseSignupFadeAnimationIntervalStart,
        AppDurations.chooseSignupFadeAnimationIntervalEnd,
        curve: Curves.easeOut,
      ),
    );

    // Start the animation immediately when controller initializes
    animationController.forward();
  }

  // ====== USER INTERACTION METHODS ======
  
  /// Update selected role and trigger reactive UI update
  /// This method is called when user taps on Doctor or Patient button
  void selectRole(Role role) {
    print('Role selected: $role'); // Debug print for development
    _selectedRole.value = role;
    // Note: The UI will automatically update because we're using .obs (observable)
  }

  /// Handle continue button - validates selection and navigates accordingly
  /// This is the main action when user wants to proceed with their selection
  void handleContinue() {
    // STEP 1: Validate that user has selected a role
    if (selectedRole == Role.none) {
      _showSelectionRequiredSnackbar();
      return; // Exit early if no role selected
    }

    // STEP 2: Navigate based on selected role
    switch (selectedRole) {
      case Role.doctor:
        // Navigate to doctor signup page
        // TODO: Uncomment when doctor signup route is ready
        Get.offAllNamed(AppRoutes.doctorSignUp);
        _showSuccessSnackbar('Doctor Selected', 'Redirecting to doctor registration...');
        break;
        
      case Role.patient:
        // Navigate to patient signup page
        Get.offAllNamed(AppRoutes.SignUp);
        _showSuccessSnackbar('Patient Selected', 'Redirecting to patient registration...');
        break;
        
      case Role.none:
        // This case is already handled above, but included for completeness
        break;
    }
  }

  /// Navigate back to previous screen
  /// Simple method to go back when user taps back button
  void goBack() {
    Get.back();
  }

  // ====== HELPER METHODS FOR USER FEEDBACK ======
  
  /// Show error when no role is selected
  /// This provides user feedback when they try to continue without selecting a role
  void _showSelectionRequiredSnackbar() {
    Get.snackbar(
      'Selection Required', // Title of the snackbar
      'Please select whether you are a Doctor or Patient before continuing.', // Message
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange.shade600,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
    );
  }

  /// Show success message when role is selected
  /// This provides positive feedback when user successfully selects a role
  void _showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,   // Dynamic title based on selection
      message, // Dynamic message based on selection
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  // ====== HELPER METHOD FOR DYNAMIC BACKGROUND IMAGE ======
  
  /// Get the appropriate background image path based on selected role
  /// This method returns the correct image path depending on what role is selected
  String getBackgroundImagePath() {
    switch (selectedRole) {
      case Role.doctor:
        return 'lib/assets/images/patient/signup.png';    // Doctor background
      case Role.patient:
        return 'lib/assets/images/patient/patient.png';   // Patient background
      case Role.none:
        return 'lib/assets/images/patient/signup.png';    // Default background
    }
  }

  // ====== CLEANUP METHODS ======
  @override
  void onClose() {
    // Clean up animation controller to prevent memory leaks
    animationController.dispose();
    super.onClose();
  }
}

/// Role enum definition
/// This enum defines the possible roles a user can select
enum Role { 
  none,    // No role selected (initial state)
  doctor,  // Medical professional
  patient  // Regular patient/user
}
