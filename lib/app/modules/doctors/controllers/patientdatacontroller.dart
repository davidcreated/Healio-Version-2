import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// Controller for managing patient information display and navigation
class PatientDataController extends GetxController {
  // Observable patient data
  var patientName = 'Joseph Elizabeth'.obs;
  var patientAge = '29'.obs;
  var patientSex = 'Female'.obs;
  var patientOccupation = 'Banker'.obs;
  var patientBloodGroup = 'AA'.obs;
  var patientGenotype = 'O+'.obs;
  var patientLocation = 'Uyo, Akwa-Ibom'.obs;
  var patientImage = 'assets/images/patient.png'.obs;
  
  // Loading states
  var isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Initialize patient data - could load from API or arguments
    _loadPatientData();
  }
  
  /// Load patient data from arguments or API
  void _loadPatientData() {
    // Get patient data from navigation arguments if available
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      patientName.value = arguments['name'] ?? patientName.value;
      patientAge.value = arguments['age']?.toString() ?? patientAge.value;
      patientSex.value = arguments['sex'] ?? patientSex.value;
      patientOccupation.value = arguments['occupation'] ?? patientOccupation.value;
      patientBloodGroup.value = arguments['bloodGroup'] ?? patientBloodGroup.value;
      patientGenotype.value = arguments['genotype'] ?? patientGenotype.value;
      patientLocation.value = arguments['location'] ?? patientLocation.value;
      patientImage.value = arguments['image'] ?? patientImage.value;
    }
  }
  
  /// Navigate to chatting room
  void goToChattingRoom() {
    isLoading.value = true;
    
    // Pass patient data to chatting room
    final patientData = {
      'name': patientName.value,
      'age': patientAge.value,
      'sex': patientSex.value,
      'occupation': patientOccupation.value,
      'bloodGroup': patientBloodGroup.value,
      'genotype': patientGenotype.value,
      'location': patientLocation.value,
    };
    
    Get.toNamed('/doctor-chatting-room', arguments: patientData);
    isLoading.value = false;
  }
  
  /// Navigate to read all patient information
  void readAllInfo() {
    isLoading.value = true;
    
    // Pass patient data to description page
    final patientData = {
      'name': patientName.value,
      'age': patientAge.value,
      'sex': patientSex.value,
      'occupation': patientOccupation.value,
      'bloodGroup': patientBloodGroup.value,
      'genotype': patientGenotype.value,
      'location': patientLocation.value,
    };
    
    Get.toNamed('/patient-description', arguments: patientData);
    isLoading.value = false;
  }
  
  /// Navigate back to doctor's home
  void goBack() {
    Get.back();
    // Or navigate to specific route if needed
    // Get.toNamed('/doctors-home');
  }
  
  /// Update patient information
  void updatePatientInfo({
    String? name,
    String? age,
    String? sex,
    String? occupation,
    String? bloodGroup,
    String? genotype,
    String? location,
    String? image,
  }) {
    if (name != null) patientName.value = name;
    if (age != null) patientAge.value = age;
    if (sex != null) patientSex.value = sex;
    if (occupation != null) patientOccupation.value = occupation;
    if (bloodGroup != null) patientBloodGroup.value = bloodGroup;
    if (genotype != null) patientGenotype.value = genotype;
    if (location != null) patientLocation.value = location;
    if (image != null) patientImage.value = image;
  }
  
  /// Get formatted patient info for display
  Map<String, String> get patientInfo => {
    'Age': patientAge.value,
    'Sex': patientSex.value,
    'Occupation': patientOccupation.value,
    'Blood Group': patientBloodGroup.value,
    'Genotype': patientGenotype.value,
    'Location': patientLocation.value,
  };
}