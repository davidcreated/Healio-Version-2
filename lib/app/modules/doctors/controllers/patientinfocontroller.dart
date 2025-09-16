import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controller that manages the patient information flow
/// Handles navigation between different information sections and data collection
class PatientInformationController extends GetxController {
  // Current page index for the stepper/progress indicator
  var currentPageIndex = 0.obs;
  
  // Loading state for async operations
  var isLoading = false.obs;
  
  // Patient data storage - organized by information categories
  final PatientData patientData = PatientData();
  
  // List of all information sections in order
  final List<String> sections = [
    'General Info',
    'Medical History', 
    'Lifestyle History',
    'Symptom Analysis'
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize with default values if needed
    _initializeDefaultData();
  }

  /// Initialize default or previously saved patient data
  void _initializeDefaultData() {
    // Set any default values or load from storage
    // This could pull from local storage or API
  }

  /// Navigate to the next information section
  /// Validates current section before proceeding
  void nextPage() {
    if (_validateCurrentSection()) {
      if (currentPageIndex.value < sections.length - 1) {
        currentPageIndex.value++;
      } else {
        // Final page reached - handle completion
        _completePatientsInformation();
      }
    }
  }

  /// Navigate to the previous information section
  void previousPage() {
    if (currentPageIndex.value > 0) {
      currentPageIndex.value--;
    }
  }

  /// Jump directly to a specific section index
  void goToSection(int index) {
    if (index >= 0 && index < sections.length) {
      currentPageIndex.value = index;
    }
  }

  /// Validate the current section's required fields
  /// Returns true if all required fields are filled
  bool _validateCurrentSection() {
    switch (currentPageIndex.value) {
      case 0: // General Information
        return _validateGeneralInfo();
      case 1: // Medical History  
        return _validateMedicalHistory();
      case 2: // Lifestyle History
        return _validateLifestyleHistory();
      case 3: // Symptom Analysis
        return _validateSymptomAnalysis();
      default:
        return true;
    }
  }

  /// Validate general information section
  bool _validateGeneralInfo() {
    if (patientData.reasonForVisit.isEmpty) {
      _showValidationError('Please provide reason for visit');
      return false;
    }
    if (patientData.symptomDuration.isEmpty) {
      _showValidationError('Please specify symptom duration');
      return false;
    }
    return true;
  }

  /// Validate medical history section
  bool _validateMedicalHistory() {
    // Medical history validation - some fields may be optional
    return true; // Most medical history fields can be optional
  }

  /// Validate lifestyle history section
  bool _validateLifestyleHistory() {
    // Lifestyle questions validation
    return true; // Most lifestyle fields can be optional
  }

  /// Validate symptom analysis section
  bool _validateSymptomAnalysis() {
    // Symptom analysis validation
    return true; // Symptom details can be optional
  }

  /// Show validation error message to user
  void _showValidationError(String message) {
    Get.snackbar(
      'Required Information',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange.shade100,
      colorText: Colors.orange.shade800,
      duration: const Duration(seconds: 3),
    );
  }

  /// Handle completion of patient information collection
  /// This would typically save data and navigate to next screen
  Future<void> _completePatientsInformation() async {
    isLoading.value = true;
    
    try {
      // Save patient information to backend/database
      await _savePatientData();
      
      Get.snackbar(
        'Information Saved',
        'Patient information has been recorded successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade800,
        duration: const Duration(seconds: 2),
      );
      
      // Navigate to chat room or next screen
      Get.toNamed('/chat-room', arguments: patientData);
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save patient information. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Save patient data to backend service
  Future<void> _savePatientData() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    // In real implementation, this would call your API:
    // await ApiService.savePatientInformation(patientData.toJson());
  }

  /// Navigate to chat room
  void goToChatRoom() {
    Get.toNamed('/chat-room', arguments: patientData);
  }

  /// Get current section title
  String getCurrentSectionTitle() {
    return sections[currentPageIndex.value];
  }

  /// Check if we're on the first page
  bool get isFirstPage => currentPageIndex.value == 0;

  /// Check if we're on the last page  
  bool get isLastPage => currentPageIndex.value == sections.length - 1;

  /// Get progress percentage (0.0 to 1.0)
  double get progressPercentage => (currentPageIndex.value + 1) / sections.length;
}

/// Data model to store all patient information
/// Organized by the different information categories
class PatientData {
  // General Information
  String reasonForVisit = '';
  String symptomDuration = '';
  String symptomsWorseOrBetter = '';
  
  // Medical History  
  String existingMedicalConditions = '';
  String currentMedications = '';
  String pastSurgeries = '';
  String pastHospitalizations = '';
  
  // Lifestyle and Family History
  String smokingDrinkingDrugs = '';
  String dietExerciseRoutine = '';
  String familyMedicalHistory = '';
  
  // Specific Symptom Analysis
  String painDescription = '';
  String painSeverityScale = '';
  String recentWeightLossFeverFatigue = '';
  
  // Default constructor
  PatientData();
  
  /// Convert patient data to JSON for API calls
  Map<String, dynamic> toJson() {
    return {
      'general_info': {
        'reason_for_visit': reasonForVisit,
        'symptom_duration': symptomDuration,
        'symptoms_worse_or_better': symptomsWorseOrBetter,
      },
      'medical_history': {
        'existing_conditions': existingMedicalConditions,
        'current_medications': currentMedications,
        'past_surgeries': pastSurgeries,
        'past_hospitalizations': pastHospitalizations,
      },
      'lifestyle_history': {
        'smoking_drinking_drugs': smokingDrinkingDrugs,
        'diet_exercise': dietExerciseRoutine,
        'family_history': familyMedicalHistory,
      },
      'symptom_analysis': {
        'pain_description': painDescription,
        'pain_severity': painSeverityScale,
        'recent_symptoms': recentWeightLossFeverFatigue,
      },
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
  
  /// Create PatientData from JSON
  factory PatientData.fromJson(Map<String, dynamic> json) {
    final data = PatientData();
    
    if (json['general_info'] != null) {
      data.reasonForVisit = json['general_info']['reason_for_visit'] ?? '';
      data.symptomDuration = json['general_info']['symptom_duration'] ?? '';
      data.symptomsWorseOrBetter = json['general_info']['symptoms_worse_or_better'] ?? '';
    }
    
    if (json['medical_history'] != null) {
      data.existingMedicalConditions = json['medical_history']['existing_conditions'] ?? '';
      data.currentMedications = json['medical_history']['current_medications'] ?? '';
      data.pastSurgeries = json['medical_history']['past_surgeries'] ?? '';
      data.pastHospitalizations = json['medical_history']['past_hospitalizations'] ?? '';
    }
    
    if (json['lifestyle_history'] != null) {
      data.smokingDrinkingDrugs = json['lifestyle_history']['smoking_drinking_drugs'] ?? '';
      data.dietExerciseRoutine = json['lifestyle_history']['diet_exercise'] ?? '';
      data.familyMedicalHistory = json['lifestyle_history']['family_history'] ?? '';
    }
    
    if (json['symptom_analysis'] != null) {
      data.painDescription = json['symptom_analysis']['pain_description'] ?? '';
      data.painSeverityScale = json['symptom_analysis']['pain_severity'] ?? '';
      data.recentWeightLossFeverFatigue = json['symptom_analysis']['recent_symptoms'] ?? '';
    }
    
    return data;
  }
}