import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

/// Controller for Doctor Signup Form
/// Manages all form state, validation, and business logic
class DoctorSignup2Controller extends GetxController {
  
  // ===================== TEXT CONTROLLERS =====================
  final TextEditingController specializationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController medicalSchoolController = TextEditingController();
  final TextEditingController fellowshipController = TextEditingController();
  final TextEditingController consultationFeeController = TextEditingController();
  final TextEditingController clinicAddressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  // ===================== OBSERVABLE VARIABLES =====================
  /// Agreement to terms and conditions
  var agreeToTerms = false.obs;
  
  /// Loading state for form submission
  var isLoading = false.obs;
  
  /// Selected license file for upload
  var selectedLicenseFile = Rx<File?>(null);
  
  /// Selected certificate file for upload
  var selectedCertificateFile = Rx<File?>(null);
  
  /// Currently selected medical specialization
  var selectedSpecialization = ''.obs;
  
  /// Currently selected Nigerian state
  var selectedState = ''.obs;
  
  /// Currently selected Local Government Area
  var selectedLGA = ''.obs;
  
  /// Whether doctor offers online consultations
  var isConsultationOnline = false.obs;
  
  /// Whether doctor offers in-person consultations
  var isConsultationInPerson = false.obs;

  // ===================== DATA LISTS =====================
  /// List of all Nigerian states
  final List<String> nigerianStates = [
    'Abia', 'Adamawa', 'Akwa Ibom', 'Anambra', 'Bauchi', 'Bayelsa', 'Benue',
    'Borno', 'Cross River', 'Delta', 'Ebonyi', 'Edo', 'Ekiti', 'Enugu',
    'FCT - Abuja', 'Gombe', 'Imo', 'Jigawa', 'Kaduna', 'Kano', 'Katsina',
    'Kebbi', 'Kogi', 'Kwara', 'Lagos', 'Nasarawa', 'Niger', 'Ogun', 'Ondo',
    'Osun', 'Oyo', 'Plateau', 'Rivers', 'Sokoto', 'Taraba', 'Yobe', 'Zamfara'
  ];

  /// List of common medical specializations in Nigeria
  final List<String> medicalSpecializations = [
    'General Practice',
    'Internal Medicine',
    'Pediatrics',
    'Obstetrics & Gynecology',
    'Surgery',
    'Cardiology',
    'Dermatology',
    'Neurology',
    'Orthopedics',
    'Psychiatry',
    'Radiology',
    'Pathology',
    'Anesthesiology',
    'Emergency Medicine',
    'Family Medicine',
    'Ophthalmology',
    'ENT (Otorhinolaryngology)',
    'Urology',
    'Oncology',
    'Endocrinology',
    'Gastroenterology',
    'Pulmonology',
    'Nephrology',
    'Rheumatology',
    'Infectious Disease',
    'Public Health'
  ];

  /// Map of Nigerian states to their Local Government Areas
  final Map<String, List<String>> stateLGAs = {
    'Lagos': [
      'Agege', 'Ajeromi-Ifelodun', 'Alimosho', 'Amuwo-Odofin', 'Apapa',
      'Badagry', 'Epe', 'Eti-Osa', 'Ibeju-Lekki', 'Ifako-Ijaiye',
      'Ikeja', 'Ikorodu', 'Kosofe', 'Lagos Island', 'Lagos Mainland',
      'Mushin', 'Ojo', 'Oshodi-Isolo', 'Shomolu', 'Surulere'
    ],
    'FCT - Abuja': [
      'Abaji', 'Bwari', 'Gwagwalada', 'Kuje', 'Kwali', 'Municipal Area Council'
    ],
    'Kano': [
      'Ajingi', 'Albasu', 'Bagwai', 'Bebeji', 'Bichi', 'Bunkure',
      'Dala', 'Dambatta', 'Dawakin Kudu', 'Dawakin Tofa', 'Doguwa',
      'Fagge', 'Gabasawa', 'Garko', 'Garun Mallam', 'Gaya', 'Gezawa',
      'Gwale', 'Gwarzo', 'Kabo', 'Kano Municipal', 'Karaye', 'Kibiya',
      'Kiru', 'Kumbotso', 'Kunchi', 'Kura', 'Madobi', 'Makoda',
      'Minjibir', 'Nasarawa', 'Rano', 'Rimin Gado', 'Rogo', 'Shanono',
      'Sumaila', 'Takai', 'Tarauni', 'Tofa', 'Tsanyawa', 'Tudun Wada',
      'Ungogo', 'Warawa', 'Wudil'
    ],
    'Rivers': [
      'Abua/Odual', 'Ahoada East', 'Ahoada West', 'Akuku-Toru', 'Andoni',
      'Asari-Toru', 'Bonny', 'Degema', 'Eleme', 'Emohua', 'Etche',
      'Gokana', 'Ikwerre', 'Khana', 'Obio/Akpor', 'Ogba/Egbema/Ndoni',
      'Ogu/Bolo', 'Okrika', 'Omuma', 'Opobo/Nkoro', 'Oyigbo',
      'Port Harcourt', 'Tai'
    ],
    'Edo': [
      'Akoko-Edo', 'Egor', 'Esan Central', 'Esan North-East', 'Esan South-East',
      'Esan West', 'Etsako Central', 'Etsako East', 'Etsako West', 'Igueben',
      'Ikpoba-Okha', 'Oredo', 'Orhionmwon', 'Ovia North-East', 'Ovia South-West',
      'Owan East', 'Owan West', 'Uhunmwonde'
    ],
    // Add more states as needed
  };

  // ===================== LIFECYCLE METHODS =====================
  @override
  void onInit() {
    super.onInit();
    _setupValidation();
  }

  @override
  void onClose() {
    // Dispose of all text controllers
    specializationController.dispose();
    experienceController.dispose();
    licenseController.dispose();
    medicalSchoolController.dispose();
    fellowshipController.dispose();
    consultationFeeController.dispose();
    clinicAddressController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }

  // ===================== FORM CONTROL METHODS =====================
  /// Setup form validation listeners
  void _setupValidation() {
    specializationController.addListener(() {
      if (selectedSpecialization.value != specializationController.text) {
        selectedSpecialization.value = specializationController.text;
      }
    });
  }

  /// Toggle agreement to terms and conditions
  void toggleTermsAgreement(bool? value) {
    agreeToTerms.value = value ?? false;
  }

  /// Toggle online consultation availability
  void toggleOnlineConsultation(bool value) {
    isConsultationOnline.value = value;
  }

  /// Toggle in-person consultation availability  
  void toggleInPersonConsultation(bool value) {
    isConsultationInPerson.value = value;
  }

  /// Set selected medical specialization
  void setSpecialization(String specialization) {
    selectedSpecialization.value = specialization;
    specializationController.text = specialization;
  }

  /// Set selected Nigerian state and clear LGA selection
  void setState(String state) {
    selectedState.value = state;
    selectedLGA.value = ''; // Clear LGA when state changes
  }

  /// Set selected Local Government Area
  void setLGA(String lga) {
    selectedLGA.value = lga;
  }

  /// Get list of LGAs for the currently selected state
  List<String> getLGAsForSelectedState() {
    return stateLGAs[selectedState.value] ?? [];
  }

  // ===================== FILE HANDLING METHODS =====================
  /// Pick and upload medical license file
  Future<void> pickLicenseFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        selectedLicenseFile.value = File(result.files.single.path!);
        _showSuccessMessage('License file uploaded successfully');
      }
    } catch (e) {
      _showErrorMessage('Failed to upload license file: ${e.toString()}');
    }
  }

  /// Pick and upload medical certificate file
  Future<void> pickCertificateFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        selectedCertificateFile.value = File(result.files.single.path!);
        _showSuccessMessage('Certificate uploaded successfully');
      }
    } catch (e) {
      _showErrorMessage('Failed to upload certificate: ${e.toString()}');
    }
  }

  // ===================== VALIDATION METHODS =====================
  /// Validate Nigerian phone number format
  bool isValidNigerianPhone(String phone) {
    String cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    RegExp nigerianPhoneRegex = RegExp(r'^(\+?234|0)?[7-9][0-1]\d{8}$');
    return nigerianPhoneRegex.hasMatch(cleanPhone);
  }

  /// Validate MDCN license number format
  bool isValidMDCNLicense(String license) {
    RegExp mdcnRegex = RegExp(r'^MDCN[-\s]?\d{4,6}$', caseSensitive: false);
    return mdcnRegex.hasMatch(license.trim());
  }

  /// Validate all required form fields
  bool validateForm() {
    // Check specialization
    if (selectedSpecialization.value.isEmpty) {
      _showValidationError('Please select your medical specialization');
      return false;
    }

    // Check experience
    if (experienceController.text.trim().isEmpty) {
      _showValidationError('Please enter your years of experience');
      return false;
    }

    // Validate experience is a number
    final experience = int.tryParse(experienceController.text.trim());
    if (experience == null || experience < 0) {
      _showValidationError('Please enter a valid number of years of experience');
      return false;
    }

    // Check medical school
    if (medicalSchoolController.text.trim().isEmpty) {
      _showValidationError('Please enter your medical school');
      return false;
    }

    // Check license number
    if (licenseController.text.trim().isEmpty) {
      _showValidationError('Please enter your MDCN license number');
      return false;
    }

    if (!isValidMDCNLicense(licenseController.text.trim())) {
      _showValidationError('Please enter a valid MDCN license number (e.g., MDCN-12345)');
      return false;
    }

    // Validate phone number if provided
    if (phoneNumberController.text.trim().isNotEmpty && 
        !isValidNigerianPhone(phoneNumberController.text.trim())) {
      _showValidationError('Please enter a valid Nigerian phone number');
      return false;
    }

    // Check state selection
    if (selectedState.value.isEmpty) {
      _showValidationError('Please select your state of practice');
      return false;
    }

    // Check consultation types
    if (!isConsultationOnline.value && !isConsultationInPerson.value) {
      _showValidationError('Please select at least one consultation type');
      return false;
    }

    // Check license file upload
    if (selectedLicenseFile.value == null) {
      _showValidationError('Please upload your medical license document');
      return false;
    }

    // Check terms agreement
    if (!agreeToTerms.value) {
      _showValidationError('Please agree to the terms and conditions');
      return false;
    }

    return true;
  }

  // ===================== FORM SUBMISSION =====================
  /// Submit the doctor registration form
  Future<void> submitRegistration() async {
    // Validate form first
    if (!validateForm()) return;

    try {
      isLoading.value = true;

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Here you would typically make an API call to submit the data
      // await _apiService.submitDoctorRegistration(getFormData());

      // Show success message
      _showSuccessMessage('Registration submitted successfully!');

      // Navigate to next screen (you'll need to implement navigation)
       Get.toNamed('/availability');

    } catch (e) {
      _showErrorMessage('Failed to submit registration: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  /// Get form data as a Map for API submission
  Map<String, dynamic> getFormData() {
    return {
      'specialization': selectedSpecialization.value,
      'experience': experienceController.text.trim(),
      'medicalSchool': medicalSchoolController.text.trim(),
      'licenseNumber': licenseController.text.trim(),
      'fellowship': fellowshipController.text.trim(),
      'phoneNumber': phoneNumberController.text.trim(),
      'state': selectedState.value,
      'lga': selectedLGA.value,
      'clinicAddress': clinicAddressController.text.trim(),
      'consultationFee': consultationFeeController.text.trim(),
      'onlineConsultation': isConsultationOnline.value,
      'inPersonConsultation': isConsultationInPerson.value,
      'licenseFile': selectedLicenseFile.value?.path,
      'certificateFile': selectedCertificateFile.value?.path,
    };
  }

  // ===================== NAVIGATION METHODS =====================
  /// Navigate to sign in page
  void navigateToSignIn() {
    // You can implement navigation here
    // Get.toNamed('/signin');
    // Or use Get.back() if coming from sign in page
    Get.back();
  }

  // ===================== HELPER METHODS =====================
  /// Show validation error message
  void _showValidationError(String message) {
    Get.snackbar(
      'Validation Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }

  /// Show success message
  void _showSuccessMessage(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }

  /// Show error message
  void _showErrorMessage(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }

  // ===================== UTILITY METHODS =====================
  /// Clear all form fields
  void clearForm() {
    // Clear text controllers
    specializationController.clear();
    experienceController.clear();
    licenseController.clear();
    medicalSchoolController.clear();
    fellowshipController.clear();
    consultationFeeController.clear();
    clinicAddressController.clear();
    phoneNumberController.clear();

    // Reset observable variables
    agreeToTerms.value = false;
    selectedLicenseFile.value = null;
    selectedCertificateFile.value = null;
    selectedSpecialization.value = '';
    selectedState.value = '';
    selectedLGA.value = '';
    isConsultationOnline.value = false;
    isConsultationInPerson.value = false;
  }

  /// Check if form has been modified
  bool get isFormDirty {
    return specializationController.text.isNotEmpty ||
           experienceController.text.isNotEmpty ||
           licenseController.text.isNotEmpty ||
           medicalSchoolController.text.isNotEmpty ||
           fellowshipController.text.isNotEmpty ||
           consultationFeeController.text.isNotEmpty ||
           clinicAddressController.text.isNotEmpty ||
           phoneNumberController.text.isNotEmpty ||
           selectedLicenseFile.value != null ||
           selectedCertificateFile.value != null ||
           isConsultationOnline.value ||
           isConsultationInPerson.value;
  }
}