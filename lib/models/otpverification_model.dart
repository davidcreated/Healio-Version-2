import 'package:flutter/material.dart';

// A simple, Flutter-friendly OTP verification model for managing state.
// This model holds the controller and focus node for the email input field.

class OtpVerificationModel {
  // Key for the email TextFormField (optional, useful for validation or focus)
  final textFieldKey = GlobalKey<FormFieldState>();

  // Focus node for managing focus on the email field
  final FocusNode textFieldFocusNode = FocusNode();

  // Controller for the email input field
  final TextEditingController textController = TextEditingController();

  // Optional: You can add a validator function for the email field
  String? Function(String?)? textControllerValidator;

  // Call this when disposing your widget to clean up resources
  void dispose() {
    textFieldFocusNode.dispose();
    textController.dispose();
  }
}