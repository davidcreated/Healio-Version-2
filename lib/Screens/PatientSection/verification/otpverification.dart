
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/auth/controllers/otpverificationcontroller.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpVerificationController>(
      init: OtpVerificationController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(),
          body: _buildBody(context, controller),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF002180)),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        'Email Verification',
        style: TextStyle(
          fontFamily: 'NotoSans',
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context, OtpVerificationController controller) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A90E2),
              Color(0xFF50C878),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildHeaderImage(),
                const SizedBox(height: 40),
                _buildTitleSection(),
                const SizedBox(height: 40),
                _buildEmailSection(controller),
                const SizedBox(height: 24),
                Obx(() => controller.showOtpField.value 
                    ? _buildOtpSection(controller)
                    : const SizedBox.shrink()),
                const SizedBox(height: 40),
                _buildActionButton(controller),
                const SizedBox(height: 20),
                Obx(() => controller.showOtpField.value 
                    ? _buildResendSection(controller)
                    : const SizedBox.shrink()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/vectors/otpverification.png',
          width: 200,
          height: 240,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.email_outlined,
            size: 48,
            color: Color(0xFF002180),
          ),
          const SizedBox(height: 16),
          const Text(
            'Email Verification',
            style: TextStyle(
              fontFamily: 'NotoSerif',
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'We will send a one-time password to\nyour email address',
            style: TextStyle(
              fontFamily: 'NotoSans',
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmailSection(OtpVerificationController controller) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF002180).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.email_outlined,
                  color: Color(0xFF002180),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Email Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            decoration: _buildInputDecoration(
              labelText: 'Email Address',
              hintText: 'Enter your email address',
              prefixIcon: Icons.email_outlined,
            ),
            validator: controller.validateEmailInput,
            onChanged: controller.validateEmail,
            style: const TextStyle(
              fontFamily: 'NotoSans',
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: () {
                // Logic to edit email or clear field
                controller.emailController.clear();
                controller.showOtpField.value = false;
              },
              child: const Text(
                'Edit email',
                style: TextStyle(
                  color: Color(0xE2190B99),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'NotoSans',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpSection(OtpVerificationController controller) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF007F67).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.security_outlined,
                  color: Color(0xFF007F67),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Enter Verification Code',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Enter the 6-digit code sent to ${controller.emailController.text}',
            style: TextStyle(
              fontFamily: 'NotoSans',
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: controller.otpController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
            decoration: _buildInputDecoration(
              labelText: 'Verification Code',
              hintText: 'Enter 6-digit code',
              prefixIcon: Icons.security_outlined,
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'NotoSans',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter verification code';
              }
              if (value.length != 6) {
                return 'Please enter a valid 6-digit code';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(OtpVerificationController controller) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF002180).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Obx(() => ElevatedButton(
        onPressed: controller.isLoading.value 
            ? null 
            : () {
                if (controller.showOtpField.value) {
                  controller.verifyOtp();
                } else {
                  controller.sendOtp();
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF002180),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: 'NotoSans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: controller.isLoading.value
            ? _buildLoadingContent()
            : _buildButtonContent(controller),
      )),
    );
  }

  Widget _buildLoadingContent() {
    return const Row(
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
        Text('Please wait...'),
      ],
    );
  }

  Widget _buildButtonContent(OtpVerificationController controller) {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          controller.showOtpField.value 
              ? Icons.verified_user_outlined 
              : Icons.send_outlined, 
          size: 24
        ),
        const SizedBox(width: 8),
        Text(controller.showOtpField.value ? 'Verify Code' : 'Get OTP'),
      ],
    ));
  }

  Widget _buildResendSection(OtpVerificationController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Didn't receive the code? ",
            style: TextStyle(
              fontFamily: 'NotoSans',
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Obx(() => controller.canResendOtp.value
              ? TextButton(
                  onPressed: controller.isResendingOtp.value 
                      ? null 
                      : controller.resendOtp,
                  child: controller.isResendingOtp.value
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF002180)),
                          ),
                        )
                      : const Text(
                          'Resend',
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            color: Color(0xFF002180),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                )
              : Text(
                  'Resend in ${controller.resendCountdown.value}s',
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                )),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String labelText,
    required String hintText,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      labelStyle: TextStyle(
        color: Colors.grey[700],
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'NotoSans',
      ),
      hintStyle: TextStyle(
        color: Colors.grey[500],
        fontSize: 16,
        fontFamily: 'NotoSans',
      ),
      prefixIcon: prefixIcon != null 
          ? Icon(prefixIcon, color: Colors.grey[600], size: 22) 
          : null,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF002180), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    );
  }
}