// Main UI Widget - Enhanced with dynamic background images
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/routes/approutes.dart';
import 'package:healio_version_2/core/constants/appcolors.dart';
import 'package:healio_version_2/core/constants/appdurations.dart';
import 'package:healio_version_2/core/constants/appsizes.dart';
import 'package:healio_version_2/core/constants/apptextstyles.dart';

/// Enhanced ChooseSignupController for proper role-based navigation
/// This controller manages the state and behavior of the signup screen
class PatientSigninController extends GetxController
    with GetSingleTickerProviderStateMixin {
  
  // ====== REACTIVE STATE VARIABLES ======
  // This variable holds the currently selected role and automatically updates the UI when changed
  final _selectedRole = Role.none.obs;
  
  // Getter method to access the selected role from outside the controller
  Role get selectedRole => _selectedRole.value;
  
  // ====== ANIMATION CONTROLLERS ======
  // These control the slide and fade animations for the bottom panel
  late final AnimationController animationController;
  late final Animation<Offset> slideAnimation;   // Controls sliding from bottom
  late final Animation<double> fadeAnimation;    // Controls fade-in effect

  // ====== CONTROLLER LIFECYCLE METHODS ======
  @override
  void onInit() {
    super.onInit();
    // Initialize animations when the controller is created
    _initializeAnimations();
  }

  /// Initialize slide and fade animations for the bottom panel
  /// This creates smooth animations when the screen loads
  void _initializeAnimations() {
    // Create the main animation controller with specified duration
    animationController = AnimationController(
      duration: AppDurations.chooseSignupSlideAnimationDuration,
      vsync: this, // 'this' refers to the mixin that provides animation ticker
    );

    // Create slide animation that moves panel from bottom to normal position
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from bottom (off-screen)
      end: Offset.zero,          // End at normal position (on-screen)
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutQuart, // Smooth easing curve
    ));

    // Create fade animation that fades content in during slide
    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        AppDurations.chooseSignupFadeAnimationIntervalStart,
        AppDurations.chooseSignupFadeAnimationIntervalEnd,
        curve: Curves.easeOut,
      ),
    );

    // Start the animation immediately when controller initializes
    animationController.forward();
  }

  // ====== USER INTERACTION METHODS ======
  
  /// Update selected role and trigger reactive UI update
  /// This method is called when user taps on Doctor or Patient button
  void selectRole(Role role) {
    print('Role selected: $role'); // Debug print for development
    _selectedRole.value = role;
    // Note: The UI will automatically update because we're using .obs (observable)
  }

  /// Handle continue button - validates selection and navigates accordingly
  /// This is the main action when user wants to proceed with their selection
  void handleContinue() {
    // STEP 1: Validate that user has selected a role
    if (selectedRole == Role.none) {
      _showSelectionRequiredSnackbar();
      return; // Exit early if no role selected
    }

    // STEP 2: Navigate based on selected role
    switch (selectedRole) {
      case Role.doctor:
        // Navigate to doctor signup page
        // TODO: Uncomment when doctor signup route is ready
        // Get.offAllNamed(AppRoutes.DoctorSignUp);
        _showSuccessSnackbar('Doctor Selected', 'Redirecting to doctor registration...');
        break;
        
      case Role.patient:
        // Navigate to patient signup page
        Get.offAllNamed(AppRoutes.SignUp);
        _showSuccessSnackbar('Patient Selected', 'Redirecting to patient registration...');
        break;
        
      case Role.none:
        // This case is already handled above, but included for completeness
        break;
    }
  }

  /// Navigate back to previous screen
  /// Simple method to go back when user taps back button
  void goBack() {
    Get.back();
  }

  // ====== HELPER METHODS FOR USER FEEDBACK ======
  
  /// Show error when no role is selected
  /// This provides user feedback when they try to continue without selecting a role
  void _showSelectionRequiredSnackbar() {
    Get.snackbar(
      'Selection Required', // Title of the snackbar
      'Please select whether you are a Doctor or Patient before continuing.', // Message
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange.shade600,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
    );
  }

  /// Show success message when role is selected
  /// This provides positive feedback when user successfully selects a role
  void _showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,   // Dynamic title based on selection
      message, // Dynamic message based on selection
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  // ====== HELPER METHOD FOR DYNAMIC BACKGROUND IMAGE ======
  
  /// Get the appropriate background image path based on selected role
  /// This method returns the correct image path depending on what role is selected
  String getBackgroundImagePath() {
    switch (selectedRole) {
      case Role.doctor:
        return 'lib/assets/images/patient/signup.png';    // Doctor background
      case Role.patient:
        return 'lib/assets/images/patient/patient.png';   // Patient background
      case Role.none:
        return 'lib/assets/images/patient/signup.png';    // Default background
    }
  }

  // ====== CLEANUP METHODS ======
  @override
  void onClose() {
    // Clean up animation controller to prevent memory leaks
    animationController.dispose();
    super.onClose();
  }
}

/// Role enum definition
/// This enum defines the possible roles a user can select
enum Role { 
  none,    // No role selected (initial state)
  doctor,  // Medical professional
  patient  // Regular patient/user
}

/// Main signup screen widget
/// This is the main screen that users see when choosing their role
class Patientsignin extends StatelessWidget {
  const Patientsignin({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the PatientSigninController specifically for this page
    // GetBuilder automatically manages the controller lifecycle
    return GetBuilder<PatientSigninController>(
      init: PatientSigninController(),
      builder: (controller) {
        return Scaffold(
          // Using Stack for layered design (background image + overlay content)
          body: Stack(
            children: [
              // Layer 1: Dynamic background image (changes based on selection)
              _buildBackgroundImage(controller),
              // Layer 2: Back button at top-left
              _buildBackButton(controller),
              // Layer 3: Bottom panel with role selection
              _buildBottomPanel(controller),
            ],
          ),
        );
      },
    );
  }

  // ====== UI BUILDING METHODS ======

  /// Background image that covers the entire screen
  /// ENHANCED: Now changes dynamically based on selected role
  Widget _buildBackgroundImage(PatientSigninController controller) {
    return Positioned.fill(
      child: Obx(() => AnimatedSwitcher(
        // Smooth transition when changing background images
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          // Fade transition between different background images
          return FadeTransition(opacity: animation, child: child);
        },
        child: Image.asset(
          // KEY CHANGE: Dynamic image path based on selected role
          controller.getBackgroundImagePath(),
          key: ValueKey(controller.selectedRole), // Unique key for AnimatedSwitcher
          fit: BoxFit.cover, // Ensures image covers entire screen
          
          // Error handling for missing images - shows fallback if image not found
          errorBuilder: (context, error, stackTrace) {
            print('Error loading image: ${controller.getBackgroundImagePath()}'); // Debug info
            return Container(
              color: AppColors.primaryAccent ?? Colors.blue.shade100,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Image not found',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )),
    );
  }

  /// Back button positioned at top-left with safe area
  /// This allows users to navigate back to the previous screen
  Widget _buildBackButton(PatientSigninController controller) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSizes.chooseSignupBackButtonPaddingLeft,
          top: AppSizes.chooseSignupBackButtonPaddingTop,
        ),
        child: IconButton(
          onPressed: controller.goBack,
          style: IconButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppSizes.chooseSignupBackButtonBorderRadius,
              ),
            ),
          ),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: AppSizes.chooseSignupBackButtonIconSize,
          ),
        ),
      ),
    );
  }

  /// Bottom panel with slide and fade animations
  /// This panel slides up from bottom and contains all the role selection UI
  Widget _buildBottomPanel(PatientSigninController controller) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SlideTransition(
        position: controller.slideAnimation,
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.chooseSignupPanelPaddingHorizontal,
            AppSizes.chooseSignupPanelPaddingTop,
            AppSizes.chooseSignupPanelPaddingHorizontal,
            AppSizes.chooseSignupPanelPaddingBottom,
          ),
          decoration: const BoxDecoration(
            color: AppColors.chooseSignupBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.chooseSignupPanelBorderRadius),
              topRight: Radius.circular(AppSizes.chooseSignupPanelBorderRadius),
            ),
          ),
          child: FadeTransition(
            opacity: controller.fadeAnimation,
            child: _buildPanelContent(controller),
          ),
        ),
      ),
    );
  }

  /// Content inside the bottom panel
  /// This organizes all the content within the panel in a vertical layout
  Widget _buildPanelContent(PatientSigninController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Take only necessary space
      children: [
        // Panel header with title and close button
        _buildHeader(controller),
        const SizedBox(height: AppSizes.chooseSignupHeaderVerticalSpacing),
        // Role selection buttons (Doctor and Patient)
        _buildRoleSelectionButtons(controller),
        const SizedBox(height: AppSizes.continueButtonSpacing),
        // Continue button at the bottom
        _buildContinueButton(controller),
      ],
    );
  }

  /// Header with title and close button
  /// This creates the top part of the panel with "Sign Up As" title
  Widget _buildHeader(PatientSigninController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Empty spacer to center the title
        const SizedBox(width: AppSizes.chooseSignupHeaderSpacerWidth),
        // Main title text
        const Text(
          'Sign In As',
          style: AppTextStyles.chooseSignupHeaderStyle,
        ),
        // Close button (X) on the right
        IconButton(
          onPressed: controller.goBack,
          icon: const Icon(
            Icons.close,
            color: AppColors.textColorBlack,
            size: AppSizes.chooseSignupCloseIconSize,
          ),
        ),
      ],
    );
  }

  /// Role selection buttons with reactive updates
  /// These buttons allow users to choose between Doctor and Patient roles
  /// IMPORTANT: Both buttons use Obx() for reactive updates when selection changes
  Widget _buildRoleSelectionButtons(PatientSigninController controller) {
    return Column(
      children: [
        // Doctor selection button
        // Obx() makes this button reactive - it automatically rebuilds when selectedRole changes
        Obx(() => _RoleSelectionButton(
          label: 'Doctor',
          isSelected: controller.selectedRole == Role.doctor,
          onTap: () {
            // When tapped, this button:
            // 1. Updates the selected role to doctor
            // 2. Triggers background image change
            // 3. Updates button appearance
            controller.selectRole(Role.doctor);
          },
        )),
        
        // Spacing between buttons
        const SizedBox(height: AppSizes.roleSelectionButtonSpacing),
        
        // Patient selection button
        // Same reactive pattern as doctor button
        Obx(() => _RoleSelectionButton(
          label: 'Patient',
          isSelected: controller.selectedRole == Role.patient,
          onTap: () {
            // When tapped, this button:
            // 1. Updates the selected role to patient
            // 2. Triggers background image change
            // 3. Updates button appearance
            controller.selectRole(Role.patient);
          },
        )),
      ],
    );
  }

  /// Continue button that handles validation and navigation
  /// This button validates the user's selection and navigates to the appropriate screen
  Widget _buildContinueButton(PatientSigninController controller) {
    return SizedBox(
      width: double.infinity, // Button takes full width
      height: AppSizes.continueButtonHeight,
      child: Obx(() => ElevatedButton(
        // The button's behavior: validate selection then navigate
        onPressed: controller.handleContinue,
        
        style: ElevatedButton.styleFrom(
          // DYNAMIC STYLING: Button appearance changes based on whether role is selected
          backgroundColor: controller.selectedRole != Role.none 
              ? AppColors.primaryColor                    // Full color when role selected
              : AppColors.primaryColor.withOpacity(0.7), // Dimmed when no role selected
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSizes.continueButtonBorderRadius,
            ),
          ),
          textStyle: AppTextStyles.continueButtonTextStyle,
          // More elevation when active, less when inactive
          elevation: controller.selectedRole != Role.none ? 2 : 1,
          splashFactory: InkRipple.splashFactory,
        ),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show arrow icon only when role is selected
            if (controller.selectedRole != Role.none)
              const Icon(Icons.arrow_forward, size: 20),
            if (controller.selectedRole != Role.none)
              const SizedBox(width: 8),
            
            // DYNAMIC TEXT: Button text changes based on selection state
            Text(controller.selectedRole != Role.none 
                ? 'Continue as ${controller.selectedRole == Role.doctor ? 'Doctor' : 'Patient'}'
                : 'Select Role to Continue'),
          ],
        ),
      )),
    );
  }
}

/// Role enum definition
/// This enum defines the possible states for user role selection
enum Role1 { 
  none,    // Initial state - no role selected yet
  doctor,  // Medical professional role
  patient  // Regular patient/user role
}

/// Main signup screen widget
/// This is the main screen widget that users interact with
class Patientsignup1 extends StatelessWidget {
  const Patientsignup1({super.key});

  @override
  Widget build(BuildContext context) {
    // CONTROLLER INITIALIZATION
    // GetBuilder automatically manages the controller lifecycle
    // It creates the controller, provides it to the widget, and disposes it when done
    return GetBuilder<PatientSigninController>(
      init: PatientSigninController(),
      builder: (controller) {
        return Scaffold(
          // LAYERED DESIGN using Stack
          // Stack allows us to layer widgets on top of each other
          body: Stack(
            children: [
              // LAYER 1 (Bottom): Dynamic background image
              _buildBackgroundImage(controller),
              // LAYER 2 (Middle): Back button
              _buildBackButton(controller),
              // LAYER 3 (Top): Bottom panel with role selection
              _buildBottomPanel(controller),
            ],
          ),
        );
      },
    );
  }

  // ====== UI COMPONENT BUILDING METHODS ======

  /// Background image that covers the entire screen
  /// ENHANCED: Now changes dynamically based on selected role
  Widget _buildBackgroundImage(PatientSigninController controller) {
    return Positioned.fill(
      child: Obx(() => AnimatedSwitcher(
        // SMOOTH IMAGE TRANSITIONS
        // This widget smoothly transitions between different images
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          // Fade transition between different background images
          return FadeTransition(opacity: animation, child: child);
        },
        
        child: Image.asset(
          // DYNAMIC IMAGE SELECTION
          // The image changes based on the selected role:
          // - Doctor role: shows 'signup.png'
          // - Patient role: shows 'patient.png'
          // - No selection: shows default 'signup.png'
          controller.getBackgroundImagePath(),
          
          // IMPORTANT: Key is required for AnimatedSwitcher to detect changes
          key: ValueKey(controller.selectedRole),
          fit: BoxFit.cover, // Ensures image covers entire screen without distortion
          
          // ERROR HANDLING: What to show if image file is missing
          errorBuilder: (context, error, stackTrace) {
            // Log error for debugging
            print('Error loading image: ${controller.getBackgroundImagePath()}');
            print('Error details: $error');
            
            // Show fallback UI if image fails to load
            return Container(
              color: AppColors.primaryAccent ?? Colors.blue.shade100,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Image not found',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )),
    );
  }

  /// Back button positioned at top-left with safe area
  /// This button allows users to navigate back to the previous screen
  Widget _buildBackButton(PatientSigninController controller) {
    return SafeArea(
      // SafeArea ensures button doesn't overlap with status bar
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSizes.chooseSignupBackButtonPaddingLeft,
          top: AppSizes.chooseSignupBackButtonPaddingTop,
        ),
        child: IconButton(
          onPressed: controller.goBack, // Navigate back when pressed
          style: IconButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppSizes.chooseSignupBackButtonBorderRadius,
              ),
            ),
          ),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: AppSizes.chooseSignupBackButtonIconSize,
          ),
        ),
      ),
    );
  }

  /// Bottom panel with slide and fade animations
  /// This panel contains all the interactive content and animates in from the bottom
  Widget _buildBottomPanel(PatientSigninController controller) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SlideTransition(
        // SLIDE ANIMATION: Panel slides up from bottom of screen
        position: controller.slideAnimation,
        child: Container(
          // PANEL STYLING
          padding: const EdgeInsets.fromLTRB(
            AppSizes.chooseSignupPanelPaddingHorizontal,
            AppSizes.chooseSignupPanelPaddingTop,
            AppSizes.chooseSignupPanelPaddingHorizontal,
            AppSizes.chooseSignupPanelPaddingBottom,
          ),
          decoration: const BoxDecoration(
            color: AppColors.chooseSignupBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.chooseSignupPanelBorderRadius),
              topRight: Radius.circular(AppSizes.chooseSignupPanelBorderRadius),
            ),
          ),
          child: FadeTransition(
            // FADE ANIMATION: Content fades in as panel slides up
            opacity: controller.fadeAnimation,
            child: _buildPanelContent(controller),
          ),
        ),
      ),
    );
  }

  /// Content inside the bottom panel
  /// This organizes all the interactive elements in a vertical layout
  Widget _buildPanelContent(PatientSigninController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Only take space needed
      children: [
        // SECTION 1: Header with title and close button
        _buildHeader(controller),
        const SizedBox(height: AppSizes.chooseSignupHeaderVerticalSpacing),
        
        // SECTION 2: Role selection buttons
        _buildRoleSelectionButtons(controller),
        const SizedBox(height: AppSizes.continueButtonSpacing),
        
        // SECTION 3: Continue button
        _buildContinueButton(controller),
      ],
    );
  }

  /// Header with title and close button
  /// This creates the top section of the panel
  Widget _buildHeader(PatientSigninController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left spacer to center the title
        const SizedBox(width: AppSizes.chooseSignupHeaderSpacerWidth),
        
        // Main title text
        const Text(
          'Sign In As',
          style: AppTextStyles.chooseSignupHeaderStyle,
        ),
        
        // Close button on the right
        IconButton(
          onPressed: controller.goBack,
          icon: const Icon(
            Icons.close,
            color: AppColors.textColorBlack,
            size: AppSizes.chooseSignupCloseIconSize,
          ),
        ),
      ],
    );
  }

  /// Role selection buttons with reactive updates
  /// These buttons allow users to choose between Doctor and Patient roles
  Widget _buildRoleSelectionButtons(PatientSigninController controller) {
    return Column(
      children: [
        // DOCTOR BUTTON
        // Obx() makes this button reactive to state changes
        Obx(() => _RoleSelectionButton(
          label: 'Doctor',
          isSelected: controller.selectedRole == Role.doctor,
          onTap: () {
            // BUTTON ACTION: Select doctor role
            // This will trigger:
            // 1. Role state update
            // 2. Background image change to 'signup.png'
            // 3. Button appearance update
            controller.selectRole(Role.doctor);
          },
        )),
        
        // Spacing between buttons
        const SizedBox(height: AppSizes.roleSelectionButtonSpacing),
        
        // PATIENT BUTTON
        // Same reactive pattern as doctor button
        Obx(() => _RoleSelectionButton(
          label: 'Patient',
          isSelected: controller.selectedRole == Role.patient,
          onTap: () {
            // BUTTON ACTION: Select patient role
            // This will trigger:
            // 1. Role state update
            // 2. Background image change to 'patient.png'
            // 3. Button appearance update
            controller.selectRole(Role.patient);
          },
        )),
      ],
    );
  }

  /// Continue button that handles validation and navigation
  /// This button becomes active only when a role is selected
  Widget _buildContinueButton(PatientSigninController controller) {
    return SizedBox(
      width: double.infinity, // Full width button
      height: AppSizes.continueButtonHeight,
      child: Obx(() => ElevatedButton(
        // MAIN ACTION: Validate selection and navigate
        onPressed: controller.handleContinue,
        
        style: ElevatedButton.styleFrom(
          // DYNAMIC STYLING based on selection state
          backgroundColor: controller.selectedRole != Role.none 
              ? AppColors.primaryColor                    // Active state
              : AppColors.primaryColor.withOpacity(0.7), // Inactive state
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSizes.continueButtonBorderRadius,
            ),
          ),
          textStyle: AppTextStyles.continueButtonTextStyle,
          elevation: controller.selectedRole != Role.none ? 2 : 1,
          splashFactory: InkRipple.splashFactory,
        ),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show arrow icon only when role is selected
            if (controller.selectedRole != Role.none)
              const Icon(Icons.arrow_forward, size: 20),
            if (controller.selectedRole != Role.none)
              const SizedBox(width: 8),
            
            // DYNAMIC TEXT based on selection
            Text(controller.selectedRole != Role.none 
                ? 'Continue as ${controller.selectedRole == Role.doctor ? 'Doctor' : 'Patient'}'
                : 'Select Role to Continue'),
          ],
        ),
      )),
    );
  }
}

/// Custom widget for role selection buttons with improved animations
/// This is a reusable button component for role selection
class _RoleSelectionButton extends StatelessWidget {
  const _RoleSelectionButton({
    required this.label,      // Text to display (e.g., "Doctor", "Patient")
    required this.isSelected, // Whether this button is currently selected
    required this.onTap,      // Function to call when button is tapped
  });

  final String label;        // The text label for the button
  final bool isSelected;     // Current selection state
  final VoidCallback onTap;  // Callback function for tap events

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // TOUCH HANDLING
      onTap: onTap, // Execute the provided callback when tapped
      borderRadius: BorderRadius.circular(AppSizes.roleSelectionButtonBorderRadius),
      
      // VISUAL FEEDBACK for user interactions
      splashColor: AppColors.roleSelectionSelectedColor.withOpacity(0.1),
      highlightColor: AppColors.roleSelectionSelectedColor.withOpacity(0.05),
      
      child: AnimatedContainer(
        // SMOOTH ANIMATIONS when selection state changes
        duration: AppDurations.roleSelectionAnimationDuration,
        curve: Curves.easeInOut,
        width: double.infinity,
        height: AppSizes.roleSelectionButtonHeight,
        
        decoration: BoxDecoration(
          // DYNAMIC COLORS based on selection state
          color: isSelected
              ? AppColors.roleSelectionSelectedColor    // Selected state color
              : AppColors.roleSelectionUnselectedColor, // Unselected state color
          borderRadius: BorderRadius.circular(AppSizes.roleSelectionButtonBorderRadius),
          
          border: Border.all(
            color: isSelected
                ? AppColors.roleSelectionSelectedColor
                : AppColors.roleSelectionUnselectedBorderColor,
            width: AppSizes.roleSelectionButtonBorderWidth,
          ),
          
          // SUBTLE SHADOW for selected state (adds depth)
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.roleSelectionSelectedColor.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null, // No shadow when not selected
        ),
        
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ROLE-SPECIFIC ICONS
              Icon(
                // Different icons for different roles
                label == 'Doctor' ? Icons.local_hospital : Icons.person,
                color: isSelected ? Colors.white : Colors.black,
                size: 20,
              ),
              const SizedBox(width: 8),
              
              // ANIMATED TEXT with dynamic styling
              AnimatedDefaultTextStyle(
                duration: AppDurations.roleSelectionAnimationDuration,
                style: AppTextStyles.roleSelectionButtonTextStyle.copyWith(
                  // Text color changes based on selection
                  color: isSelected ? Colors.white : Colors.black,
                  // Text weight changes based on selection
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                child: Text(label),
              ),
              
              // CHECK MARK ICON (only shown when selected)
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