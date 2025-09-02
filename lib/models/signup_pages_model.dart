import 'package:flutter/material.dart';

/// This class handles the state (data and controllers)
/// used in the sign-up page.
class SignUpPageModel {
  // Controllers for text fields
  TextEditingController? fullNameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;

  // FocusNodes let you manage focus behavior (optional)
  FocusNode? fullNameFocusNode;
  FocusNode? emailFocusNode;
  FocusNode? passwordFocusNode;
  FocusNode? confirmPasswordFocusNode;

  // Used to toggle password visibility
  bool passwordVisible = false;

  // Used to store the checkbox state (e.g., "I agree to terms")
  bool isChecked = false;

  /// Call this when the page is initialized
  void initState() {
    passwordVisible = false;
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    fullNameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
  }

  /// Call this when the page is disposed to free resources
  void dispose() {
    fullNameController?.dispose();
    emailController?.dispose();
    passwordController?.dispose();
    confirmPasswordController?.dispose();

    fullNameFocusNode?.dispose();
    emailFocusNode?.dispose();
    passwordFocusNode?.dispose();
    confirmPasswordFocusNode?.dispose();
  }
}
