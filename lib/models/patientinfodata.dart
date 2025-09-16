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
  
  // Add the default constructor explicitly
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