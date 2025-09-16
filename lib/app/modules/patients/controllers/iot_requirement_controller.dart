import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/connectIOT.dart';

import 'package:url_launcher/url_launcher.dart';

/// Controller for the IOTSystemRequirementPage
/// Manages navigation and launching external URLs.
class IotRequirementController extends GetxController {

  /// Launches the provided URL in an external browser.
  /// Shows a snackbar on failure.
  Future<void> launchProductUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Show an error message if the URL can't be launched
      Get.snackbar(
        'Error',
        'Could not launch URL',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Navigates to the page for connecting the IoT device.
  void continueToConnectPage() {
   Get.to(() => const ConnectIOTPage());
  }
}