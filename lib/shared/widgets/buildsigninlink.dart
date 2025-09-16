  /// Sign in link for existing users
  import 'package:flutter/material.dart';
import 'package:healio_version_2/app/modules/auth/controllers/signupcontroller.dart';
import 'package:healio_version_2/core/constants/appsizes.dart';
import 'package:healio_version_2/core/constants/apptextstyles.dart';
  Widget buildSignInLink(SignupController controller) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: AppSizes.signInRowVerticalSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Already have an account? ",
            style: AppTextStyles.alreadyHaveAccountTextStyle,
          ),
          GestureDetector(
            onTap: controller.navigateToSignIn,
            child: const Text(
              'Login here',
              style: AppTextStyles.loginHereTextStyle,
            ),
          ),
        ],
      ),
    );
  }
