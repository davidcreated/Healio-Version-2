import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/doctors/controllers/patientinfocontroller.dart';

/// Main patient information collection page
/// Displays different information sections based on current step
/// Uses a stepper UI pattern with progress indication
class PatientInformationPage extends StatelessWidget {
  const PatientInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the GetX controller
    final PatientInformationController controller = Get.put(PatientInformationController());
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(controller),
      body: Column(
        children: [
          // Progress indicator section
          _buildProgressIndicator(controller),
          
          // Main content area - switches between different information sections
          Expanded(
            child: Obx(() => _buildCurrentSection(controller)),
          ),
          
          // Bottom navigation buttons
          _buildBottomNavigation(controller),
        ],
      ),
    );
  }

  /// Build the app bar with back navigation and title
  PreferredSizeWidget _buildAppBar(PatientInformationController controller) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        'Patients Information',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
    );
  }

  /// Build the progress indicator showing current section
  Widget _buildProgressIndicator(PatientInformationController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Progress bar
          Obx(() => LinearProgressIndicator(
            value: controller.progressPercentage,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF002180)),
            minHeight: 6,
          )),
          
          const SizedBox(height: 16),
          
          // Section indicators
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              controller.sections.length,
              (index) => _buildSectionIndicator(
                controller.sections[index],
                index,
                controller.currentPageIndex.value,
              ),
            ),
          )),
        ],
      ),
    );
  }

  /// Build individual section indicator dot with label
  Widget _buildSectionIndicator(String label, int index, int currentIndex) {
    final isActive = index == currentIndex;
    final isCompleted = index < currentIndex;
    
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted 
                  ? const Color(0xFF002180)
                  : isActive 
                      ? const Color(0xFF002180)
                      : Colors.grey.shade300,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.grey.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? const Color(0xFF002180) : Colors.grey.shade600,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build the current section content based on controller state
  Widget _buildCurrentSection(PatientInformationController controller) {
    switch (controller.currentPageIndex.value) {
      case 0:
        return _GeneralInformationSection(controller: controller);
      case 1:
        return _MedicalHistorySection(controller: controller);
      case 2:
        return _LifestyleHistorySection(controller: controller);
      case 3:
        return _SymptomAnalysisSection(controller: controller);
      default:
        return _GeneralInformationSection(controller: controller);
    }
  }

  /// Build bottom navigation with Previous/Next or Chat room buttons
  Widget _buildBottomNavigation(PatientInformationController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Chat room button (always visible)
          Obx(() => SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.goToChatRoom,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF002180),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: controller.isLoading.value
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Chatting room',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          )),
          
          const SizedBox(height: 12),
          
          // Navigation buttons row
          Obx(() => Row(
            children: [
              // Previous button
              if (!controller.isFirstPage)
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.previousPage,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF002180)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Previous',
                      style: TextStyle(
                        color: Color(0xFF002180),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              
              // Spacer between buttons
              if (!controller.isFirstPage && !controller.isLastPage)
                const SizedBox(width: 12),
              
              // Next button
              if (!controller.isLastPage)
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.nextPage,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF002180)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: Color(0xFF002180),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          )),
        ],
      ),
    );
  }
}

/// Section 1: General Information
/// Collects primary complaint and symptom duration
class _GeneralInformationSection extends StatelessWidget {
  final PatientInformationController controller;
  
  const _GeneralInformationSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          const Text(
            'General Information',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002180),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Privacy notice
          const Text(
            'The information provided is highly confidential and 100% protected',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Primary complaint question
          _buildQuestionSection(
            'I quickly want to see the doctor on behalf of my 9 years old daughter.',
            'How long have you been experiencing these symptoms?',
            controller.patientData.symptomDuration,
            (value) => controller.patientData.symptomDuration = value,
            'She started vomiting two days ago.',
          ),
          
          const SizedBox(height: 24),
          
          // Symptom progression question
          _buildQuestionSection(
            'Have you noticed anything that makes the symptoms better or worse?',
            '',
            controller.patientData.symptomsWorseOrBetter,
            (value) => controller.patientData.symptomsWorseOrBetter = value,
            'Yes she sleep so much than the usual.',
          ),
        ],
      ),
    );
  }

  /// Build a question section with input field
  Widget _buildQuestionSection(
    String question,
    String subQuestion,
    String currentValue,
    Function(String) onChanged,
    String placeholder,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        
        if (subQuestion.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            subQuestion,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
        
        const SizedBox(height: 12),
        
        // Text input field
        TextFormField(
          initialValue: currentValue,
          onChanged: onChanged,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF002180)),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }
}

/// Section 2: Medical History
/// Collects information about existing conditions, medications, surgeries
class _MedicalHistorySection extends StatelessWidget {
  final PatientInformationController controller;
  
  const _MedicalHistorySection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Medical History',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002180),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Existing medical conditions
          _buildQuestionSection(
            'Do you have any existing medical conditions?',
            controller.patientData.existingMedicalConditions,
            (value) => controller.patientData.existingMedicalConditions = value,
            'She only experience this once in a while.',
          ),
          
          const SizedBox(height: 24),
          
          // Current medications
          _buildQuestionSection(
            'Are you currently taking any medications or supplements?',
            controller.patientData.currentMedications,
            (value) => controller.patientData.currentMedications = value,
            'She just finish malaria syrup, yet she still sleep too much.',
          ),
          
          const SizedBox(height: 24),
          
          // Past surgeries
          _buildQuestionSection(
            'Have you had any surgeries or hospitalizations in the past?',
            controller.patientData.pastSurgeries,
            (value) => controller.patientData.pastSurgeries = value,
            'No',
          ),
          
          const SizedBox(height: 24),
          
          // Additional surgeries/hospitalizations
          _buildQuestionSection(
            'Have you had any surgeries or hospitalizations in the past?',
            controller.patientData.pastHospitalizations,
            (value) => controller.patientData.pastHospitalizations = value,
            'No.',
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionSection(
    String question,
    String currentValue,
    Function(String) onChanged,
    String placeholder,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        
        const SizedBox(height: 12),
        
        TextFormField(
          initialValue: currentValue,
          onChanged: onChanged,
          maxLines: 2,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF002180)),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }
}

/// Section 3: Lifestyle and Family History
/// Collects lifestyle habits and family medical history
class _LifestyleHistorySection extends StatelessWidget {
  final PatientInformationController controller;
  
  const _LifestyleHistorySection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lifestyle and Family History',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002180),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Smoking/drinking/drugs
          _buildQuestionSection(
            'Do you smoke, drink alcohol, or use any recreational drugs?',
            controller.patientData.smokingDrinkingDrugs,
            (value) => controller.patientData.smokingDrinkingDrugs = value,
            'No.',
          ),
          
          const SizedBox(height: 24),
          
          // Diet and exercise
          _buildQuestionSection(
            'How would you describe your diet and exercise routine?',
            controller.patientData.dietExerciseRoutine,
            (value) => controller.patientData.dietExerciseRoutine = value,
            'She eats well sometime, sometime she eat less.',
          ),
          
          const SizedBox(height: 24),
          
          // Family history
          _buildQuestionSection(
            'Do you have any family history of serious illnesses (e.g., diabetes, hypertension, cancer)?',
            controller.patientData.familyMedicalHistory,
            (value) => controller.patientData.familyMedicalHistory = value,
            'No.',
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionSection(
    String question,
    String currentValue,
    Function(String) onChanged,
    String placeholder,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        
        const SizedBox(height: 12),
        
        TextFormField(
          initialValue: currentValue,
          onChanged: onChanged,
          maxLines: 2,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF002180)),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }
}

/// Section 4: Specific Symptom Analysis
/// Collects detailed symptom information and severity
class _SymptomAnalysisSection extends StatelessWidget {
  final PatientInformationController controller;
  
  const _SymptomAnalysisSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Specific Symptom Analysis',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002180),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Pain description
          _buildQuestionSection(
            'Can you describe the pain or discomfort? (Sharp, dull, throbbing, etc.)',
            controller.patientData.painDescription,
            (value) => controller.patientData.painDescription = value,
            '-',
          ),
          
          const SizedBox(height: 24),
          
          // Pain severity scale
          _buildQuestionSection(
            'On a scale of 1 to 10, how severe is your pain or discomfort?',
            controller.patientData.painSeverityScale,
            (value) => controller.patientData.painSeverityScale = value,
            '-',
          ),
          
          const SizedBox(height: 24),
          
          // Recent symptoms
          _buildQuestionSection(
            'Have you experienced any recent weight loss, fever, or unusual fatigue?',
            controller.patientData.recentWeightLossFeverFatigue,
            (value) => controller.patientData.recentWeightLossFeverFatigue = value,
            'Yes, fever since two days ago.',
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionSection(
    String question,
    String currentValue,
    Function(String) onChanged,
    String placeholder,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        
        const SizedBox(height: 12),
        
        TextFormField(
          initialValue: currentValue,
          onChanged: onChanged,
          maxLines: 2,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF002180)),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }
}