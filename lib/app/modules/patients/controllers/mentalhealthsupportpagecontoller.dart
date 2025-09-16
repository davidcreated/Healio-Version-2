import 'package:get/get.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/browsedoctors.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/mentalhealth.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/privatetherapistconsult.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/therapistpage.dart';

// TODO: 1. Import your existing resources page here
// import 'package:healio/src/features/auth/screens/resources/resources_page.dart';


/// Controller for the MentalHealthSupportPage
/// Manages navigation and actions.
class MentalHealthController extends GetxController {

  /// Navigates to the therapist/doctor listing page.
  void findDoctor() {
    Get.to(() => const Therapistpage());
  }

  /// Navigates to the therapist page for booking a session.
  void bookSession() {
    Get.to(() => const Privatetherapistconsult());
  }

  /// Navigates to your in-app resources page.
  void navigateToResources() {
    // TODO: 2. Replace 'YourResourcesPage()' with the actual widget for your resources screen.
     Get.to(() => const MentalHealthResourcesPage());
   
  }
}