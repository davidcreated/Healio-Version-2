import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/patients/controllers/PreliminaryQuestionData.dart';

// Import your controller
// import 'preliminary_question_controller.dart';

class PreliminaryQuestionPage extends StatefulWidget {
  const PreliminaryQuestionPage({Key? key}) : super(key: key);

  @override
  State<PreliminaryQuestionPage> createState() => _PreliminaryQuestionPageState();
}

class _PreliminaryQuestionPageState extends State<PreliminaryQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final PreliminaryQuestionController controller = Get.put(PreliminaryQuestionController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and title
            _buildHeader(controller),
            
            // Progress stepper
            _buildProgressStepper(controller),
            
            // Main content area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(() => _buildCurrentStepContent(controller)),
              ),
            ),
            
            // Continue/Submit button
            _buildContinueButton(controller),
          ],
        ),
      ),
    );
  }

  /// Build header with back button and title
  Widget _buildHeader(PreliminaryQuestionController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE0E6ED), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Back button
          InkWell(
            onTap: controller.goToPreviousStep,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF002180),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Title
          const Text(
            'Preliminary Question',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF061234),
            ),
          ),
        ],
      ),
    );
  }

  /// Build progress stepper showing current step
  Widget _buildProgressStepper(PreliminaryQuestionController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Obx(() => Column(
        children: [
          // Step indicators
          Row(
            children: List.generate(4, (index) {
              final isCompleted = controller.stepCompleted[index];
              final isCurrent = controller.currentStep.value == index;
              final isAccessible = index <= controller.currentStep.value;
              
              return Expanded(
                child: GestureDetector(
                  onTap: isAccessible ? () => controller.goToStep(index) : null,
                  child: Container(
                    margin: EdgeInsets.only(right: index < 3 ? 8 : 0),
                    child: Column(
                      children: [
                        // Step circle
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isCompleted 
                                ? Colors.green 
                                : isCurrent 
                                    ? const Color(0xFF002180)
                                    : Colors.grey.shade300,
                            shape: BoxShape.circle,
                            border: isCurrent 
                                ? Border.all(color: const Color(0xFF002180), width: 2)
                                : null,
                          ),
                          child: Center(
                            child: isCompleted
                                ? const Icon(Icons.check, color: Colors.white, size: 18)
                                : Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      color: isCurrent || isCompleted ? Colors.white : Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        // Step title
                        Text(
                          _getStepShortTitle(index),
                          style: TextStyle(
                            fontSize: 10,
                            color: isCurrent ? const Color(0xFF002180) : Colors.grey,
                            fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          
          const SizedBox(height: 16),
          
          // Current step title and subtitle
          Text(
            controller.currentStepTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF061234),
            ),
          ),
        ],
      )),
    );
  }

  /// Get short title for step indicator
  String _getStepShortTitle(int index) {
    switch (index) {
      case 0: return 'General Info';
      case 1: return 'Medical History';
      case 2: return 'Lifestyle History';
      case 3: return 'Symptom Analysis';
      default: return '';
    }
  }

  /// Build content for current step
  Widget _buildCurrentStepContent(PreliminaryQuestionController controller) {
    switch (controller.currentStep.value) {
      case 0:
        return _buildGeneralInformationStep(controller);
      case 1:
        return _buildMedicalHistoryStep(controller);
      case 2:
        return _buildLifestyleHistoryStep(controller);
      case 3:
        return _buildSymptomAnalysisStep(controller);
      default:
        return const SizedBox();
    }
  }

  /// Build General Information step (Step 1)
  Widget _buildGeneralInformationStep(PreliminaryQuestionController controller) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestionField(
            'What brings you in today? (Primary concern or symptoms)',
            controller.primaryConcernController,
            required: true,
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          
          _buildQuestionField(
            'How long have you been experiencing these symptoms?',
            controller.symptomDurationController,
            required: true,
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          
          _buildQuestionField(
            'Have you noticed anything that makes the symptoms better or worse?',
            controller.symptomTriggersController,
            maxLines: 4,
          ),
        ],
      ),
    );
  }

  /// Build Medical History step (Step 2)
  Widget _buildMedicalHistoryStep(PreliminaryQuestionController controller) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestionField(
            'Do you have any existing medical conditions?',
            controller.existingConditionsController,
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          
          _buildQuestionField(
            'Are you currently taking any medications or supplements?',
            controller.currentMedicationsController,
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          
          _buildQuestionField(
            'Have you had any surgeries or hospitalizations in the past?',
            controller.pastSurgeriesController,
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          
          _buildQuestionField(
            'Have you had any surgeries or hospitalizations in the past?',
            controller.pastHospitalizationsController,
            maxLines: 4,
          ),
        ],
      ),
    );
  }

  /// Build Lifestyle and Family History step (Step 3)
  Widget _buildLifestyleHistoryStep(PreliminaryQuestionController controller) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestionField(
            'Do you smoke, drink alcohol, or use any recreational drugs?',
            controller.substanceUseController,
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          
          _buildQuestionField(
            'How would you describe your diet and exercise routine?',
            controller.dietExerciseController,
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          
          _buildQuestionField(
            'Do you have any family history of serious illnesses (e.g., diabetes, hypertension, cancer)?',
            controller.familyHistoryController,
            maxLines: 4,
          ),
        ],
      ),
    );
  }

  /// Build Specific Symptom Analysis step (Step 4)
  Widget _buildSymptomAnalysisStep(PreliminaryQuestionController controller) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestionField(
            'Can you describe the pain or discomfort? (Sharp, dull, throbbing, etc.)',
            controller.painDescriptionController,
            required: true,
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          
          // Pain severity scale
          const Text(
            'On a scale of 1 to 10, how severe is your pain or discomfort?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF061234),
            ),
          ),
          const SizedBox(height: 16),
          
          Obx(() => _buildPainScale(controller)),
          const SizedBox(height: 24),
          
          _buildQuestionField(
            'Have you experienced any recent weight loss, fever, or unusual fatigue?',
            controller.recentChangesController,
            maxLines: 4,
          ),
        ],
      ),
    );
  }

  /// Build pain severity scale (1-10)
  Widget _buildPainScale(PreliminaryQuestionController controller) {
    return Column(
      children: [
        // Pain scale numbers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(10, (index) {
            final value = index + 1;
            final isSelected = controller.painSeverity.value == value;
            
            return GestureDetector(
              onTap: () => controller.updatePainSeverity(value),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF002180) : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? const Color(0xFF002180) : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    value.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        
        // Pain scale labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'No Pain',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              'Severe Pain',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        
        if (controller.painSeverity.value > 0)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Selected: ${controller.painSeverity.value}/10',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF002180),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  /// Build question field widget
  Widget _buildQuestionField(
    String question,
    TextEditingController controller, {
    bool required = false,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF061234),
            ),
            children: required
                ? [
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    )
                  ]
                : null,
          ),
        ),
        const SizedBox(height: 12),
        
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: question,
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF002180), width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  /// Build continue/submit button
  Widget _buildContinueButton(PreliminaryQuestionController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Obx(() => SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: controller.goToNextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF002180),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            controller.isLastStep ? 'Submit' : 'Continue',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      )),
    );
  }
}