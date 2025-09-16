import 'package:flutter/material.dart';
import 'package:healio_version_2/Screens/PatientSection/signup/signup2.dart' as AppColors;
import 'package:healio_version_2/app/modules/auth/controllers/patientsignupcontroller.dart';
import 'package:healio_version_2/core/constants/appsizes.dart';

/// Enhanced back button with better styling
  Widget buildBackButton(PatientSignupController controller) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSizes.chooseSignupBackButtonPaddingLeft,
          top: AppSizes.chooseSignupBackButtonPaddingTop,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(
              AppSizes.chooseSignupBackButtonBorderRadius,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: controller.goBack,
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primaryColor,
              size: AppSizes.chooseSignupBackButtonIconSize,
            ),
          ),
        ),
      ),
    );
  }