import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/routes/approutes.dart';
import 'package:healio_version_2/core/constants/appcolors.dart';
import 'package:healio_version_2/core/constants/appdurations.dart';
import 'package:healio_version_2/core/constants/appsizes.dart';

class Splashpage2 extends StatefulWidget {
  const Splashpage2({super.key});

  @override
  State<Splashpage2> createState() => _Splashpage2State();
}

class _Splashpage2State extends State<Splashpage2>
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

    // Automatically navigate after a delay
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
    _navigationTimer?.cancel();
    if (mounted) {
      Get.offNamed(AppRoutes.welcomePage1);
    }
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
              'lib/assets/images/onboarding/Splash 2.png',
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