// Main UI Widget - Fixed image display and enhanced UI
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/patients/controllers/patientsignupcontroller.dart';
import 'package:healio_version_2/core/constants/appcolors.dart';
import 'package:healio_version_2/core/constants/appdurations.dart';
import 'package:healio_version_2/core/constants/appsizes.dart';
import 'package:healio_version_2/core/constants/apptextstyles.dart';

/// Main signup screen widget with fixed image display
class Patientsignup extends StatelessWidget {
  const Patientsignup({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientSignupController>(
      init: PatientSignupController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              // Layer 1: Fixed background image display
              _buildBackgroundImage(controller),
              // Layer 2: Gradient overlay for better text readability
              _buildGradientOverlay(),
              // Layer 3: Back button at top-left
              _buildBackButton(controller),
              // Layer 4: Bottom panel with role selection
              _buildBottomPanel(controller),
            ],
          ),
        );
      },
    );
  }

  /// Fixed background image with better positioning and scaling
  Widget _buildBackgroundImage(PatientSignupController controller) {
    return Positioned.fill(
      child: Obx(() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: Container(
          key: ValueKey(controller.selectedRole),
          child: Image.asset(
            controller.getBackgroundImagePath(),
            fit: BoxFit.cover, // Ensures proper scaling
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center, // Center the image
            
            // Enhanced error handling
            errorBuilder: (context, error, stackTrace) {
              print('Error loading image: ${controller.getBackgroundImagePath()}');
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF4A90E2),
                      Color(0xFF357ABD),
                    ],
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.medical_services,
                        size: 80,
                        color: Colors.white,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Healio',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      )),
    );
  }

  /// Gradient overlay for better text readability
  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.1), // Light overlay at top
              Colors.black.withOpacity(0.3), // Darker overlay at bottom
            ],
            stops: const [0.0, 0.7],
          ),
        ),
      ),
    );
  }

  /// Enhanced back button with better styling
  Widget _buildBackButton(PatientSignupController controller) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSizes.chooseSignupBackButtonPaddingLeft,
          top: AppSizes.chooseSignupBackButtonPaddingTop,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(
              AppSizes.chooseSignupBackButtonBorderRadius,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: controller.goBack,
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primaryColor,
              size: AppSizes.chooseSignupBackButtonIconSize,
            ),
          ),
        ),
      ),
    );
  }

  /// Enhanced bottom panel with improved design
  Widget _buildBottomPanel(PatientSignupController controller) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SlideTransition(
        position: controller.slideAnimation,
        child: Container(
          margin: const EdgeInsets.all(16), // Add margin for better appearance
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24), // More rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: FadeTransition(
            opacity: controller.fadeAnimation,
            child: _buildPanelContent(controller),
          ),
        ),
      ),
    );
  }

  /// Enhanced panel content with better spacing
  Widget _buildPanelContent(PatientSignupController controller) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with improved styling
          _buildHeader(controller),
          const SizedBox(height: 32),
          // Role selection buttons with better design
          _buildRoleSelectionButtons(controller),
          const SizedBox(height: 24),
          // Continue button
          _buildContinueButton(controller),
        ],
      ),
    );
  }

  /// Enhanced header design
  Widget _buildHeader(PatientSignupController controller) {
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

  /// Enhanced role selection buttons
  Widget _buildRoleSelectionButtons(PatientSignupController controller) {
    return Column(
      children: [
        // Doctor button with improved design
        Obx(() => _RoleSelectionButton(
          label: 'Doctor',
          isSelected: controller.selectedRole == Role.doctor,
          onTap: () => controller.selectRole(Role.doctor),
        )),
        
        const SizedBox(height: 16),
        
        // Patient button with improved design
        Obx(() => _RoleSelectionButton(
          label: 'Patient',
          isSelected: controller.selectedRole == Role.patient,
          onTap: () => controller.selectRole(Role.patient),
        )),
      ],
    );
  }

  /// Enhanced continue button
  Widget _buildContinueButton(PatientSignupController controller) {
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
}

/// Custom widget for role selection buttons with improved animations
class _RoleSelectionButton extends StatelessWidget {
  const _RoleSelectionButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.roleSelectionButtonBorderRadius),
      
      splashColor: AppColors.roleSelectionSelectedColor.withOpacity(0.1),
      highlightColor: AppColors.roleSelectionSelectedColor.withOpacity(0.05),
      
      child: AnimatedContainer(
        duration: AppDurations.roleSelectionAnimationDuration,
        curve: Curves.easeInOut,
        width: double.infinity,
        height: AppSizes.roleSelectionButtonHeight,
        
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.roleSelectionSelectedColor
              : AppColors.roleSelectionUnselectedColor,
          borderRadius: BorderRadius.circular(AppSizes.roleSelectionButtonBorderRadius),
          
          border: Border.all(
            color: isSelected
                ? AppColors.roleSelectionSelectedColor
                : AppColors.roleSelectionUnselectedBorderColor,
            width: AppSizes.roleSelectionButtonBorderWidth,
          ),
          
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.roleSelectionSelectedColor.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                label == 'Doctor' ? Icons.local_hospital : Icons.person,
                color: isSelected ? Colors.white : Colors.black,
                size: 20,
              ),
              const SizedBox(width: 8),
              
              AnimatedDefaultTextStyle(
                duration: AppDurations.roleSelectionAnimationDuration,
                style: AppTextStyles.roleSelectionButtonTextStyle.copyWith(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                child: Text(label),
              ),
              
              if (isSelected)
                const SizedBox(width: 8),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }
}