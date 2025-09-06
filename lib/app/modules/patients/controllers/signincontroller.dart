import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/patienthomepage.dart';
// NOTE: Make sure these paths point to your actual page files.
import 'package:healio_version_2/Screens/PatientSection/signup/signup2.dart'; 
// NOTE: You will need to import your sign-up page here.
// import 'package:healio_version_2/Screens/PatientSection/signup/signup.dart'; // Example path
// NOTE: You will need to import your home/dashboard page here.
// import 'package:healio_version_2/Screens/PatientSection/home/home.dart'; // Example path

/// GetX Controller for Sign In Page
/// Manages all the state, validation, and business logic for user authentication
class SignInController extends GetxController {
  
  // FORM CONTROLLERS - Managing text input fields for sign in
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // REACTIVE STATE VARIABLES - These automatically update UI when changed
  final _passwordVisible = false.obs;      // Controls password visibility toggle
  final _isLoading = false.obs;            // Tracks loading state during sign in
  final _rememberMe = false.obs;           // Tracks remember me checkbox (optional)

  // GETTERS - Clean way to access reactive values from the UI
  bool get passwordVisible => _passwordVisible.value;
  bool get isLoading => _isLoading.value;
  bool get rememberMe => _rememberMe.value;

  /// Toggle password visibility for password field
  void togglePasswordVisibility() {
    _passwordVisible.value = !_passwordVisible.value;
  }

  /// Update remember me status from checkbox (optional feature)
  void updateRememberMe(bool? value) {
    _rememberMe.value = value ?? false;
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

  /// Validate password with minimum length requirement
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Handle sign in process with comprehensive validation
  Future<void> signIn() async {
    // First validate the form
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Set loading state
    _isLoading.value = true;

    try {
      // TODO: Implement your actual authentication logic here
      // Example: Call your authentication service
      // final result = await AuthService.signIn(
      //   email: emailController.text.trim(),
      //   password: passwordController.text,
      // );

      // Simulate network delay for demonstration
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Handle successful authentication
      // For now, navigate to home page or dashboard
      // Replace this with your actual home page navigation
      Get.offAll(() => const HomePage()); // Temporary - replace with your home page
      
      // Show success message
      Get.snackbar(
        'Success',
        'Welcome back! You have signed in successfully.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

    } catch (error) {
      // Handle authentication errors
      Get.snackbar(
        'Sign In Failed',
        'Invalid email or password. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      // Reset loading state
      _isLoading.value = false;
    }
  }

  /// Handle forgot password functionality
  Future<void> forgotPassword() async {
    final email = emailController.text.trim();
    
    if (email.isEmpty) {
      Get.snackbar(
        'Email Required',
        'Please enter your email address first',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Invalid Email',
        'Please enter a valid email address',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    try {
      // TODO: Implement your forgot password logic here
      // Example: await AuthService.sendPasswordResetEmail(email);
      
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      Get.snackbar(
        'Reset Link Sent',
        'Password reset instructions have been sent to your email.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );

    } catch (error) {
      Get.snackbar(
        'Error',
        'Failed to send reset email. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    }
  }

  /// Navigate to sign up page
  void navigateToSignUp() {
    // TODO: Replace with your actual sign up page
    // Get.to(() => const PatientSignupPage());
    Get.back(); // Temporary navigation - replace with actual sign up page
  }

  /// Navigate back to previous page
  void goBack() {
    Get.back();
  }

  /// Clear all form fields
  void clearForm() {
    emailController.clear();
    passwordController.clear();
    _passwordVisible.value = false;
    _rememberMe.value = false;
  }

  /// Auto-fill demo credentials (for testing purposes - remove in production)
  void fillDemoCredentials() {
    emailController.text = 'demo@healio.com';
    passwordController.text = 'password123';
  }

  /// Clean up controllers when controller is destroyed
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}