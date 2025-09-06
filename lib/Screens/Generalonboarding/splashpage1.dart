import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/Screens/Generalonboarding/splash2.dart';
import 'package:healio_version_2/core/constants/appcolors.dart';
import 'package:healio_version_2/core/constants/appdurations.dart';
import 'package:healio_version_2/core/constants/appsizes.dart';

// Your custom constants

class splashpage1 extends StatefulWidget {
  const splashpage1({super.key});

  @override
  State<splashpage1> createState() => _splashpage1State();
}

class _splashpage1State extends State<splashpage1>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: AppDurations.splashAnimationControllerDuration,
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = Tween<double>(
      begin: AppSizes.splashScaleAnimationBegin,
      end: AppSizes.splashScaleAnimationEnd,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();

    _navigationTimer = Timer(
      AppDurations.splashNavigationDelay,
      _navigateToNextPage,
    );
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _navigateToNextPage() {
    if (!mounted) return;

    Get.off(() => const Splashpage2(),
        transition: Transition.fade,
        duration: AppDurations.splashPageTransitionDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryAccent,
      body: GestureDetector(
        onTap: _navigateToNextPage,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              'lib/assets/images/onboarding/Splash 1.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
