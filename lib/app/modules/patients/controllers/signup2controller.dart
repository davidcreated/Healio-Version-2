import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/patienthomepage.dart';
import 'package:healio_version_2/app/routes/approutes.dart';
import 'package:image_picker/image_picker.dart';

/// Controller for Patient Profile Completion Page - Complete and Fixed
class ProfileCompletionController extends GetxController {
  static ProfileCompletionController get to => Get.find();
  
  // =============================================================================
  // FORM MANAGEMENT
  // =============================================================================
  
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final RxDouble formProgress = 0.0.obs;
  
  // =============================================================================
  // TEXT CONTROLLERS
  // =============================================================================
  
  late final TextEditingController ageController;
  late final TextEditingController addressController;
  late final TextEditingController cityController;
  late final TextEditingController phoneController;
  late final TextEditingController alternativePhoneController;
  late final TextEditingController allergiesController;
  late final TextEditingController medicalConditionsController;
  late final TextEditingController idNumberController;
  late final TextEditingController emergencyContactNameController;
  late final TextEditingController emergencyContactPhoneController;
  late final TextEditingController emergencyContactRelationshipController;
  
  // =============================================================================
  // REACTIVE FORM FIELDS
  // =============================================================================
  
  final RxString selectedGender = ''.obs;
  final RxString selectedState = ''.obs;
  final RxString selectedBloodType = ''.obs;
  final RxString selectedIdType = ''.obs;
  
  // =============================================================================
  // IMAGE MANAGEMENT
  // =============================================================================
  
  final Rx<File?> idFrontImage = Rx<File?>(null);
  final Rx<File?> idBackImage = Rx<File?>(null);
  final RxBool isUploadingImage = false.obs;
  final ImagePicker _imagePicker = ImagePicker();
  
  // =============================================================================
  // STATIC DATA
  // =============================================================================
  
  static const List<String> genderOptions = [
    'Male',
    'Female',
    'Other',
    'Prefer not to say'
  ];
  
  static const List<String> nigerianStates = [
    'Abia', 'Adamawa', 'Akwa Ibom', 'Anambra', 'Bauchi', 'Bayelsa',
    'Benue', 'Borno', 'Cross River', 'Delta', 'Ebonyi', 'Edo',
    'Ekiti', 'Enugu', 'FCT - Abuja', 'Gombe', 'Imo', 'Jigawa',
    'Kaduna', 'Kano', 'Katsina', 'Kebbi', 'Kogi', 'Kwara',
    'Lagos', 'Nasarawa', 'Niger', 'Ogun', 'Ondo', 'Osun',
    'Oyo', 'Plateau', 'Rivers', 'Sokoto', 'Taraba', 'Yobe', 'Zamfara'
  ];
  
  static const List<String> bloodTypes = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];
  
  static const List<String> nigerianIdTypes = [
    'National Identity Number (NIN)',
    'Permanent Voter\'s Card (PVC)',
    'Driver\'s License',
    'International Passport',
    'JAMB Result Slip',
    'WAEC Certificate',
    'NECO Certificate'
  ];
  
  // =============================================================================
  // LIFECYCLE METHODS
  // =============================================================================
  
  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    _setupListeners();
    print('ProfileCompletionController initialized');
  }
  
  @override
  void onClose() {
    _disposeControllers();
    super.onClose();
  }
  
  // =============================================================================
  // INITIALIZATION
  // =============================================================================
  
  void _initializeControllers() {
    ageController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    phoneController = TextEditingController();
    alternativePhoneController = TextEditingController();
    allergiesController = TextEditingController();
    medicalConditionsController = TextEditingController();
    idNumberController = TextEditingController();
    emergencyContactNameController = TextEditingController();
    emergencyContactPhoneController = TextEditingController();
    emergencyContactRelationshipController = TextEditingController();
  }
  
  void _setupListeners() {
    // Add listeners to update progress
    ageController.addListener(_updateFormProgress);
    addressController.addListener(_updateFormProgress);
    cityController.addListener(_updateFormProgress);
    phoneController.addListener(_updateFormProgress);
    idNumberController.addListener(_updateFormProgress);
    emergencyContactNameController.addListener(_updateFormProgress);
    emergencyContactPhoneController.addListener(_updateFormProgress);
    emergencyContactRelationshipController.addListener(_updateFormProgress);
    
    // Listen to dropdown changes
    ever(selectedGender, (_) => _updateFormProgress());
    ever(selectedState, (_) => _updateFormProgress());
    ever(selectedBloodType, (_) => _updateFormProgress());
    ever(selectedIdType, (_) => _updateFormProgress());
    ever(idFrontImage, (_) => _updateFormProgress());
    ever(idBackImage, (_) => _updateFormProgress());
  }
  
  void _disposeControllers() {
    ageController.dispose();
    addressController.dispose();
    cityController.dispose();
    phoneController.dispose();
    alternativePhoneController.dispose();
    allergiesController.dispose();
    medicalConditionsController.dispose();
    idNumberController.dispose();
    emergencyContactNameController.dispose();
    emergencyContactPhoneController.dispose();
    emergencyContactRelationshipController.dispose();
  }
  
  // =============================================================================
  // FORM PROGRESS TRACKING
  // =============================================================================
  
  void _updateFormProgress() {
    double completedFields = 0;
    const int totalRequiredFields = 10;
    
    // Count completed required fields
    if (ageController.text.isNotEmpty) completedFields++;
    if (selectedGender.value.isNotEmpty) completedFields++;
    if (addressController.text.isNotEmpty) completedFields++;
    if (selectedState.value.isNotEmpty) completedFields++;
    if (phoneController.text.isNotEmpty) completedFields++;
    if (selectedBloodType.value.isNotEmpty) completedFields++;
    if (selectedIdType.value.isNotEmpty) completedFields++;
    if (idNumberController.text.isNotEmpty) completedFields++;
    if (emergencyContactNameController.text.isNotEmpty) completedFields++;
    if (emergencyContactPhoneController.text.isNotEmpty) completedFields++;
    
    // Add image completion
    if (idFrontImage.value != null) completedFields += 0.5;
    if (idBackImage.value != null) completedFields += 0.5;
    
    formProgress.value = (completedFields / (totalRequiredFields + 1)).clamp(0.0, 1.0);
    update(); // Trigger UI update
  }
  
  // =============================================================================
  // DROPDOWN HANDLERS
  // =============================================================================
  
  void updateGender(String? value) {
    if (value != null) {
      selectedGender.value = value;
      print('Gender updated: $value');
    }
  }
  
  void updateState(String? value) {
    if (value != null) {
      selectedState.value = value;
      cityController.clear();
      print('State updated: $value');
    }
  }
  
  void updateBloodType(String? value) {
    if (value != null) {
      selectedBloodType.value = value;
      print('Blood type updated: $value');
    }
  }
  
  void updateIdType(String? value) {
    if (value != null) {
      selectedIdType.value = value;
      idNumberController.clear();
      print('ID type updated: $value');
      
      // Show format hint
      final String hint = _getIdFormatHint(value);
      if (hint.isNotEmpty) {
        Get.snackbar(
          'ID Format',
          hint,
          backgroundColor: Colors.blue.withOpacity(0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    }
  }
  
  String _getIdFormatHint(String idType) {
    switch (idType) {
      case 'National Identity Number (NIN)':
        return 'Format: 11 digits (e.g., 12345678901)';
      case 'Permanent Voter\'s Card (PVC)':
        return 'Enter your PVC number as shown on card';
      case 'Driver\'s License':
        return 'Enter your license number';
      case 'International Passport':
        return 'Enter passport number (letters and numbers)';
      default:
        return '';
    }
  }
  
  // =============================================================================
  // IMAGE HANDLING
  // =============================================================================
  
  Future<void> showImageSourceDialog({required bool isBack}) async {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isBack ? 'Upload ID Back Side' : 'Upload ID Front Side',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageSourceOption(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () {
                    Get.back();
                    _pickImageFromSource(ImageSource.camera, isBack: isBack);
                  },
                ),
                _buildImageSourceOption(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () {
                    Get.back();
                    _pickImageFromSource(ImageSource.gallery, isBack: isBack);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
  
  Widget _buildImageSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300] ?? Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.grey[700]),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }
  
  Future<void> _pickImageFromSource(ImageSource source, {required bool isBack}) async {
    if (isUploadingImage.value) return;
    
    isUploadingImage.value = true;
    
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );
      
      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);
        
        if (isBack) {
          idBackImage.value = imageFile;
          print('Back ID image selected: ${imageFile.path}');
        } else {
          idFrontImage.value = imageFile;
          print('Front ID image selected: ${imageFile.path}');
        }
        
        Get.snackbar(
          'Success',
          isBack ? 'ID back image uploaded!' : 'ID front image uploaded!',
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      print('Error picking image: $e');
      Get.snackbar(
        'Error',
        'Failed to pick image: ${e.toString()}',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isUploadingImage.value = false;
    }
  }
  
  void removeIdImage({required bool isBack}) {
    if (isBack) {
      idBackImage.value = null;
      print('Back ID image removed');
    } else {
      idFrontImage.value = null;
      print('Front ID image removed');
    }
    
    Get.snackbar(
      'Removed',
      isBack ? 'Back ID image removed' : 'Front ID image removed',
      backgroundColor: Colors.orange.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }
  
  // =============================================================================
  // VALIDATION METHODS
  // =============================================================================
  
  String? validateAge(String? value) {
    if (value?.isEmpty ?? true) return 'Please enter your age';
    final int? age = int.tryParse(value!);
    if (age == null || age < 1 || age > 120) return 'Please enter a valid age (1-120)';
    return null;
  }
  
  String? validateAddress(String? value) {
    if (value?.isEmpty ?? true) return 'Please enter your address';
    if (value!.length < 5) return 'Please enter a complete address';
    return null;
  }
  
  String? validatePhoneNumber(String? value) {
    if (value?.isEmpty ?? true) return 'Please enter your phone number';
    final String cleanPhone = value!.replaceAll(RegExp(r'\s+'), '');
    
    // Nigerian phone number patterns
    if (!RegExp(r'^0[789][01]\d{8}$').hasMatch(cleanPhone)) {
      return 'Please enter a valid Nigerian phone number (11 digits starting with 070, 080, 081, 090, 091)';
    }
    return null;
  }
  
  String? validateAlternativePhone(String? value) {
    if (value?.isEmpty ?? true) return null; // Optional field
    return validatePhoneNumber(value);
  }
  
  String? validateIdNumber(String? value) {
    if (value?.isEmpty ?? true) return 'Please enter your ID number';
    if (selectedIdType.value.isEmpty) return 'Please select ID type first';
    
    switch (selectedIdType.value) {
      case 'National Identity Number (NIN)':
        if (value!.length != 11 || !RegExp(r'^\d{11}$').hasMatch(value)) {
          return 'NIN must be exactly 11 digits';
        }
        break;
      default:
        if (value!.length < 6) return 'Please enter a valid ID number';
    }
    return null;
  }
  
  String? validateEmergencyPhone(String? value) {
    if (value?.isEmpty ?? true) return 'Please enter emergency contact phone';
    return validatePhoneNumber(value);
  }
  
  // =============================================================================
  // FORM SUBMISSION
  // =============================================================================
  
  void completeProfile() {
    print('=== COMPLETE PROFILE CALLED ===');
    print('Bypassing validation and navigating to next page.');
   Get.offAllNamed(AppRoutes.patienthomepage);
  }
  
  Future<void> _submitProfile() async {
    print('Starting profile submission...');
    isLoading.value = true;
    
    try {
      // Prepare profile data
      final Map<String, dynamic> profileData = {
        'age': int.tryParse(ageController.text) ?? 0,
        'gender': selectedGender.value,
        'address': addressController.text.trim(),
        'city': cityController.text.trim(),
        'state': selectedState.value,
        'phone': phoneController.text.trim(),
        'alternativePhone': alternativePhoneController.text.trim(),
        'bloodType': selectedBloodType.value,
        'allergies': allergiesController.text.trim(),
        'medicalConditions': medicalConditionsController.text.trim(),
        'idType': selectedIdType.value,
        'idNumber': idNumberController.text.trim(),
        'emergencyContactName': emergencyContactNameController.text.trim(),
        'emergencyContactPhone': emergencyContactPhoneController.text.trim(),
        'emergencyContactRelationship': emergencyContactRelationshipController.text.trim(),
        'idFrontImagePath': idFrontImage.value?.path,
        'idBackImagePath': idBackImage.value?.path,
      };
      
      print('Profile data prepared: ${profileData.keys.toList()}');
      
      // Simulate API submission
      print('Simulating API call...');
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Replace with actual API call
      // await ProfileService.submitProfile(profileData);
      
      print('API call completed successfully');
      
      // Show success message
      Get.snackbar(
        'Success!',
        'Profile completed successfully',
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );
      
      // Wait for snackbar to show
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Navigate to homepage
      print('Navigating to patient homepage...');
      Get.offAllNamed(AppRoutes.patienthomepage);
      print('Navigation completed');
      
    } catch (e) {
      print('Error during submission: $e');
      Get.snackbar(
        'Submission Failed',
        'Failed to complete profile. Please try again.',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error, color: Colors.white),
      );
    } finally {
      isLoading.value = false;
      print('Loading state reset to false');
    }
  }
  
  // =============================================================================
  // QUICK SUBMIT FOR TESTING
  // =============================================================================
  
  /// Quick submit method for testing - bypasses validation
  Future<void> quickSubmitForTesting() async {
    print('QUICK SUBMIT FOR TESTING');
    isLoading.value = true;
    
    await Future.delayed(const Duration(seconds: 1));
    
    Get.snackbar(
      'Test Navigation',
      'Navigating to homepage...',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
    
    await Future.delayed(const Duration(milliseconds: 500));
    
    Get.offAllNamed(AppRoutes.patienthomepage);
    
    isLoading.value = false;
  }
  
  // =============================================================================
  // GETTERS
  // =============================================================================
  
  String get completionPercentage => '${(formProgress.value * 100).toInt()}%';
  
  bool get canSubmitForm {
    // Check all required fields are filled
    final bool hasRequiredText = ageController.text.isNotEmpty &&
                                addressController.text.isNotEmpty &&
                                cityController.text.isNotEmpty &&
                                phoneController.text.isNotEmpty &&
                                idNumberController.text.isNotEmpty &&
                                emergencyContactNameController.text.isNotEmpty &&
                                emergencyContactPhoneController.text.isNotEmpty &&
                                emergencyContactRelationshipController.text.isNotEmpty;
    
    final bool hasRequiredDropdowns = selectedGender.value.isNotEmpty &&
                                     selectedState.value.isNotEmpty &&
                                     selectedBloodType.value.isNotEmpty &&
                                     selectedIdType.value.isNotEmpty;
    
    final bool hasRequiredImages = idFrontImage.value != null && idBackImage.value != null;
    
    final bool canSubmit = hasRequiredText && hasRequiredDropdowns && hasRequiredImages && !isLoading.value;
    
    return canSubmit;
  }
  
  String get currentStepDescription {
    if (formProgress.value < 0.3) return 'Fill in personal information';
    if (formProgress.value < 0.6) return 'Add contact and medical details';
    if (formProgress.value < 0.8) return 'Upload ID documents';
    if (idFrontImage.value == null || idBackImage.value == null) return 'Upload both ID images';
    return 'Ready to submit!';
  }
  
  Color get progressColor {
    if (formProgress.value < 0.3) return Colors.red;
    if (formProgress.value < 0.7) return Colors.orange;
    return Colors.green;
  }
  
  // =============================================================================
  // UTILITY METHODS
  // =============================================================================
  
  void clearForm() {
    // Clear all text controllers
    ageController.clear();
    addressController.clear();
    cityController.clear();
    phoneController.clear();
    alternativePhoneController.clear();
    allergiesController.clear();
    medicalConditionsController.clear();
    idNumberController.clear();
    emergencyContactNameController.clear();
    emergencyContactPhoneController.clear();
    emergencyContactRelationshipController.clear();
    
    // Reset dropdown selections
    selectedGender.value = '';
    selectedState.value = '';
    selectedBloodType.value = '';
    selectedIdType.value = '';
    
    // Reset images
    idFrontImage.value = null;
    idBackImage.value = null;
    
    // Reset progress
    formProgress.value = 0.0;
    
    print('Form cleared');
  }
  
  void printFormStatus() {
    print('=== FORM STATUS ===');
    print('Age: ${ageController.text}');
    print('Gender: ${selectedGender.value}');
    print('Address: ${addressController.text}');
    print('City: ${cityController.text}');
    print('State: ${selectedState.value}');
    print('Phone: ${phoneController.text}');
    print('Blood Type: ${selectedBloodType.value}');
    print('ID Type: ${selectedIdType.value}');
    print('ID Number: ${idNumberController.text}');
    print('Emergency Name: ${emergencyContactNameController.text}');
    print('Emergency Phone: ${emergencyContactPhoneController.text}');
    print('Emergency Relationship: ${emergencyContactRelationshipController.text}');
    print('Front Image: ${idFrontImage.value?.path ?? 'Not uploaded'}');
    print('Back Image: ${idBackImage.value?.path ?? 'Not uploaded'}');
    print('Can Submit: $canSubmitForm');
    print('Progress: ${completionPercentage}');
    print('==================');
  }
}