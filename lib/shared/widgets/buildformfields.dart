// All form input fields

import 'package:flutter/material.dart';
import 'package:healio_version_2/app/modules/auth/controllers/signupcontroller.dart';
import 'package:healio_version_2/core/constants/appsizes.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/shared/widgets/buildbaisctextfield.dart';
import 'package:healio_version_2/shared/widgets/buildpasswordfield.dart';

  Widget buildFormFields(SignupController controller) {
    return Column(
      children: [
        buildBasicTextField(
          controller: controller.firstnameController, 
          label: 'First Name',
          hint: 'Enter your first name',
          icon: Icons.person_outline,
          validator: (value) =>
              value?.isEmpty == true ? 'Please enter your first name' : null,
        ),
        const SizedBox(height: AppSizes.inputFieldVerticalSpacing),
        buildBasicTextField(
          controller: controller.lastnameController,
          label: 'Last Name',
          hint: 'Enter your last name',
          icon: Icons.person_outline,
          validator: (value) =>
              value?.isEmpty == true ? 'Please enter your last name' : null,
        ),
        const SizedBox(height: AppSizes.inputFieldVerticalSpacing),
        buildBasicTextField(
          controller: controller.usernameController,
          label: 'Username',
          hint: 'Choose a unique username',
          icon: Icons.account_circle_outlined,
          validator: controller.validateUsername,
        ),
        const SizedBox(height: AppSizes.inputFieldVerticalSpacing),
        buildBasicTextField(
          controller: controller.emailController,
          label: 'Email Address',
          hint: 'Enter your email',
          icon: Icons.email_outlined,
          validator: controller.validateEmail,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppSizes.inputFieldVerticalSpacing),
        // Password field with visibility toggle
        Obx(() => buildPasswordField(
              controller: controller.passwordController,
              label: 'Password',
              hint: 'Create a strong password',
              isVisible: controller.passwordVisible, // CORRECTED: Removed .value
              toggleVisibility: controller.togglePasswordVisibility,
              validator: controller.validatePassword,
            )),
        const SizedBox(height: AppSizes.inputFieldVerticalSpacing),
        // Confirm password field with visibility toggle
        Obx(() => buildPasswordField(
              controller: controller.confirmPasswordController,
              label: 'Confirm Password',
              hint: 'Re-enter your password',
              isVisible: controller.confirmPasswordVisible, // CORRECTED: Removed .value
              toggleVisibility: controller.toggleConfirmPasswordVisibility,
              validator: controller.validateConfirmPassword,
            )),
      ],
    );
  }