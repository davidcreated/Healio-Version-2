import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoctorSignupController extends GetxController {
  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text controllers
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Reactive variables
  final RxBool _passwordVisible = false.obs;
  final RxBool _confirmPasswordVisible = false.obs;
  final RxBool _agreeToTerms = false.obs;
  final RxBool _isLoading = false.obs;

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Getters for reactive variables
  bool get passwordVisible => _passwordVisible.value;
  bool get confirmPasswordVisible => _confirmPasswordVisible.value;
  bool get agreeToTerms => _agreeToTerms.value;
  bool get isLoading => _isLoading.value;

  @override
  void onClose() {
    // Dispose controllers when controller is destroyed
    firstnameController.dispose();
    lastnameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    _passwordVisible.value = !_passwordVisible.value;
  }

  // Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    _confirmPasswordVisible.value = !_confirmPasswordVisible.value;
  }

  // Update terms agreement
  void updateTermsAgreement(bool? value) {
    _agreeToTerms.value = value ?? false;
  }

  // Validation methods
  String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your first name';
    }
    if (value.trim().length < 2) {
      return 'First name must be at least 2 characters';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your last name';
    }
    if (value.trim().length < 2) {
      return 'Last name must be at least 2 characters';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a username';
    }
    if (value.trim().length < 3) {
      return 'Username must be at least 3 characters';
    }
    if (value.contains(' ')) {
      return 'Username cannot contain spaces';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    
    // Remove spaces and special characters for validation
    String cleanedPhone = value.replaceAll(RegExp(r'[^\d+]'), '');
    
    if (cleanedPhone.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain uppercase, lowercase and number';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Main registration method - Only proceeds if validation passes
  Future<void> register() async {
    // Validate form first - if validation fails, don't proceed
    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        'Validation Error',
        'Please fill in all required fields correctly',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade100,
        colorText: Colors.orange.shade800,
        duration: const Duration(seconds: 3),
      );
      return; // Stop here if validation fails
    }

    // Check if terms are agreed to
    if (!agreeToTerms) {
      Get.snackbar(
        'Terms Required',
        'Please accept the Terms of Service and Privacy Policy to continue',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        duration: const Duration(seconds: 3),
      );
      return; // Stop here if terms not agreed
    }

    // Start loading
    _isLoading.value = true;

    try {
      // Create user with Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Update display name
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(
          '${firstnameController.text.trim()} ${lastnameController.text.trim()}'
        );
      }

      // Show success message
      Get.snackbar(
        'Success!',
        'Account created successfully. Proceeding to next step...',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade800,
        duration: const Duration(seconds: 2),
      );

      // Only navigate to next screen if registration is successful
      Get.toNamed('/doctorSignUp2');
      
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Registration failed';
      
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'An account already exists for this email.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password accounts are not enabled.';
          break;
        default:
          errorMessage = e.message ?? 'Registration failed';
      }

      Get.snackbar(
        'Registration Failed',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        duration: const Duration(seconds: 4),
      );
      // Don't navigate on error
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        duration: const Duration(seconds: 3),
      );
      // Don't navigate on error
    } finally {
      // Stop loading
      _isLoading.value = false;
    }
  }

  // Alternative method: Navigate to next page without Firebase registration
  // Use this if you want to skip Firebase auth for now
  void proceedToNextStep() {
    // Validate form first
    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        'Validation Error',
        'Please fill in all required fields correctly',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade100,
        colorText: Colors.orange.shade800,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    // Check if terms are agreed to
    if (!agreeToTerms) {
      Get.snackbar(
        'Terms Required',
        'Please accept the Terms of Service and Privacy Policy to continue',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    // If validation passes, navigate to next page
    Get.toNamed('/doctorSignUp2');
  }

  // Navigate to sign in page
  void navigateToSignIn() {
    Get.toNamed('/signin');
  }
}