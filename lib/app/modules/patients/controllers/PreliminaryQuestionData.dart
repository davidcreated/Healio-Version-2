import 'package:get/get.dart';
import 'package:flutter/material.dart';

// Data models for the preliminary questions
class PreliminaryQuestionData {
  // General Information
  String primaryConcern = '';
  String symptomDuration = '';
  String symptomTriggers = '';
  
  // Medical History
  String existingConditions = '';
  String currentMedications = '';
  String pastSurgeries = '';
  String pastHospitalizations = '';
  
  // Lifestyle and Family History
  String substanceUse = '';
  String dietExercise = '';
  String familyHistory = '';
  
  // Specific Symptom Analysis
  String painDescription = '';
  int painSeverity = 0;
  String recentChanges = '';
  
  // Convert to map for API submission
  Map<String, dynamic> toJson() {
    return {
      'primaryConcern': primaryConcern,
      'symptomDuration': symptomDuration,
      'symptomTriggers': symptomTriggers,
      'existingConditions': existingConditions,
      'currentMedications': currentMedications,
      'pastSurgeries': pastSurgeries,
      'pastHospitalizations': pastHospitalizations,
      'substanceUse': substanceUse,
      'dietExercise': dietExercise,
      'familyHistory': familyHistory,
      'painDescription': painDescription,
      'painSeverity': painSeverity,
      'recentChanges': recentChanges,
    };
  }
}

class PreliminaryQuestionController extends GetxController {
  // Current step in the questionnaire (0-3 for 4 screens)
  final RxInt currentStep = 0.obs;
  
  // Data storage
  final preliminaryData = PreliminaryQuestionData().obs;
  
  // Text controllers for form fields
  final primaryConcernController = TextEditingController();
  final symptomDurationController = TextEditingController();
  final symptomTriggersController = TextEditingController();
  final existingConditionsController = TextEditingController();
  final currentMedicationsController = TextEditingController();
  final pastSurgeriesController = TextEditingController();
  final pastHospitalizationsController = TextEditingController();
  final substanceUseController = TextEditingController();
  final dietExerciseController = TextEditingController();
  final familyHistoryController = TextEditingController();
  final painDescriptionController = TextEditingController();
  final recentChangesController = TextEditingController();
  
  // Step completion tracking
  final RxList<bool> stepCompleted = [false, false, false, false].obs;
  
  // Pain severity for symptom analysis
  final RxInt painSeverity = 0.obs;
  
  // Step titles and descriptions
  final List<String> stepTitles = [
    'General Information',
    'Medical History', 
    'Lifestyle and Family History',
    'Specific Symptom Analysis'
  ];
  
  final List<String> stepSubtitles = [
    'Basic symptoms and concerns',
    'Past medical information',
    'Lifestyle factors',
    'Detailed symptom analysis'
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize with step 0 as current
    _updateStepStatus();
  }

  /// Move to next step if current step is valid
  void goToNextStep() {
    if (_validateCurrentStep()) {
      _saveCurrentStepData();
      
      if (currentStep.value < 3) {
        currentStep.value++;
        _updateStepStatus();
        
        Get.snackbar(
          'Progress Saved',
          'Moving to ${stepTitles[currentStep.value]}',
          backgroundColor: Colors.green.shade400,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        // Final step - submit questionnaire
        _submitQuestionnaire();
      }
    } else {
      Get.snackbar(
        'Incomplete Information',
        'Please fill in all required fields before continuing',
        backgroundColor: Colors.orange.shade400,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
  
  /// Go back to previous step
  void goToPreviousStep() {
    if (currentStep.value > 0) {
      _saveCurrentStepData();
      currentStep.value--;
      _updateStepStatus();
    } else {
      // Exit questionnaire
      Get.offAllNamed('/browsedoctorspage');
    }
  }
  
  /// Jump to specific step (for stepper navigation)
  void goToStep(int step) {
    if (step >= 0 && step <= 3) {
      _saveCurrentStepData();
      currentStep.value = step;
      _updateStepStatus();
    }
  }
  
  /// Update pain severity
  void updatePainSeverity(int severity) {
    painSeverity.value = severity;
    preliminaryData.value.painSeverity = severity;
  }
  
  /// Validate current step fields
  bool _validateCurrentStep() {
    switch (currentStep.value) {
      case 0: // General Information
        return primaryConcernController.text.trim().isNotEmpty &&
               symptomDurationController.text.trim().isNotEmpty;
               
      case 1: // Medical History  
        return existingConditionsController.text.trim().isNotEmpty ||
               currentMedicationsController.text.trim().isNotEmpty ||
               pastSurgeriesController.text.trim().isNotEmpty;
               
      case 2: // Lifestyle and Family History
        return substanceUseController.text.trim().isNotEmpty ||
               dietExerciseController.text.trim().isNotEmpty ||
               familyHistoryController.text.trim().isNotEmpty;
               
      case 3: // Specific Symptom Analysis
        return painDescriptionController.text.trim().isNotEmpty &&
               painSeverity.value > 0;
               
      default:
        return true;
    }
  }
  
  /// Save current step data to model
  void _saveCurrentStepData() {
    switch (currentStep.value) {
      case 0:
        preliminaryData.value.primaryConcern = primaryConcernController.text;
        preliminaryData.value.symptomDuration = symptomDurationController.text;
        preliminaryData.value.symptomTriggers = symptomTriggersController.text;
        break;
        
      case 1:
        preliminaryData.value.existingConditions = existingConditionsController.text;
        preliminaryData.value.currentMedications = currentMedicationsController.text;
        preliminaryData.value.pastSurgeries = pastSurgeriesController.text;
        preliminaryData.value.pastHospitalizations = pastHospitalizationsController.text;
        break;
        
      case 2:
        preliminaryData.value.substanceUse = substanceUseController.text;
        preliminaryData.value.dietExercise = dietExerciseController.text;
        preliminaryData.value.familyHistory = familyHistoryController.text;
        break;
        
      case 3:
        preliminaryData.value.painDescription = painDescriptionController.text;
        preliminaryData.value.painSeverity = painSeverity.value;
        preliminaryData.value.recentChanges = recentChangesController.text;
        break;
    }
  }
  
  /// Update step completion status
  void _updateStepStatus() {
    for (int i = 0; i < stepCompleted.length; i++) {
      if (i < currentStep.value) {
        stepCompleted[i] = true;
      } else if (i == currentStep.value) {
        stepCompleted[i] = false; // Current step is in progress
      } else {
        stepCompleted[i] = false; // Future steps not started
      }
    }
  }
  
  /// Submit complete questionnaire data
  Future<void> _submitQuestionnaire() async {
    try {
      _saveCurrentStepData();
      
      // Show loading
      Get.dialog(
        const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Submitting your information...'),
            ],
          ),
        ),
        barrierDismissible: false,
      );
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // In real app, you would call your API here
      // final response = await apiService.submitPreliminaryQuestions(preliminaryData.value.toJson());
      
      // Close loading dialog
      Get.back();
      
      // Mark all steps as completed
      for (int i = 0; i < stepCompleted.length; i++) {
        stepCompleted[i] = true;
      }
      
      // Navigate to next screen (probably doctor selection or appointment booking)
      Get.snackbar(
        'Questionnaire Completed',
        'Thank you for providing your information',
        backgroundColor: Colors.green.shade400,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      
      // Navigate to next screen - you can customize this
       Get.toNamed('/chatpage'); 
      // Or return results to previous screen
      Get.back(result: {
        'completed': true,
        'data': preliminaryData.value.toJson(),
      });
      
    } catch (e) {
      // Close loading dialog if open
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      
      Get.snackbar(
        'Submission Error',
        'Failed to submit questionnaire. Please try again.',
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
  
  /// Get progress percentage
  double get progressPercentage {
    return (currentStep.value + 1) / stepTitles.length;
  }
  
  /// Check if we're on the last step
  bool get isLastStep {
    return currentStep.value == stepTitles.length - 1;
  }
  
  /// Get current step title
  String get currentStepTitle {
    return stepTitles[currentStep.value];
  }
  
  /// Get current step subtitle
  String get currentStepSubtitle {
    return stepSubtitles[currentStep.value];
  }

  @override
  void onClose() {
    // Dispose text controllers
    primaryConcernController.dispose();
    symptomDurationController.dispose();
    symptomTriggersController.dispose();
    existingConditionsController.dispose();
    currentMedicationsController.dispose();
    pastSurgeriesController.dispose();
    pastHospitalizationsController.dispose();
    substanceUseController.dispose();
    dietExerciseController.dispose();
    familyHistoryController.dispose();
    painDescriptionController.dispose();
    recentChangesController.dispose();
    super.onClose();
  }
}