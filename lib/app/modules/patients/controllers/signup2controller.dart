import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/routes/approutes.dart'; // Make sure this import path is correct
import 'package:image_picker/image_picker.dart';

/// CONTROLLER FOR PATIENT PROFILE COMPLETION PAGE
/// This manages all the state and logic for the PatientProfileCompletionPage.
class ProfileCompletionController extends GetxController {
  static ProfileCompletionController get to => Get.find();

  // ===========================================================================
  // FORM MANAGEMENT & STATE
  // ===========================================================================
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;
  final isUploadingImage = false.obs;
  final _imagePicker = ImagePicker();

  // ===========================================================================
  // TEXT EDITING CONTROLLERS (All controllers required by the UI)
  // ===========================================================================
  late TextEditingController ageController;
  late TextEditingController addressController;
  late TextEditingController phoneController;
  late TextEditingController allergiesController; // ✅ Added
  late TextEditingController idNumberController;
  late TextEditingController emergencyContactNameController; // ✅ Added
  late TextEditingController emergencyContactPhoneController; // ✅ Added
  late TextEditingController emergencyContactRelationshipController; // ✅ Added

  // ===========================================================================
  // REACTIVE VARIABLES FOR DROPDOWNS & IMAGES
  // ===========================================================================
  final selectedGender = ''.obs;
  final selectedBloodType = ''.obs;
  final selectedIdType = ''.obs;
  final profileImage = Rx<File?>(null);
  final idFrontImage = Rx<File?>(null);
  final idBackImage = Rx<File?>(null);

  // ===========================================================================
  // STATIC DATA FOR DROPDOWNS
  // ===========================================================================
  static const List<String> genderOptions = ['Male', 'Female', 'Other'];
  static const List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  static const List<String> nigerianIdTypes = [
    'National Identity Number (NIN)',
    'Permanent Voter\'s Card (PVC)',
    'Driver\'s License',
    'International Passport',
  ];

  // ===========================================================================
  // LIFECYCLE METHODS (Initialization and Disposal)
  // ===========================================================================
  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
  }

  @override
  void onClose() {
    _disposeControllers();
    super.onClose();
  }

  void _initializeControllers() {
    ageController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    allergiesController = TextEditingController();
    idNumberController = TextEditingController();
    emergencyContactNameController = TextEditingController();
    emergencyContactPhoneController = TextEditingController();
    emergencyContactRelationshipController = TextEditingController();
  }

  void _disposeControllers() {
    ageController.dispose();
    addressController.dispose();
    phoneController.dispose();
    allergiesController.dispose();
    idNumberController.dispose();
    emergencyContactNameController.dispose();
    emergencyContactPhoneController.dispose();
    emergencyContactRelationshipController.dispose();
  }

  // ===========================================================================
  // IMAGE HANDLING
  // ===========================================================================

  Future<void> showImageSourceDialog({bool isProfile = false, bool isBack = false}) async {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a photo'),
              onTap: () {
                Get.back();
                _pickImageFromSource(ImageSource.camera, isProfile: isProfile, isBack: isBack);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
              onTap: () {
                Get.back();
                _pickImageFromSource(ImageSource.gallery, isProfile: isProfile, isBack: isBack);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromSource(ImageSource source, {required bool isProfile, required bool isBack}) async {
    if (isUploadingImage.value) return;
    isUploadingImage.value = true;
    try {
      final pickedFile = await _imagePicker.pickImage(source: source, imageQuality: 80);
      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        String successMessage;
        if (isProfile) {
          profileImage.value = imageFile;
          successMessage = 'Profile photo updated!';
        } else if (isBack) {
          idBackImage.value = imageFile;
          successMessage = 'ID back image uploaded!';
        } else {
          idFrontImage.value = imageFile;
          successMessage = 'ID front image uploaded!';
        }
        Get.snackbar('Success', successMessage, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: ${e.toString()}');
    } finally {
      isUploadingImage.value = false;
    }
  }

  void removeIdImage({required bool isBack}) {
    if (isBack) {
      idBackImage.value = null;
    } else {
      idFrontImage.value = null;
    }
    Get.snackbar('Removed', isBack ? 'Back ID image removed' : 'Front ID image removed');
  }

  // ===========================================================================
  // DROPDOWN HANDLERS
  // ===========================================================================
  void updateGender(String? value) {
    if (value != null) selectedGender.value = value;
  }

  void updateBloodType(String? value) {
    if (value != null) selectedBloodType.value = value;
  }

  void updateIdType(String? value) {
    if (value != null) selectedIdType.value = value;
  }

  // ===========================================================================
  // VALIDATORS
  // ===========================================================================
  String? validateAge(String? value) => (value?.isEmpty ?? true) ? 'Please enter your age' : null;
  String? validateAddress(String? value) => (value?.isEmpty ?? true) ? 'Please enter your address' : null;
  String? validatePhoneNumber(String? value) => (value?.isEmpty ?? true) ? 'Please enter a phone number' : null;
  String? validateIdNumber(String? value) => (value?.isEmpty ?? true) ? 'Please enter your ID number' : null;
  String? validateEmergencyPhone(String? value) => (value?.isEmpty ?? true) ? 'Please enter an emergency phone number' : null;

  // ===========================================================================
  // FORM SUBMISSION
  // ===========================================================================
  Future<void> completeProfile() async {
    final isFormValid = formKey.currentState?.validate() ?? false;
    if (!isFormValid) {
      Get.snackbar('Error', 'Please fill all required fields correctly.');
      return;
    }

    isLoading.value = true;
    try {
      // Simulate saving data to a server
      await Future.delayed(const Duration(seconds: 2));
      print('Profile data submitted successfully!');
      
      Get.snackbar('Success', 'Profile completed successfully!', backgroundColor: Colors.green, colorText: Colors.white);
      
      // Navigate to the homepage after successful submission
      Get.offAllNamed(AppRoutes.patienthomepage);

    } catch (e) {
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
}