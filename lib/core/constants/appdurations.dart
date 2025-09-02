class AppDurations {
  static const Duration simulatedNetworkDelay = Duration(seconds: 1);

  // ChooseSignup Page specific durations (reused for ChooseSignin)
  static const Duration chooseSignupSlideAnimationDuration = Duration(milliseconds: 800);
  static const double chooseSignupFadeAnimationIntervalStart = 0.3;
  static const double chooseSignupFadeAnimationIntervalEnd = 1.0;
  static const Duration chooseSignupPageTransitionDuration = Duration(milliseconds: 400);
  static const Duration roleSelectionAnimationDuration = Duration(milliseconds: 200);

  // SignIn Page specific durations
  static const Duration signInSimulatedDelay = Duration(seconds: 1);

  // ChooseSignin Page specific durations (new)
  static const Duration chooseSigninSlideAnimationDuration = Duration(milliseconds: 800); // Reusing
  static const double chooseSigninFadeAnimationIntervalStart = 0.3; // Reusing
  static const double chooseSigninFadeAnimationIntervalEnd = 1.0; // Reusing
  static const Duration chooseSigninPageTransitionDuration = Duration(milliseconds: 400); // Reusing
  static const Duration chooseSigninRoleSelectionAnimationDuration = Duration(milliseconds: 200); // Reusing

  // Splashpage specific durations (reused for Splashpage2)
  static const Duration splashAnimationControllerDuration = Duration(seconds: 2);
  static const Duration splashNavigationDelay = Duration(seconds: 4);
  static const Duration splashPageTransitionDuration = Duration(milliseconds: 800);

  // Splashpage3 specific durations
  static const Duration splash3ControllerDuration = Duration(milliseconds: 1200);
  static const Duration splash3PageTransitionDuration = Duration(milliseconds: 500);
  static const double splash3SignUpFadeIntervalEnd = 0.7;
  static const double splash3LoginFadeIntervalStart = 0.3;
  static const double splash3LoginFadeIntervalEnd = 1.0;
  static const double splash3SignUpSlideIntervalEnd = 0.7;
  static const double splash3LoginSlideIntervalStart = 0.3;
  static const double splash3LoginSlideIntervalEnd = 1.0;
}
