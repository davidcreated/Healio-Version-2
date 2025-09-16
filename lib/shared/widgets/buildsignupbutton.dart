/// Signup button with loading state
 import "package:flutter/material.dart";
import "package:healio_version_2/app/modules/auth/controllers/signupcontroller.dart";
import "package:healio_version_2/core/constants/appsizes.dart";
import "package:healio_version_2/shared/widgets/buildactivesignupbutton.dart";
import "package:healio_version_2/shared/widgets/buildloadingbutton.dart";
import "package:get/get.dart";

  Widget buildSignupButton(BuildContext context, SignupController controller) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: AppSizes.signUpButtonVerticalSpacing),
      child: SizedBox(
        width: double.infinity,
        height: size.height * AppSizes.signUpButtonHeightRatio,
        child: Obx(() => controller.isLoading // CORRECTED: Removed .value
            ? buildLoadingButton()
            : buildActiveSignupButton(controller)),
      ),
    );
  }
