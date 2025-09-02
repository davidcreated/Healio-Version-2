import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/patients/controllers/emailverificationcontroller.dart';


class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailVerifiedController>(
      init: EmailVerifiedController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: _buildBody(context, controller),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, EmailVerifiedController controller) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A90E2), // Blue at top
              Color(0xFF50C878), // Green at bottom
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Obx(() => AnimatedOpacity(
              opacity: controller.showContent.value ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 800),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  _buildSuccessImage(),
                  const SizedBox(height: 40),
                  _buildSuccessMessage(),
                  const SizedBox(height: 60),
                  _buildContinueButton(controller),
                  const SizedBox(height: 40),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessImage() {
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
          'lib/assets/vectors/otpverification.png',
          width: 300,
          height: 350,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
          // Success icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF007F67).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              size: 48,
              color: Color(0xFF007F67),
            ),
          ),
          const SizedBox(height: 24),
          // Success title
          const Text(
            'Email Verified!',
            style: TextStyle(
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Color(0xFF007F67),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          // Success message
          Text(
            'Your email has been verified successfully.\nYou can now access all features.',
            style: TextStyle(
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.w400,
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

  Widget _buildContinueButton(EmailVerifiedController controller) {
    return Container(
      width: double.infinity,
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
        onPressed: controller.isNavigating.value 
            ? null 
            : controller.navigateToSignIn,
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
        child: controller.isNavigating.value
            ? _buildLoadingContent()
            : _buildButtonContent(),
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

  Widget _buildButtonContent() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.arrow_forward, size: 24),
        SizedBox(width: 8),
        Text('Continue to Sign In'),
      ],
    );
  }
}