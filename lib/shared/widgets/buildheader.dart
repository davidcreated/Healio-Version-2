import 'package:flutter/material.dart';
import 'package:healio_version_2/app/modules/auth/controllers/patientsignupcontroller.dart';
import 'package:healio_version_2/core/constants/apptextstyles.dart';
  /// Enhanced header design
  Widget buildHeader(PatientSignupController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 40), // Spacer
        Column(
          children: [
            Text(
              'Sign Up As',
              style: AppTextStyles.chooseSignupHeaderStyle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Choose your role to continue',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            onPressed: controller.goBack,
            icon: Icon(
              Icons.close,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
        ),
      ],
    );
  }