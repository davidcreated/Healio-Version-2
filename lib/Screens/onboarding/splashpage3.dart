import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/Screens/signin/patientsignin.dart';
import 'package:healio_version_2/Screens/signup/patientsignup.dart';
import 'package:healio_version_2/core/constants/appcolors.dart';
import 'package:healio_version_2/core/constants/appdurations.dart';
import 'package:healio_version_2/core/constants/appsizes.dart';
import 'package:healio_version_2/core/constants/apptextstyles.dart';

class Splashpage3 extends StatefulWidget {
  const Splashpage3({super.key});

  @override
  State<Splashpage3> createState() => _Splashpage3State();
}

class _Splashpage3State extends State<Splashpage3>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _signUpFadeAnimation;
  late final Animation<Offset> _signUpSlideAnimation;
  late final Animation<double> _loginFadeAnimation;
  late final Animation<Offset> _loginSlideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: AppDurations.splash3ControllerDuration,
      vsync: this,
    );

    // Animation for the "Sign Up" button
    _signUpFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          AppDurations.splash3SignUpFadeIntervalEnd,
          curve: Curves.easeOut,
        ),
      ),
    );
    _signUpSlideAnimation = Tween<Offset>(
      begin: const Offset(0, AppSizes.splash3SlideAnimationOffsetY),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          AppDurations.splash3SignUpSlideIntervalEnd,
          curve: Curves.easeOut,
        ),
      ),
    );

    // Staggered animation for the "Login" button
    _loginFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          AppDurations.splash3LoginFadeIntervalStart,
          AppDurations.splash3LoginFadeIntervalEnd,
          curve: Curves.easeOut,
        ),
      ),
    );
    _loginSlideAnimation = Tween<Offset>(
      begin: const Offset(0, AppSizes.splash3SlideAnimationOffsetY),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          AppDurations.splash3LoginSlideIntervalStart,
          AppDurations.splash3LoginSlideIntervalEnd,
          curve: Curves.easeOut,
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateTo(Widget page) {
    Get.to(
      () => page,
      transition: Transition.fade,
      duration: AppDurations.splash3PageTransitionDuration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryAccent,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/images/onboarding/Onboarding 3.png',
                width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
          // Buttons aligned to bottom center
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: AppSizes.splash3BottomPadding,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Sign Up Button with slide and fade animation
                  SlideTransition(
                    position: _signUpSlideAnimation,
                    child: FadeTransition(
                      opacity: _signUpFadeAnimation,
                      child: ElevatedButton(
                        onPressed: () => _navigateTo(const Patientsignup()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primaryDark,
                          minimumSize: const Size(
                            AppSizes.splash3ButtonWidth,
                            AppSizes.splash3ButtonHeight,
                          ),
                          side: const BorderSide(color: AppColors.primaryDark),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.splash3ButtonBorderRadius,
                            ),
                          ),
                          textStyle: AppTextStyles.splash3ButtonTextStyle,
                        ),
                        child: const Text('Sign Up'),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.splash3ButtonSpacing),
                  // Login Button with slide and fade animation
                  SlideTransition(
                    position: _loginSlideAnimation,
                    child: FadeTransition(
                      opacity: _loginFadeAnimation,
                      child: ElevatedButton(
                        onPressed: () => _navigateTo(const Patientsignin()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primaryDark,
                          minimumSize: const Size(
                            AppSizes.splash3ButtonWidth,
                            AppSizes.splash3ButtonHeight,
                          ),
                          side: const BorderSide(
                            color: AppColors.primaryDark,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.splash3ButtonBorderRadius,
                            ),
                          ),
                          textStyle: AppTextStyles.splash3ButtonTextStyle,
                        ),
                        child: const Text('Login'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
