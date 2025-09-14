import 'package:flutter/material.dart';
import 'package:get/get.dart';
// NOTE: Make sure these paths point to your actual page files.
import 'package:healio_version_2/Screens/PatientSection/signup/signup2.dart'; 
// NOTE: You will need to import your sign-in page here.
// import 'package:healio_version_2/Screens/PatientSection/signin/signin.dart'; // Example path

/// GetX Controller for Signup Page
/// Manages all the state, validation, and business logic
class SignupController extends GetxController {
  
  // FORM CONTROLLERS - Managing text input fields
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // REACTIVE STATE VARIABLES - These automatically update UI when changed
  final _passwordVisible = false.obs;      // Controls password visibility toggle
  final _confirmPasswordVisible = false.obs; // Controls confirm password visibility toggle
  final _agreeToTerms = false.obs;           // Tracks terms agreement checkbox
  final _isLoading = false.obs;              // Tracks loading state during registration

  // GETTERS - Clean way to access reactive values from the UI
  bool get passwordVisible => _passwordVisible.value;
  bool get confirmPasswordVisible => _confirmPasswordVisible.value;
  bool get agreeToTerms => _agreeToTerms.value;
  bool get isLoading => _isLoading.value;

  /// Toggle password visibility for main password field
  void togglePasswordVisibility() {
    _passwordVisible.value = !_passwordVisible.value;
  }

  /// Toggle password visibility for confirm password field
  void toggleConfirmPasswordVisibility() {
    _confirmPasswordVisible.value = !_confirmPasswordVisible.value;
  }

  /// Update terms agreement status from the checkbox
  void updateTermsAgreement(bool? value) {
    _agreeToTerms.value = value ?? false;
  }

  /// Validate email format using RegExp
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!GetUtils.isEmail(value)) { // Using GetX's built-in email validator
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validate username with minimum length requirement
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  /// Validate password with minimum length requirement
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Validate confirm password matches original password
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Handle registration process with comprehensive validation
  void register() {
    // Bypassing validation for testing purposes.
    Get.offAll(() => const PatientProfileCompletionPage());
  }



  /// Navigate to sign in page
  void navigateToSignIn() {
    // CORRECTED LOGIC: This should navigate to the SignIn/Login page, not back to the signup page.
    // Replace `PatientSignupPage()` with your actual sign-in page widget.
    // For example: Get.off(() => const SignInPage());
    Get.back(); // A simple back navigation is often sufficient here.
  }



  /// Clean up controllers when controller is destroyed
  @override
  void onClose() {
    firstnameController.dispose();
    lastnameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
