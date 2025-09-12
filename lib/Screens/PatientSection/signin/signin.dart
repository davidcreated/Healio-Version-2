import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/patients/controllers/signincontroller.dart';
import 'package:healio_version_2/core/constants/appcolors.dart';
import 'package:healio_version_2/core/constants/appsizes.dart';
import 'package:healio_version_2/core/constants/apptextstyles.dart';

// NOTE: To ensure this page works correctly, please verify the following:
// 1. Your `pubspec.yaml` file has the correct asset paths declared for the images:
//    - 'lib/assets/images/patient/signupscreen1.jpg'
//    - 'lib/assets/images/patient/patient.png'
// 2. The `SignupController` class contains all the required controllers, variables, and methods used here.
// 3. The constant files (`appcolors.dart`, `appsizes.dart`, `apptextstyles.dart`) are correctly defined.

/// Main Sign In Page Widget - Simplified for email and password only
class PatientSignInPage extends StatefulWidget {
  const PatientSignInPage({super.key});

  @override
  State<PatientSignInPage> createState() => _PatientSignInPageState();
}

class _PatientSignInPageState extends State<PatientSignInPage> {
  // Initial background image
  String _backgroundImage = 'lib/assets/images/patient/signupscreen1.jpg';

  
  @override
  Widget build(BuildContext context) {
    // Initialize controller with GetX dependency injection
    return GetBuilder<SignInController>(
      init: SignInController(),
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
      BuildContext context, SignInController controller) {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.15), // More space at top for sign in
              
              // Welcome back text
              Text(
                'Welcome Back !',
                 style: AppTextStyles.chooseSignupHeaderStyle.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF3A3A3A),
              ),
              ),
             
             
              SizedBox(height: size.height * 0.04), // Space before form
              
              _buildFormFields(controller),
              _buildSignInButton(context, controller),
              _buildSignUpLink(controller),
              SizedBox(height: size.height * AppSizes.bottomVerticalSpaceRatio),
            ],
          ),
        ),
      ),
    );
  }

  /// Sign in form fields - Only email and password
  Widget _buildFormFields(SignInController controller) {
    return Column(
      children: [
        _buildBasicTextField(
          controller: controller.emailController,
          label: 'Email Address',
          hint: 'Enter your email',
          icon: Icons.email_outlined,
          validator: controller.validateEmail,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppSizes.inputFieldVerticalSpacing + 8), // Slightly more space
        
        // Password field with visibility toggle
        Obx(() => _buildPasswordField(
              controller: controller.passwordController,
              label: 'Password',
              hint: 'Enter your password',
              isVisible: controller.passwordVisible,
              toggleVisibility: controller.togglePasswordVisibility,
              validator: controller.validatePassword,
            )),
        
        const SizedBox(height: 16), // Space for forgot password link
        
        // Forgot password link
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              // TODO: Implement forgot password functionality
              Get.snackbar('Info', 'Forgot password feature will be implemented');
            },
            child:Text(
              'Forgot Password?',
               style: AppTextStyles.chooseSignupHeaderStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0XFF3A3A3A),
              ),
            ),
          ),
        ),
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
      fillColor: Colors.white.withOpacity(0.95),
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppSizes.inputContentPaddingVertical,
        horizontal: AppSizes.inputContentPaddingHorizontal,
      ),
    );
  }

  /// Sign in button with loading state
  Widget _buildSignInButton(BuildContext context, SignInController controller) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0), // More space for sign in
      child: SizedBox(
        width: double.infinity,
        height: size.height * AppSizes.signUpButtonHeightRatio,
        child: Obx(() => controller.isLoading
            ? _buildLoadingButton()
            : _buildActiveSignInButton(controller)),
      ),
    );
  }

  /// Loadinupbutton with spinner
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
          Text('Signing In...'),
        ],
      ),
    );
  }

  /// Active sign in button
  Widget _buildActiveSignInButton(SignInController controller) {
    return ElevatedButton(
      onPressed: controller.signIn, // You may want to create a separate signIn method
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: AppSizes.buttonElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
        ),
        textStyle: AppTextStyles.signUpButtonTextStyle,
      ),
      child: const Text('Sign In'),
    );
  }

  /// Sign up link for new users
  Widget _buildSignUpLink(SignInController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.signInRowVerticalSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
             style: AppTextStyles.chooseSignupHeaderStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff3A3A3A),
              ),
          ),
          GestureDetector(
            onTap: controller.navigateToSignUp,
            child: Text(
              'Sign Up',
               style: AppTextStyles.chooseSignupHeaderStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff002180),
              ),
            ),
          ),
        ],
      ),
    );
  }
}