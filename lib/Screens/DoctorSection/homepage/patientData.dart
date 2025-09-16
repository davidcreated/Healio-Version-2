import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/doctors/controllers/patientdatacontroller.dart';

// Import your controller
// import 'patient_info_controller.dart';

class PatientDataPage extends StatefulWidget {
  const PatientDataPage({super.key});

  @override
  State<PatientDataPage> createState() => _PatientDataPageState();
}

class _PatientDataPageState extends State<PatientDataPage> {
  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final PatientDataController controller = Get.put(PatientDataController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Patient image at the top
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Obx(() => Image.asset(
                  controller.patientImage.value,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )),
                // Gradient overlay to match the image
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                          Colors.white.withOpacity(0.8),
                          Colors.white,
                        ],
                        stops: const [0.0, 0.4, 0.7, 1.0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Back button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: GestureDetector(
                onTap: controller.goBack,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black87,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          
          // Patient info card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.55,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Patient name
                    Obx(() => Text(
                      controller.patientName.value,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'NotoSans',
                        color: Colors.black87,
                      ),
                    )),
                    const SizedBox(height: 24),
                    
                    // Patient information
                    Obx(() => Column(
                      children: controller.patientInfo.entries.map((entry) => 
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  '${entry.key}:',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'NotoSans',
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  entry.value,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'NotoSans',
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).toList(),
                    )),
                    
                    const SizedBox(height: 32),
                    
                    // Buttons
                    Obx(() => Column(
                      children: [
                        // Chatting room button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: controller.isLoading.value 
                                ? null 
                                : controller.goToChattingRoom,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E3A8A), // Blue-800
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: Colors.grey.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 2,
                            ),
                            child: controller.isLoading.value
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : const Text(
                                    'Chatting room',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'NotoSans',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Read all info button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: controller.isLoading.value 
                                ? null 
                                : controller.readAllInfo,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xFF1E3A8A), 
                                width: 2,
                              ),
                              
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              'Read all info',
                              style: TextStyle(
                                color: controller.isLoading.value 
                                    ? Colors.grey.shade400
                                    : const Color(0xFF1E3A8A),
                                fontSize: 16,
                                fontFamily: 'NotoSans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                    
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Controller for managing patient information display and navigation
class PatientInfoController extends GetxController {
  // Observable patient data
  var patientName = 'Joseph Elizabeth'.obs;
  var patientAge = '29'.obs;
  var patientSex = 'Female'.obs;
  var patientOccupation = 'Banker'.obs;
  var patientBloodGroup = 'AA'.obs;
  var patientGenotype = 'O+'.obs;
  var patientLocation = 'Uyo, Akwa-Ibom'.obs;
  var patientImage = 'lib/assets/images/doctors/patient.png'.obs;
  
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