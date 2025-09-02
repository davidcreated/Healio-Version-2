import 'package:flutter/material.dart';

// A simple, Flutter-friendly OTP verification model for managing state.
// This model holds controllers and focus nodes for each OTP digit field.

class OtpVerification3Model {
  // List of controllers for each OTP digit field
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());

  // List of focus nodes for each OTP digit field
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  // Optional: You can add a validator function for each OTP field if needed
  List<String? Function(String?)?> validators = List.filled(6, null);

  // Call this when disposing your widget to clean up resources
  void dispose() {
    for (final controller in otpControllers) {
      controller.dispose();
    }
    for (final node in focusNodes) {
      node.dispose();
    }
  }
}
