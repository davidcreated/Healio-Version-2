
import 'package:flutter/material.dart';
import 'package:healio_version_2/core/constants/appcolors.dart';
import 'package:healio_version_2/core/constants/appsizes.dart';

class AppTextStyles {



// Splashpage3 specific text styles
  static const TextStyle splash3ButtonTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

    // WelcomePage and WelcomePage2 specific text styles
  static const TextStyle welcomePageSkipTextStyle = TextStyle(
    fontSize: AppSizes.welcomePageSkipFontSize,
    color: AppColors.textColorBlack87,
    fontWeight: FontWeight.w800,
    fontFamily: 'Notosans',
  );


  // ChooseSignin Page specific text styles
  static final TextStyle chooseSigninHeaderStyle = TextStyle(
    fontSize: AppSizes.chooseSignupHeaderFontSize,
    fontWeight: FontWeight.w700,
    fontFamily: 'NotoSans',
    color: AppColors.chooseSignupHeaderColor,
  );

  static const TextStyle chooseSigninRoleButtonTextStyle = TextStyle(
    fontFamily: "Notosans",
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.roleSelectionTextColor,
  );

  static final TextStyle chooseSigninContinueButtonTextStyle = TextStyle(
    fontFamily: "Notosans",
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: Colors.white,
  );


  // AppointmentPage specific text styles
  static const TextStyle appointmentPageHeaderStyle = TextStyle( // New
    color: AppColors.appointmentPageHeaderColor,
    fontWeight: FontWeight.w500,
    fontSize: AppSizes.appointmentPageHeaderFontSize,
    fontFamily: 'NotoSans',
  );

  static const TextStyle appointmentPageDoctorNameStyle = TextStyle( // New
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w600,
    fontSize: AppSizes.appointmentPageDoctorNameFontSize,
    color: AppColors.appointmentPageDoctorNameColor,
  );

  static const TextStyle appointmentPageDoctorSpecialtyStyle = TextStyle( // New
    color: AppColors.appointmentPageSpecialtyTextColor,
    fontSize: AppSizes.appointmentPageSpecialtyFontSize,
    fontFamily: 'NotoSans',
  );

  static const TextStyle appointmentPageDoctorLocationStyle = TextStyle( // New
    color: AppColors.appointmentPageLocationTextColor,
    fontSize: AppSizes.appointmentPageLocationFontSize,
    fontFamily: 'NotoSans',
  );

  static const TextStyle appointmentPageDoctorHospitalStyle = TextStyle( // New
    color: AppColors.appointmentPageHospitalTextColor,
    fontSize: AppSizes.appointmentPageHospitalFontSize,
    fontFamily: 'NotoSans',
  );

  static const TextStyle appointmentPageDoctorOnlineStatusStyle = TextStyle( // New
    color: AppColors.appointmentPageOnlineStatusTextColor,
    fontSize: AppSizes.appointmentPageOnlineStatusFontSize,
    fontFamily: 'NotoSans',
  );

  static const TextStyle appointmentPageAvailabilityHeaderStyle = TextStyle( // New
    color: AppColors.appointmentPageAvailabilitySectionHeaderColor,
    fontWeight: FontWeight.w700,
    fontSize: AppSizes.appointmentPageAvailabilityHeaderFontSize,
    fontFamily: 'NotoSans',
  );

  static const TextStyle appointmentPageSelectTimeHeaderStyle = TextStyle( // New
    color: AppColors.appointmentPageSelectTimeHeaderColor,
    fontWeight: FontWeight.w500,
    fontSize: AppSizes.appointmentPageSelectTimeHeaderFontSize,
    fontFamily: 'NotoSans',
  );

  static const TextStyle appointmentPageMonthTextStyle = TextStyle( // New
    color: AppColors.appointmentPageMonthTextColor,
    fontSize: AppSizes.appointmentPageMonthTextFontSize,
    fontFamily: 'NotoSans',
  );

  static const TextStyle appointmentPageDayOfWeekStyle = TextStyle( // New
    color: AppColors.appointmentPageDayOfWeekTextColor,
    fontWeight: FontWeight.w500,
    fontSize: AppSizes.appointmentPageDayOfWeekFontSize,
    fontFamily: 'NotoSans',
  );

  static const TextStyle appointmentPageDateSelectedStyle = TextStyle( // New
    color: AppColors.appointmentPageDateSelectedTextColor,
    fontWeight: FontWeight.w700,
    fontSize: AppSizes.appointmentPageDateFontSize,
    fontFamily: 'NotoSans',
  );

  static const TextStyle appointmentPageDateUnselectedStyle = TextStyle( // New
    color: AppColors.appointmentPageDateUnselectedTextColor,
    fontWeight: FontWeight.w700,
    fontSize: AppSizes.appointmentPageDateFontSize,
    fontFamily: 'NotoSans',
  );

  static const TextStyle appointmentPageHourMarkStyle = TextStyle( // New
    color: AppColors.appointmentPageHourMarkColor,
    fontWeight: FontWeight.w600,
    fontSize: AppSizes.appointmentPageHourMarkFontSize,
    fontFamily: 'NotoSans',
  );

  static const TextStyle appointmentPageTimeButtonSelectedStyle = TextStyle( // New
    color: AppColors.appointmentPageTimeButtonSelectedTextColor,
    fontWeight: FontWeight.w600,
    fontSize: AppSizes.appointmentPageTimeButtonFontSize,
    fontFamily: 'NotoSans',
  );

  static const TextStyle appointmentPageTimeButtonUnselectedStyle = TextStyle( // New
    color: AppColors.appointmentPageTimeButtonUnselectedTextColor,
    fontWeight: FontWeight.w600,
    fontSize: AppSizes.appointmentPageTimeButtonFontSize,
    fontFamily: 'NotoSans',
  );

  static const TextStyle appointmentPageRatingValueStyle = TextStyle( // New
    color: AppColors.appointmentPageRatingTextColor,
    fontWeight: FontWeight.w700,
    fontSize: AppSizes.appointmentPageRatingFontSize,
    fontFamily: 'NotoSans',
  );

  static const TextStyle appointmentPageRatingsCountStyle = TextStyle( // New
    color: AppColors.appointmentPageRatingsCountTextColor,
    fontSize: AppSizes.appointmentPageRatingsCountFontSize,
    fontFamily: 'NotoSans',
  );

  static const TextStyle appointmentPageBookAppointmentButtonStyle = TextStyle( // New
    color: AppColors.appointmentPageBookButtonTextColor,
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w600,
    fontSize: AppSizes.appointmentPageButtonTextFontSize,
  );

  static const TextStyle appointmentPageConsultNowButtonStyle = TextStyle( // New
    color: AppColors.appointmentPageConsultButtonTextColor,
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w600,
    fontSize: AppSizes.appointmentPageButtonTextFontSize,
  );


  static const TextStyle createAccountTitle = TextStyle(
    fontFamily: 'NotoSerif',
    fontWeight: FontWeight.bold,
    fontSize: 28,
    color: AppColors.textColorBlack87,
  );

  static final TextStyle inputHintStyle = TextStyle(
    fontSize: 14,
    color:Colors.grey[600]
  );

  static const TextStyle signUpButtonTextStyle = TextStyle(
    fontFamily: 'NotoSans',
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle termsAndPolicyTextStyle = TextStyle(
    color: AppColors.textColorBlack87,
    fontSize: 13,
    height: 1.4,
  );

  static const TextStyle termsAndPolicyLinkStyle = TextStyle(
    color: AppColors.primaryColor,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );

  static const TextStyle alreadyHaveAccountTextStyle = TextStyle(
    color: Colors.black54
  );

  static const TextStyle loginHereTextStyle = TextStyle(
    color: AppColors.primaryColor,
    fontWeight: FontWeight.bold,
  );

  // ChooseSignup Page specific text styles (reused for ChooseSignin)
  static const TextStyle chooseSignupHeaderStyle = TextStyle(
    fontSize: AppSizes.chooseSignupHeaderFontSize,
    fontWeight: FontWeight.w700,
    fontFamily: 'NotoSans',
    color: AppColors.chooseSignupHeaderColor,
  );

  static const TextStyle roleSelectionButtonTextStyle = TextStyle(
    fontFamily: "Notosans",
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.roleSelectionTextColor,
  );

  static const TextStyle continueButtonTextStyle = TextStyle(
    fontFamily: "Notosans",
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  // SignIn Page specific text styles
  static const TextStyle signInTitleStyle = TextStyle(
    fontFamily: 'NotoSerif',
    fontWeight: FontWeight.bold,
    fontSize: 28,
    color: AppColors.textColorBlack87,
  );

  static const TextStyle signInForgotPasswordStyle = TextStyle(
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle signInButtonTextStyle = TextStyle(
    fontFamily: 'NotoSans',
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle signInNoAccountTextStyle = TextStyle(
    color: Colors.black54,
  );

  static const TextStyle signInSignUpHereStyle = TextStyle(
    color: AppColors.primaryColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle signInOrSignInWithTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color:Colors.black54,
  );

  static const TextStyle signInSocialButtonTextStyle = TextStyle(
    color: AppColors.textColorBlack87,
  );

  // DoctorSignin Page specific text styles (reused for ChooseSignin)
  static const TextStyle doctorSigninHeaderStyle = TextStyle(
    fontSize: AppSizes.doctorSigninHeaderFontSize,
    fontWeight: FontWeight.w700,
    fontFamily: 'NotoSans',
    color: AppColors.chooseSignupHeaderColor,
  );

  static const TextStyle doctorSigninRoleButtonTextStyle = TextStyle(
    fontFamily: "Notosans",
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: AppColors.roleSelectionTextColor,
  );

  static const TextStyle doctorSigninContinueButtonTextStyle = TextStyle(
    fontFamily: "Notosans",
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color:Colors.white,
  );

  static var inputTextStyle;


  static const TextStyle titleTextStyle = TextStyle(
    fontFamily: 'NotoSerif',
    fontWeight: FontWeight.bold,
    fontSize: 32,
    color: Colors.black87,
  );
  
  static const TextStyle subtitleTextStyle = TextStyle(
    fontFamily: 'NotoSans',
    fontSize: 16,
    color: Colors.grey,
  );
  

}
 


















