import 'package:flutter/material.dart';
import 'package:healio_version_2/Screens/PatientSection/signup/signup2.dart' as AppColors;
import 'package:healio_version_2/app/modules/auth/controllers/patientsignupcontroller.dart';
import 'package:get/get.dart';

  /// Enhanced continue button
  Widget buildContinueButton(PatientSignupController controller) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Obx(() => ElevatedButton(
        onPressed: controller.selectedRole != Role.none ? controller.handleContinue : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.selectedRole != Role.none 
              ? AppColors.primaryColor
              : Colors.grey[300],
          foregroundColor: controller.selectedRole != Role.none 
              ? Colors.white
              : Colors.grey[600],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: controller.selectedRole != Role.none ? 4 : 0,
          shadowColor: AppColors.primaryColor.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (controller.selectedRole != Role.none) ...[
              const Icon(Icons.arrow_forward, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              controller.selectedRole != Role.none 
                  ? 'Continue as ${controller.selectedRole == Role.doctor ? 'Doctor' : 'Patient'}'
                  : 'Select Role to Continue',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      )),
    );
  }

