import 'package:flutter/material.dart';
import 'package:healio_version_2/Screens/PatientSection/signup/signup2.dart' as AppColors;
import 'package:healio_version_2/core/constants/appsizes.dart';
import 'package:healio_version_2/core/constants/apptextstyles.dart';
  /// Consistent input field decoration
  InputDecoration buildInputDecoration({
    required String labelText,
    required String hintText,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      hintStyle: AppTextStyles.inputHintStyle,
      prefixIcon:
          prefixIcon != null ? Icon(prefixIcon, color: Colors.grey[700]) : null,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: AppSizes.focusedInputBorderWidth,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppSizes.inputContentPaddingVertical,
        horizontal: AppSizes.inputContentPaddingHorizontal,
      ),
    );
  }
