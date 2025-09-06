
import 'package:get/get.dart';


// Controller for managing the state of the Nearby Doctors page
class NearbyDoctorsController extends GetxController {
  var selectedIndex = 1.obs; // Doctors tab is selected by default
  
  // Method to handle tab selection
  void onTabSelected(int index) {
    selectedIndex.value = index;
  }
  
  // Method to handle back navigation
  void goBack() {
    Get.back();
  }
  
  // Method to navigate to For You doctors page
  void navigateToForYou() {
    // Navigate to For You doctors page when implemented
    Get.snackbar('Navigation', 'For You page will be implemented');
  }
  
  // Method to handle specialization selection
  void onSpecializationTap(String specialization) {
    Get.snackbar('Specialization', '$specialization doctors');
  }
  
  // Method to handle book appointment
  void bookAppointment(String doctorName) {
    Get.snackbar('Booking', 'Booking appointment with $doctorName');
  }
  
  // Method to handle consult now
  void consultNow(String doctorName) {
    Get.snackbar('Consult', 'Starting consultation with $doctorName');
  }
}
