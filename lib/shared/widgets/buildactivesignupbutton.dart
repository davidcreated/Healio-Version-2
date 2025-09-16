  import 'package:flutter/material.dart';
import 'package:healio_version_2/Screens/PatientSection/signup/signup2.dart' as AppColors;
import 'package:healio_version_2/app/modules/auth/controllers/signupcontroller.dart';
import 'package:healio_version_2/core/constants/appsizes.dart';
import 'package:healio_version_2/core/constants/apptextstyles.dart';

/// Active signup button
 
  Widget buildActiveSignupButton(SignupController controller) {
    return ElevatedButton(
      onPressed: controller.register,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: AppSizes.buttonElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
        ),
        textStyle: AppTextStyles.signUpButtonTextStyle,
      ),
      child: const Text('Sign Up'),
    );
  } 