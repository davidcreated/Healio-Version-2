import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Profile data model for API integration
class UserProfile {
  String fullName;
  String aboutYou;
  String weight;
  String height;
  String genotype;
  String bloodGroup;
  String gender;
  String email;
  String username;
  String displayLanguage;
  String country;
  String stateCity;
  String profileImagePath;
  bool notificationsEnabled;
  bool accountVerified;
  bool accountPrivacyEnabled;

  UserProfile({
    this.fullName = '',
    this.aboutYou = '',
    this.weight = '',
    this.height = '',
    this.genotype = '',
    this.bloodGroup = '',
    this.gender = '',
    this.email = '',
    this.username = '',
    this.displayLanguage = 'English',
    this.country = '',
    this.stateCity = '',
    this.profileImagePath = '',
    this.notificationsEnabled = true,
    this.accountVerified = false,
    this.accountPrivacyEnabled = false,
  });

  // Convert to JSON for API calls
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'aboutYou': aboutYou,
      'weight': weight,
      'height': height,
      'genotype': genotype,
      'bloodGroup': bloodGroup,
      'gender': gender,
      'email': email,
      'username': username,
      'displayLanguage': displayLanguage,
      'country': country,
      'stateCity': stateCity,
      'profileImagePath': profileImagePath,
      'notificationsEnabled': notificationsEnabled,
      'accountVerified': accountVerified,
      'accountPrivacyEnabled': accountPrivacyEnabled,
    };
  }

  // Create from JSON (for API responses)
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      fullName: json['fullName'] ?? '',
      aboutYou: json['aboutYou'] ?? '',
      weight: json['weight'] ?? '',
      height: json['height'] ?? '',
      genotype: json['genotype'] ?? '',
      bloodGroup: json['bloodGroup'] ?? '',
      gender: json['gender'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      displayLanguage: json['displayLanguage'] ?? 'English',
      country: json['country'] ?? '',
      stateCity: json['stateCity'] ?? '',
      profileImagePath: json['profileImagePath'] ?? '',
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      accountVerified: json['accountVerified'] ?? false,
      accountPrivacyEnabled: json['accountPrivacyEnabled'] ?? false,
    );
  }
}

class ProfileController extends GetxController {
  // User profile data
  final Rx<UserProfile> userProfile = UserProfile(
    fullName: 'Martins Joseph',
    username: '@josephdoe',
    aboutYou: 'I am Martins, 29 years old man, 1.70m height, currently I\'m living in Uyo - Akwa ibom.',
    weight: '70 kg',
    height: '1.70 m',
    genotype: 'AA',
    bloodGroup: 'O+',
    gender: 'Male',
    email: 'martinsjoe@gmail.com',
    country: 'Nigeria',
    stateCity: 'Uyo Akwa ibom',
  ).obs;

  // UI state variables
  final RxBool isLoading = false.obs;
  final RxBool isEditingProfile = false.obs;
  final RxString profileImagePath = ''.obs;
  final ImagePicker _imagePicker = ImagePicker();

  // Text controllers for editing
  final fullNameController = TextEditingController();
  final aboutYouController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final countryController = TextEditingController();
  final stateCityController = TextEditingController();

  // Dropdown selections
  final RxString selectedGenotype = 'AA'.obs;
  final RxString selectedBloodGroup = 'O+'.obs;
  final RxString selectedGender = 'Male'.obs;
  final RxString selectedLanguage = 'English'.obs;

  // Available options for dropdowns
  final List<String> genotypeOptions = ['AA', 'AS', 'SS', 'AC', 'SC'];
  final List<String> bloodGroupOptions = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> languageOptions = ['English', 'French', 'Spanish', 'Hausa', 'Yoruba', 'Igbo'];

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    _loadUserProfile();
  }

  /// Initialize text controllers with current profile data
  void _initializeControllers() {
    fullNameController.text = userProfile.value.fullName;
    aboutYouController.text = userProfile.value.aboutYou;
    weightController.text = userProfile.value.weight;
    heightController.text = userProfile.value.height;
    emailController.text = userProfile.value.email;
    usernameController.text = userProfile.value.username;
    countryController.text = userProfile.value.country;
    stateCityController.text = userProfile.value.stateCity;
    
    selectedGenotype.value = userProfile.value.genotype;
    selectedBloodGroup.value = userProfile.value.bloodGroup;
    selectedGender.value = userProfile.value.gender;
    selectedLanguage.value = userProfile.value.displayLanguage;
  }

  /// Load user profile from local storage or API
  Future<void> _loadUserProfile() async {
    try {
      isLoading.value = true;
      
      // Load from local storage first
      final prefs = await SharedPreferences.getInstance();
      final profileJson = prefs.getString('user_profile');
      
      if (profileJson != null) {
        // Load from local storage
        final profileMap = Map<String, dynamic>.from(
          Uri.splitQueryString(profileJson)
        );
        // userProfile.value = UserProfile.fromJson(profileMap);
      }
      
      // Then load from API (in real app)
      // final apiProfile = await userService.getUserProfile();
      // userProfile.value = apiProfile;
      // await _saveProfileLocally();
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load profile data',
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Save profile data locally
  Future<void> _saveProfileLocally() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_profile', userProfile.value.toJson().toString());
    } catch (e) {
      debugPrint('Error saving profile locally: $e');
    }
  }

  /// Update profile image
  Future<void> updateProfileImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        profileImagePath.value = pickedFile.path;
        userProfile.value.profileImagePath = pickedFile.path;
        
        // In real app, upload to server
        // await uploadProfileImageToServer(File(pickedFile.path));
        
        await _saveProfileLocally();
        
        Get.snackbar(
          'Success',
          'Profile image updated successfully',
          backgroundColor: Colors.green.shade400,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile image',
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
    }
  }

  /// Show image source selection dialog
  void showImageSourceDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Update Profile Picture'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Get.back();
                updateProfileImage(source: ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Get.back();
                updateProfileImage(source: ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Save profile changes
  Future<void> saveProfileChanges() async {
    try {
      isLoading.value = true;

      // Update profile with form data
      userProfile.value.fullName = fullNameController.text.trim();
      userProfile.value.aboutYou = aboutYouController.text.trim();
      userProfile.value.weight = weightController.text.trim();
      userProfile.value.height = heightController.text.trim();
      userProfile.value.email = emailController.text.trim();
      userProfile.value.username = usernameController.text.trim();
      userProfile.value.country = countryController.text.trim();
      userProfile.value.stateCity = stateCityController.text.trim();
      userProfile.value.genotype = selectedGenotype.value;
      userProfile.value.bloodGroup = selectedBloodGroup.value;
      userProfile.value.gender = selectedGender.value;
      userProfile.value.displayLanguage = selectedLanguage.value;

      // Validate required fields
      if (userProfile.value.fullName.isEmpty || userProfile.value.email.isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Full name and email are required',
          backgroundColor: Colors.orange.shade400,
          colorText: Colors.white,
        );
        return;
      }

      // Save to API (in real app)
      // await userService.updateUserProfile(userProfile.value);
      
      // Save locally
      await _saveProfileLocally();

      isEditingProfile.value = false;
      userProfile.refresh(); // Trigger UI update

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        backgroundColor: Colors.green.shade400,
        colorText: Colors.white,
      );

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile',
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Change password
  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      isLoading.value = true;

      // Validate password strength
      if (newPassword.length < 8) {
        Get.snackbar(
          'Weak Password',
          'Password must be at least 8 characters long',
          backgroundColor: Colors.orange.shade400,
          colorText: Colors.white,
        );
        return;
      }

      // API call to change password
      // await authService.changePassword(currentPassword, newPassword);

      Get.snackbar(
        'Success',
        'Password changed successfully',
        backgroundColor: Colors.green.shade400,
        colorText: Colors.white,
      );

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to change password',
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Toggle notification settings
  Future<void> toggleNotifications() async {
    userProfile.value.notificationsEnabled = !userProfile.value.notificationsEnabled;
    await _saveProfileLocally();
    
    Get.snackbar(
      'Notifications',
      userProfile.value.notificationsEnabled 
          ? 'Notifications enabled' 
          : 'Notifications disabled',
      backgroundColor: Colors.blue.shade400,
      colorText: Colors.white,
    );
  }

  /// Verify account (initiate verification process)
  Future<void> verifyAccount() async {
    try {
      isLoading.value = true;

      // In real app, start verification process
      // await verificationService.initiateVerification();

      Get.dialog(
        AlertDialog(
          title: const Text('Account Verification'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified_user, size: 48, color: Colors.blue),
              SizedBox(height: 16),
              Text('Verification process has been initiated. Please check your email for further instructions.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      );

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to initiate verification',
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Toggle account privacy
  Future<void> toggleAccountPrivacy() async {
    userProfile.value.accountPrivacyEnabled = !userProfile.value.accountPrivacyEnabled;
    await _saveProfileLocally();
    
    Get.snackbar(
      'Privacy Settings',
      userProfile.value.accountPrivacyEnabled 
          ? 'Account set to private' 
          : 'Account set to public',
      backgroundColor: Colors.blue.shade400,
      colorText: Colors.white,
    );
  }

  /// Navigate to different sections
  void navigateToSection(String section) {
    switch (section) {
      case 'notifications':
        Get.toNamed('/notification-settings');
        break;
      case 'account_verification':
        verifyAccount();
        break;
      case 'account_privacy':
        Get.toNamed('/privacy-settings');
        break;
      case 'change_password':
        _showChangePasswordDialog();
        break;
      default:
        debugPrint('Navigation to $section not implemented');
    }
  }

  /// Show change password dialog
  void _showChangePasswordDialog() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (newPasswordController.text == confirmPasswordController.text) {
                Get.back();
                changePassword(
                  currentPasswordController.text,
                  newPasswordController.text,
                );
              } else {
                Get.snackbar(
                  'Error',
                  'Passwords do not match',
                  backgroundColor: Colors.red.shade400,
                  colorText: Colors.white,
                );
              }
            },
            child: const Text('Change Password'),
          ),
        ],
      ),
    );
  }

  /// Logout user
  void logout() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout',style: TextStyle(color: Colors.black),),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel',style: TextStyle(color: Colors.black),),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              
              // Clear local data
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              
              // Navigate to login screen
              Get.offAllNamed('/ SignUp');
              
              Get.snackbar(
                'Logout',
                'You have been logged out successfully',
                backgroundColor: Colors.blue.shade400,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    fullNameController.dispose();
    aboutYouController.dispose();
    weightController.dispose();
    heightController.dispose();
    emailController.dispose();
    usernameController.dispose();
    countryController.dispose();
    stateCityController.dispose();
    super.onClose();
  }
}
// State management
final RxInt selectedIndex = 3.obs; // Profile tab
bool get isTablet => Get.width > 600;

// Navigation handling
void onTabSelected(int index) {
  selectedIndex.value = index;
}

void navigateToTab(int index) {
  // Routes to /home, /doctors, /prescriptions, or stays on profile
}