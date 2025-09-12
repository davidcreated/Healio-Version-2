
import 'package:get/get.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/doctorsprofile.dart';

// Controller for managing the state of the Nearby Doctors page
class BrowseDoctorsController extends GetxController {
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
  
  // Method to handle book appointment - TEST VERSION
  void bookAppointment(String doctorName) {

    Get.to(() => const DoctorProfile());
  }
  // Method to handle consult now - TEST VERSION
  void consultNow(String doctorName) {
   
    Get.to(() => const DoctorProfile());
  }

}