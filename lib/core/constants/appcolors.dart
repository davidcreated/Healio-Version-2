// lib/core/constants/color_constants.dart
import 'package:flutter/material.dart';

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors - Based on your Figma design
  static const Color primaryBlue = Color(0xFF2E7BF0); // Main blue from your design
  static const Color primaryDark = Color(0xFF1E5BA8);
    static const Color primaryColor = Color(0xFF002180);
  static const Color primaryLight = Color(0xFF5A9BF5);
  static const Color primaryAccent = Color(0xFFE8F3FF);
    static const Color textColorBlack87 = Colors.black87;
      static const Color textColorBlack = Colors.black; // Added for general black text

  // Secondary Colors
  static const Color secondaryTeal = Color(0xFF00B8A9);
  static const Color secondaryGreen = Color(0xFF4CAF50);
  static const Color secondaryMint = Color(0xFFE8F8F5);
  
  // Status Colors
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFF6B35);
  static const Color error = Color(0xFFDC3545);
  static const Color info = Color(0xFF17A2B8);
  
  // Background Colors - From your design
  static const Color background = Color(0xFFF8FAFB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF5F7FA);
  static const Color surfaceDark = Color(0xFFE9ECEF);
  
  // Text Colors - Matching your design
  static const Color textPrimary = Color(0xFF1A1D29);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSurface = Color(0xFF1A1D29);
  
  // Border Colors
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderLight = Color(0xFFF3F4F6);
  static const Color borderActive = Color(0xFF2E7BF0);
  static const Color divider = Color(0xFFE5E7EB);
  
  // Medical Status Colors
  static const Color appointmentActive = Color(0xFF10B981);
  static const Color appointmentPending = Color(0xFFF59E0B);
  static const Color appointmentCancelled = Color(0xFFEF4444);
  static const Color appointmentCompleted = Color(0xFF6366F1);
  
  // Chat Colors - Based on your chat interface
  static const Color chatBubbleUser = Color(0xFF2E7BF0);
  static const Color chatBubbleDoctor = Color(0xFFE8F3FF);
  static const Color chatBubbleSystem = Color(0xFFF9FAFB);
  static const Color onlineIndicator = Color(0xFF10B981);
  static const Color offlineIndicator = Color(0xFF9CA3AF);
  
  // Card Colors
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardShadow = Color(0x0A000000);
  
  // Gradient Colors - Matching your blue theme
  static const List<Color> primaryGradient = [
    Color(0xFF2E7BF0),
    Color(0xFF1E5BA8),
  ];
  
  static const List<Color> lightGradient = [
    Color(0xFFE8F3FF),
    Color(0xFFF8FAFB),
  ];
  
  // Icon Colors
  static const Color iconPrimary = Color(0xFF6B7280);
  static const Color iconActive = Color(0xFF2E7BF0);
  static const Color iconInactive = Color(0xFF9CA3AF);



    // WelcomePage and WelcomePage2 specific colors
  static const Color welcomePageBackgroundColor = Color(0xFFEEEEEE);
  static const Color welcomePageActiveDotColor = Color(0xFF0033A1);
  static const Color welcomePageInactiveDotColor = Colors.grey;


 // ChooseSignup and ChooseSignin Page specific colors (reused)
  static const Color chooseSignupBackgroundColor = Color(0xFFEEEEEE);
  static const Color chooseSignupHeaderColor = Color(0xFF555555);
  static const Color roleSelectionSelectedColor = Color(0xFF32F3CE);
  static const Color roleSelectionUnselectedColor = Colors.white;
  static const Color roleSelectionUnselectedBorderColor = Colors.black;
  static const Color roleSelectionTextColor = Color(0xFF2D2D2D);




  // SignIn Page specific colors
  static const Color signInInputUnderlineColor = Color(0xE2190B99);
  static const Color signInDividerColor = Colors.black26;

  // Splashpage specific colors
  static const Color splashBackgroundColor = Colors.white;

  // Splashpage2 specific colors
  static const Color splash2BackgroundColor = Color(0xFF0D074B);

  // Splashpage3 specific colors
  static const Color splash3BackgroundColor = Color(0xFFF5F5F5);
  static const Color splash3LoginButtonColor = Color(0xFF130A54);


  // AppointmentPage specific colors
  static const Color appointmentPageBackgroundColor = Colors.white; // New
  static const Color appointmentPageTopBarColor = Color(0xFF002180); // New
  static const Color appointmentPageTopBarIconColor = Colors.white; // New
  static const Color appointmentPageHeaderColor = Color(0xFF061234); // New
  static const Color appointmentPageDoctorCardBackgroundColor = Color(0xFFF5F7FB); // New
  static const Color appointmentPageDoctorCardBorderColor = Color(0xFFD6E0F5); // New
  static const Color appointmentPageOnlineIndicatorOuterColor = Colors.white; // New
  static const Color appointmentPageOnlineIndicatorInnerColor = Color(0xFF05BB98); // New
  static const Color appointmentPageDoctorNameColor = Color(0xFF061234); // New
  static const Color appointmentPageVerifiedIconColor = Color(0xFF2735FD); // New
  static const Color appointmentPageSpecialtyIconColor = Color(0xFFE91E63); // New
  static const Color appointmentPageSpecialtyTextColor = Color(0xFF686868); // New
  static const Color appointmentPageLocationIconColor = Color(0xFF1BF2C9); // New
  static const Color appointmentPageLocationTextColor = Color(0xFF686868); // New
  static const Color appointmentPageHospitalIconColor = Color(0xFF2735FD); // New
  static const Color appointmentPageHospitalTextColor = Color(0xFF061234); // New
  static const Color appointmentPageOnlineStatusIconColor = Color(0xFF05BB98); // New
  static const Color appointmentPageOnlineStatusTextColor = Color(0xFF05BB98); // New
  static const Color appointmentPageAvailabilitySectionHeaderColor = Color(0xFF061234); // New
  static const Color appointmentPageSelectTimeHeaderColor = Color(0xFF061234); // New
  static const Color appointmentPageChevronIconColor = Color(0xFF002180); // New
  static const Color appointmentPageMonthTextColor = Color(0xFF686868); // New
  static const Color appointmentPageCalendarBackgroundColor = Color(0xFFF5F7FB); // New
  static const Color appointmentPageCalendarBorderColor = Color(0xFFD6E0F5); // New
  static const Color appointmentPageDayOfWeekTextColor = Color(0xFF686868); // New
  static const Color appointmentPageDateSelectedColor = Color(0xFF002180); // New
  static const Color appointmentPageDateUnselectedColor = Colors.white; // New
  static const Color appointmentPageDateSelectedTextColor = Colors.white; // New
  static const Color appointmentPageDateUnselectedTextColor = Color(0xFF061234); // New
  static const Color appointmentPageClockFaceColor = Colors.white; // New
  static const Color appointmentPageClockFaceBorderColor = Color(0xFFD6E0F5); // New
  static const Color appointmentPageClockFaceShadowColor = Colors.black; // New
  static const Color appointmentPageHourMarkColor = Color(0xFF061234); // New
  static const Color appointmentPageClockHandColor = Color(0xFF002180); // New
  static const Color appointmentPageCenterDotColor = Color(0xFF002180); // New
  static const Color appointmentPageCenterDotBorderColor = Colors.white; // New
  static const Color appointmentPageTimeButtonSelectedColor = Color(0xFF002180); // New
  static const Color appointmentPageTimeButtonUnselectedColor = Colors.white; // New
  static const Color appointmentPageTimeButtonBorderColor = Color(0xFFD6E0F5); // New
  static const Color appointmentPageTimeButtonShadowColor = Color(0xFF002180); // New
  static const Color appointmentPageTimeButtonSelectedTextColor = Colors.white; // New
  static const Color appointmentPageTimeButtonUnselectedTextColor = Color(0xFF061234); // New
  static const Color appointmentPageRatingBackgroundColor = Color(0xFFFFF6E3); // New
  static const Color appointmentPageRatingTextColor = Color(0xFFFFC107); // New
  static const Color appointmentPageRatingsCountTextColor = Color(0xFF686868); // New
  static const Color appointmentPageBookButtonColor = Color(0xFF002180); // New
  static const Color appointmentPageBookButtonTextColor = Colors.white; // New
  static const Color appointmentPageConsultButtonColor = Colors.white; // New
  static const Color appointmentPageConsultButtonBorderColor = Color(0xFF002180); // New
  static const Color appointmentPageConsultButtonTextColor = Color(0xFF002180); // New
}


