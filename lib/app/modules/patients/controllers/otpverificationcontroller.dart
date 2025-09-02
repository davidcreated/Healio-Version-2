import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/Screens/PatientSection/verification/emailverification.dart';

class OtpVerificationController extends GetxController {
  // Text controllers
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  
  // Form key for validation
  final formKey = GlobalKey<FormState>();
  
  // Reactive variables
  var isLoading = false.obs;
  var isEmailValid = false.obs;
  var showOtpField = false.obs;
  var isResendingOtp = false.obs;
  var canResendOtp = false.obs;
  var resendCountdown = 0.obs;
  
  // Email validation
  void validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    isEmailValid.value = emailRegex.hasMatch(email);
  }
  
  // Send OTP
  void sendOtp() async {
    if (!formKey.currentState!.validate()) return;
    
    try {
      isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      showOtpField.value = true;
      startResendTimer();
      
      Get.snackbar(
        'OTP Sent',
        'Verification code sent to ${emailController.text}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF007F67),
        colorText: Colors.white,
        icon: const Icon(Icons.email, color: Colors.white),
      );
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send OTP. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Resend OTP
  void resendOtp() async {
    if (!canResendOtp.value) return;
    
    try {
      isResendingOtp.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      startResendTimer();
      
      Get.snackbar(
        'OTP Resent',
        'New verification code sent',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF007F67),
        colorText: Colors.white,
      );
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend OTP. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isResendingOtp.value = false;
    }
  }
  
  // Start countdown timer for resend
  void startResendTimer() {
    canResendOtp.value = false;
    resendCountdown.value = 60;
    
    // Countdown timer
    for (int i = 60; i > 0; i--) {
      Future.delayed(Duration(seconds: 60 - i), () {
        if (resendCountdown.value > 0) {
          resendCountdown.value--;
        }
      });
    }
    
    // Enable resend after countdown
    Future.delayed(const Duration(seconds: 60), () {
      canResendOtp.value = true;
    });
  }
  
  // Verify OTP and navigate
  void verifyOtp() async {
    if (otpController.text.length != 6) {
      Get.snackbar(
        'Invalid OTP',
        'Please enter a valid 6-digit code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }
    
    try {
      isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Navigate to next page
      Get.off(() => const EmailVerificationPage());

    } catch (e) {
      Get.snackbar(
        'Verification Failed',
        'Invalid OTP code. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Email validation for form
  String? validateEmailInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
  
  @override
  void onClose() {
    emailController.dispose();
    otpController.dispose();
    super.onClose();
  }
}