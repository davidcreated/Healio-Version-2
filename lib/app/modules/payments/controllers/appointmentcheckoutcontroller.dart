import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Appointmentcheckoutcontroller extends GetxController {
  // Simple reactive variables with default values
  final RxBool isProcessingPayment = false.obs;
  final RxInt selectedDurationHours = 2.obs;
  
  // Mock doctor data for MVP
  final String doctorName = 'Dr. Sarah Udy';
  final String doctorSpecialization = 'Cardiologist';
  final String doctorLocation = 'Uyo Nigeria';
  final String doctorHospital = 'University of Uyo Teaching Hospital';
  final String doctorImage = 'lib/assets/images/doctors/Doctor img.png';
  final double pricePerHour = 10000.0;
  final bool isOnline = true;

  // Getters for calculated values
  double get totalPrice => pricePerHour * selectedDurationHours.value;

  String get formattedDate => 'Monday October 14th 2024';
  String get formattedTime => '9:30 AM GMT+1';

  String formatPrice(double price) {
    return '₦${price.toInt().toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), 
      (Match m) => '${m[1]},'
    )}';
  }

  // Duration control methods
  void increaseDuration() {
    if (selectedDurationHours.value < 8) {
      selectedDurationHours.value++;
    }
  }

  void decreaseDuration() {
    if (selectedDurationHours.value > 1) {
      selectedDurationHours.value--;
    }
  }

  // Navigation methods
  void goBack() {
    Get.back();
  }

  void processCheckout() {
    isProcessingPayment.value = true;

    // Simulate processing delay for MVP demo
    Future.delayed(const Duration(seconds: 2), () {
      isProcessingPayment.value = false;
      
      // Show success message for MVP
      Get.snackbar(
        'Success',
        'Proceeding to payment...',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16),
      );

      // Navigate to next page (you can replace with your actual route)
       Get.toNamed('/consultationpaymentselectionpage');
    });
  }

  // Policy methods (simplified)
  void viewPaymentPolicy() {
    Get.dialog(
      AlertDialog(
        title: const Text('Payment Policy'),
        content: const Text(
          'Payment Policy:\n\n'
          '• Full payment required at booking\n'
          '• 24-hour cancellation policy\n'
          '• Refunds processed in 5-7 days\n\n'
          'Contact support for more details.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void viewTermsOfService() {
    Get.dialog(
      AlertDialog(
        title: const Text('Terms of Service'),
        content: const Text(
          'Terms of Service:\n\n'
          '• Medical consultations are informational\n'
          '• Patient confidentiality maintained\n'
          '• Professional conduct expected\n\n'
          'Read full terms on our website.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}