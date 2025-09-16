  import 'package:flutter/material.dart';
import 'package:healio_version_2/app/modules/auth/controllers/signupcontroller.dart';
import 'package:healio_version_2/core/constants/appsizes.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/core/constants/appcolors.dart';
import 'package:healio_version_2/core/constants/apptextstyles.dart';
import 'package:healio_version_2/shared/widgets/buildclickablelinkspan.dart';
/// Terms and conditions checkbox with clickable links

  Widget buildTermsAndConditions(SignupController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.termsCheckboxVerticalSpacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reactive checkbox that updates when controller state changes
          Obx(() => Checkbox(
                value: controller.agreeToTerms, // CORRECTED: Removed .value
                onChanged: controller.updateTermsAgreement,
                activeColor: AppColors.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              )),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.termsAndPolicyTextStyle,
                children: [
                  const TextSpan(text: "By continuing, you agree to Healio's "),
                  buildClickableLinkSpan('Terms of Use', () {
                    // TODO: Implement navigation to terms page
                    Get.snackbar('Info', 'Terms of Use page will open here');
                  }),
                  const TextSpan(text: ' and '),
                  buildClickableLinkSpan('Privacy Policy', () {
                    // TODO: Implement navigation to privacy policy page
                    Get.snackbar('Info', 'Privacy Policy page will open here');
                  }),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
