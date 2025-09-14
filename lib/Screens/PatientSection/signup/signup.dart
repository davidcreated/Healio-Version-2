import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/auth/controllers/signupcontroller.dart';
import 'package:healio_version_2/core/constants/appcolors.dart';
import 'package:healio_version_2/core/constants/appsizes.dart';
import 'package:healio_version_2/core/constants/apptextstyles.dart';

// NOTE: To ensure this page works correctly, please verify the following:
// 1. Your `pubspec.yaml` file has the correct asset paths declared for the images:
//    - 'lib/assets/images/patient/signupscreen1.jpg'
//    - 'lib/assets/images/patient/patient.png'
// 2. The `SignupController` class contains all the required controllers, variables, and methods used here.
// 3. The constant files (`appcolors.dart`, `appsizes.dart`, `apptextstyles.dart`) are correctly defined.

/// Main Signup Page Widget - Now much cleaner and focused on UI only
class PatientSignupPage extends StatefulWidget {
  const PatientSignupPage({super.key});

  @override
  State<PatientSignupPage> createState() => _PatientSignupPageState();
}

class _PatientSignupPageState extends State<PatientSignupPage> {
  // Initial background image
  String _backgroundImage = 'lib/assets/images/patient/signupscreen1.jpg';

  
  @override
  Widget build(BuildContext context) {
    // Initialize controller with GetX dependency injection
    return GetBuilder<SignupController>(
      init: SignupController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: GestureDetector(
            // Dismiss keyboard when tapping outside input fields
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                _buildBackgroundImage(context),
                _buildScrollableContent(context, controller),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Background image that covers the entire screen
  Widget _buildBackgroundImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned.fill(
      child: Image.asset(
        _backgroundImage,
        fit: BoxFit.fill,
        width: size.width,
        height: size.height,
      ),
    );
  }

  /// Main scrollable content with form
  Widget _buildScrollableContent(
      BuildContext context, SignupController controller) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * AppSizes.horizontalPaddingRatio,
          vertical: size.height * AppSizes.verticalPaddingRatio,
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * AppSizes.smallVerticalSpaceRatio),
          
              SizedBox(height: size.height * AppSizes.mediumVerticalSpaceRatio),
              _buildFormFields(controller),
              _buildTermsAndConditions(controller),
              _buildSignupButton(context, controller),
              _buildSignInLink(controller),
              SizedBox(height: size.height * AppSizes.bottomVerticalSpaceRatio),
            ],
          ),
        ),
      ),
    );
  }

  

  /// All form input fields
  Widget _buildFormFields(SignupController controller) {
    return Column(
      children: [
        _buildBasicTextField(
          controller: controller.firstnameController,
          label: 'First Name',
          hint: 'Enter your first name',
          icon: Icons.person_outline,
          validator: (value) =>
              value?.isEmpty == true ? 'Please enter your first name' : null,
        ),
        const SizedBox(height: AppSizes.inputFieldVerticalSpacing),
        _buildBasicTextField(
          controller: controller.lastnameController,
          label: 'Last Name',
          hint: 'Enter your last name',
          icon: Icons.person_outline,
          validator: (value) =>
              value?.isEmpty == true ? 'Please enter your last name' : null,
        ),
        const SizedBox(height: AppSizes.inputFieldVerticalSpacing),
        _buildBasicTextField(
          controller: controller.usernameController,
          label: 'Username',
          hint: 'Choose a unique username',
          icon: Icons.account_circle_outlined,
          validator: controller.validateUsername,
        ),
        const SizedBox(height: AppSizes.inputFieldVerticalSpacing),
        _buildBasicTextField(
          controller: controller.emailController,
          label: 'Email Address',
          hint: 'Enter your email',
          icon: Icons.email_outlined,
          validator: controller.validateEmail,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppSizes.inputFieldVerticalSpacing),
        // Password field with visibility toggle
        Obx(() => _buildPasswordField(
              controller: controller.passwordController,
              label: 'Password',
              hint: 'Create a strong password',
              isVisible: controller.passwordVisible, // CORRECTED: Removed .value
              toggleVisibility: controller.togglePasswordVisibility,
              validator: controller.validatePassword,
            )),
        const SizedBox(height: AppSizes.inputFieldVerticalSpacing),
        // Confirm password field with visibility toggle
        Obx(() => _buildPasswordField(
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

  /// Basic text input field with consistent styling
  Widget _buildBasicTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: _buildInputDecoration(
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

  /// Password field with visibility toggle functionality
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isVisible,
    required VoidCallback toggleVisibility,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      decoration: _buildInputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icons.lock_outline,
        suffixIcon: IconButton(
          icon: Icon(
            isVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: AppColors.primaryColor,
          ),
          onPressed: toggleVisibility,
          // Add tooltip for better UX
          tooltip: isVisible ? 'Hide password' : 'Show password',
        ),
      ),
      validator: validator,
      textInputAction: TextInputAction.done,
      style: AppTextStyles.inputTextStyle ?? const TextStyle(fontSize: 16),
    );
  }

  /// Consistent input field decoration
  InputDecoration _buildInputDecoration({
    required String labelText,
    required String hintText,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      hintStyle: AppTextStyles.inputHintStyle,
      prefixIcon:
          prefixIcon != null ? Icon(prefixIcon, color: Colors.grey[700]) : null,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: AppSizes.focusedInputBorderWidth,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppSizes.inputContentPaddingVertical,
        horizontal: AppSizes.inputContentPaddingHorizontal,
      ),
    );
  }

  /// Terms and conditions checkbox with clickable links
  Widget _buildTermsAndConditions(SignupController controller) {
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
                  _buildClickableLinkSpan('Terms of Use', () {
                    // TODO: Implement navigation to terms page
                    Get.snackbar('Info', 'Terms of Use page will open here');
                  }),
                  const TextSpan(text: ' and '),
                  _buildClickableLinkSpan('Privacy Policy', () {
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

  /// Clickable link span for terms and policy
  TextSpan _buildClickableLinkSpan(String text, VoidCallback onTap) {
    return TextSpan(
      text: text,
      style: AppTextStyles.termsAndPolicyLinkStyle,
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }

  /// Signup button with loading state
  Widget _buildSignupButton(BuildContext context, SignupController controller) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: AppSizes.signUpButtonVerticalSpacing),
      child: SizedBox(
        width: double.infinity,
        height: size.height * AppSizes.signUpButtonHeightRatio,
        child: Obx(() => controller.isLoading // CORRECTED: Removed .value
            ? _buildLoadingButton()
            : _buildActiveSignupButton(controller)),
      ),
    );
  }

  /// Loading button with spinner
  Widget _buildLoadingButton() {
    return ElevatedButton(
      onPressed: null, // Disabled during loading
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor.withOpacity(0.7),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          SizedBox(width: 12),
          Text('Creating Account...'),
        ],
      ),
    );
  }

  /// Active signup button
  Widget _buildActiveSignupButton(SignupController controller) {
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

  /// Sign in link for existing users
  Widget _buildSignInLink(SignupController controller) {
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
}

