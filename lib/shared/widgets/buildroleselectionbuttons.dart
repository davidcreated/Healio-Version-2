import 'package:flutter/material.dart';
import 'package:healio_version_2/app/modules/auth/controllers/patientsignupcontroller.dart';
import "package:get/get.dart";
import 'package:healio_version_2/shared/widgets/roleselectionbuttons.dart';

  /// Enhanced role selection buttons
  Widget buildRoleSelectionButtons(PatientSignupController controller) {
    return Column(
      children: [
        // Doctor button with improved design
        Obx(() => RoleSelectionButton(
          label: 'Doctor',
          isSelected: controller.selectedRole == Role.doctor,
          onTap: () => controller.selectRole(Role.doctor),
        )),
        
        const SizedBox(height: 16),
        
        // Patient button with improved design
        Obx(() => RoleSelectionButton(
          label: 'Patient',
          isSelected: controller.selectedRole == Role.patient,
          onTap: () => controller.selectRole(Role.patient),
        )),
      ],
    );
  }