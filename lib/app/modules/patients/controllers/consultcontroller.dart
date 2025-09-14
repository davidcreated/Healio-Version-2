import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/appointmentpage.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/consultcheckutpage.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/reviewpage.dart';

/// Controller for Doctor Profile Page
/// Manages doctor data, ratings, availability, and user interactions
class ConsultController extends GetxController {
  
  // DYNAMIC DOCTOR INFORMATION - Will be set based on passed arguments
  late String doctorName;
  late String specialization;
  late String location;
  late String hospital;
  late String status;
  late String doctorImage;
  late bool isVerified;
  late bool isOnline;
  late String bookingType; // 'appointment' or 'consultation'
  
  // DOCTOR STATISTICS - These could also be made dynamic
  late String patientCount;
  late String experience;
  late String reviewCount;
  late String rating;
  late String totalRatings;
  
  // ABOUT SECTION
  late String aboutText;
  
  
  
  // REACTIVE STATE VARIABLES
  final _isLoading = false.obs;
  final _isBookingInProgress = false.obs;
  
  // GETTERS
  bool get isLoading => _isLoading.value;
  bool get isBookingInProgress => _isBookingInProgress.value;
  
  @override
  void onInit() {
    super.onInit();
    
    // Get arguments from the previous page
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      final String passedDoctorName = arguments['doctorName'] ?? 'Dr. Unknown';
      final String passedBookingType = arguments['bookingType'] ?? 'appointment';
      
      // Set the doctor data based on the passed arguments
      setDoctorData(passedDoctorName, passedBookingType);
    } else {
      // Fallback to default data if no arguments passed
      setDefaultDoctorData();
    }
  }
  
  /// Set doctor data based on the selected doctor
  void setDoctorData(String selectedDoctorName, String selectedBookingType) {
    doctorName = selectedDoctorName;
    bookingType = selectedBookingType;
    
    // Set doctor-specific data based on the selected doctor
    // In a real app, this would come from an API or database
    switch (selectedDoctorName.toLowerCase()) {
      case 'dr. sarah udy':
        specialization = 'Cardiologist';
        location = 'Uyo Nigeria';
        hospital = 'University of Uyo Teaching Hospital';
        status = 'Online';
        doctorImage = 'lib/assets/images/doctors/Doctor img.png';
        isVerified = true;
        isOnline = true;
        patientCount = '1.2k';
        experience = '8 Years';
        reviewCount = '2.3k';
        rating = '4.9/5';
        totalRatings = '(2.3k ratings)';
        aboutText = "Hello, I'm Dr. Sarah. I have been in practice for 8 years "
            "handling all forms of heart diseases including hypertension, "
            "coronary artery disease, and heart failure, providing "
            "compassionate care and innovative treatment solutions.";
        break;
        
      case 'dr. sarah johnson':
        specialization = 'Dermatologist';
        location = 'Lagos Nigeria';
        hospital = 'Lagos University Teaching Hospital';
        status = 'Online';
        doctorImage = 'lib/assets/images/doctors/sarah.png';
        isVerified = true;
        isOnline = true;
        patientCount = '950';
        experience = '6 Years';
        reviewCount = '1.8k';
        rating = '4.8/5';
        totalRatings = '(1.8k ratings)';
        aboutText = "Hello, I'm Dr. Sarah Johnson. I specialize in skin care and "
            "have 6 years of experience treating various dermatological conditions "
            "including acne, eczema, psoriasis, and skin cancer prevention.";
        break;
        
      case 'dr. nuurdeen ahmad':
        specialization = 'General Practitioner';
        location = 'Abuja Nigeria';
        hospital = 'National Hospital Abuja';
        status = 'Online';
        doctorImage = 'lib/assets/images/doctors/nuurdeen.png';
        isVerified = true;
        isOnline = true;
        patientCount = '2.1k';
        experience = '10 Years';
        reviewCount = '3.1k';
        rating = '4.7/5';
        totalRatings = '(3.1k ratings)';
        aboutText = "Hello, I'm Dr. Nuurdeen. I provide comprehensive healthcare "
            "with 10 years experience in family medicine, preventive care, "
            "and managing chronic conditions for patients of all ages.";
        break;
        
      default:
        // Default data for unknown doctors
        setDefaultDoctorData();
        break;
    }
  }
  
  /// Set default doctor data as fallback
  void setDefaultDoctorData() {
    doctorName = 'Dr. Sarah Udy';
    specialization = 'Cardiologist';
    location = 'Uyo Nigeria';
    hospital = 'University of Uyo Teaching Hospital';
    status = 'Online';
    doctorImage = 'lib/assets/images/doctors/Doctor img.png';
    isVerified = true;
    isOnline = true;
    bookingType = 'appointment';
    patientCount = '1.2k';
    experience = '8 Years';
    reviewCount = '2.3k';
    rating = '4.9/5';
    totalRatings = '(2.3k ratings)';
    aboutText = "Hello, I'm Dr. Sarah. I have been in practice for 8 years "
        "handling all forms of heart diseases including hypertension, "
        "coronary artery disease, and heart failure, providing "
        "compassionate care and innovative treatment solutions.";
  }
  
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
      'Navigate to ${bookingType == 'appointment' ? 'appointment booking' : 'consultation booking'}',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
  
  /// Navigate to ratings and reviews page
  void navigateToReviews() {
    // TODO: Implement navigation to reviews page
    Get.to(() => const PatientReviewsPage());
    
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
      Get.to(() => const ConsultationCheckoutPage());
      
     
      
    } catch (error) {
      // Handle booking errors
      Get.snackbar(
        'Booking Failed',
        'Unable to book ${bookingType == 'appointment' ? 'appointment' : 'consultation'}. Please try again.',
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
    return '${bookingType == 'appointment' ? '  Consult Now' : 'Consult now'}';
  }
}