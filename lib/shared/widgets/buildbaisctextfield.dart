import 'package:flutter/material.dart';
import 'package:healio_version_2/core/constants/apptextstyles.dart';
import 'package:healio_version_2/shared/widgets/buildinputdecoraation.dart';
  /// Basic text input field with consistent styling
  Widget buildBasicTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: buildInputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon,
      ),
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      // Improved text input styling with a null-check fallback
      style: AppTextStyles.inputTextStyle ?? const TextStyle(fontSize: 16),
    );
  }
