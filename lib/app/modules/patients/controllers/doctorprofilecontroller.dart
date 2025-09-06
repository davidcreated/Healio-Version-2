import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controller for Doctor Profile Page
/// Manages doctor data, ratings, availability, and user interactions
class DoctorProfileController extends GetxController {
  
  // DOCTOR INFORMATION - In real app, this would come from API/database
  final String doctorName = 'Dr. Sarah Udy';
  final String specialization = 'Cardiologist';
  final String location = 'Uyo Nigeria';
  final String hospital = 'University of Uyo Teaching Hospital';
  final String status = 'Online';
  final String doctorImage = 'lib/assets/images/doctors/Doctor img.png'; // Update with your asset path
  final bool isVerified = true;
  final bool isOnline = true;
  
  // DOCTOR STATISTICS
  final String patientCount = '1.2k';
  final String experience = '8 Years';
  final String reviewCount = '2.3k';
  final String rating = '4.9/5';
  final String totalRatings = '(2.3k ratings)';
  
  // ABOUT SECTION
  final String aboutText = "Hello, I'm Dr. Sarah. I have been in practice for 8 years "
      "handling all forms of heart diseases including hypertension, "
      "coronary artery disease, and heart failure, providing "
      "compassionate care and innovative treatment solutions.";
  
  // CONSULTATION PRICING
  final String consultationFee = '₦10,000/hr';
  
  // REACTIVE STATE VARIABLES
  final _isLoading = false.obs;
  final _isBookingInProgress = false.obs;
  
  // GETTERS
  bool get isLoading => _isLoading.value;
  bool get isBookingInProgress => _isBookingInProgress.value;
  
  /// Navigate back to previous screen
  void goBack() {
    Get.back();
  }
  
  /// Navigate to availability/booking page
  void navigateToAvailability() {
    // TODO: Implement navigation to availability page
    // Get.to(() => const DoctorAvailabilityPage());
    Get.snackbar(
      'Navigation',
      'Navigate to appointment booking',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
  
  /// Navigate to ratings and reviews page
  void navigateToReviews() {
    // TODO: Implement navigation to reviews page
    // Get.to(() => const DoctorReviewsPage());
    Get.snackbar(
      'Navigation',
      'Navigate to ratings and reviews',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
  
  /// Handle consultation booking
  Future<void> bookConsultation() async {
    _isBookingInProgress.value = true;
    
    try {
      // TODO: Implement actual booking logic
      // Example: await BookingService.bookConsultation(doctorId);
      
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Navigate to payment/checkout page
      // TODO: Replace with your actual payment page
      // Get.to(() => const PaymentCheckoutPage());
      
      Get.snackbar(
        'Booking Initiated',
        'Proceeding to payment for consultation with $doctorName',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      
    } catch (error) {
      // Handle booking errors
      Get.snackbar(
        'Booking Failed',
        'Unable to book consultation. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      _isBookingInProgress.value = false;
    }
  }
  
  /// Add doctor to favorites (if implemented)
  void toggleFavorite() {
    // TODO: Implement favorite functionality
    Get.snackbar(
      'Favorite',
      'Doctor added to favorites',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
  
  /// Share doctor profile
  void shareProfile() {
    // TODO: Implement share functionality
    Get.snackbar(
      'Share',
      'Share doctor profile functionality',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
  
  /// Get appropriate status color
  Color getStatusColor() {
    return isOnline ? const Color(0xFF05BB98) : Colors.grey;
  }
  
  /// Get status icon
  IconData getStatusIcon() {
    return isOnline ? Icons.person : Icons.person_off;
  }
  
  /// Format consultation fee for display
  String getFormattedConsultationFee() {
    return 'Consult now $consultationFee';
  }
}