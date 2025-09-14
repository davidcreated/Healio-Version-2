import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/patienthomepage.dart';
import 'package:healio_version_2/Screens/PatientSection/homepage/prescriptionscreen.dart';
import 'package:healio_version_2/app/modules/profile/controllers/profilecontroller.dart';

// Import your controller
// import 'profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: _buildAppBar(controller),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : _buildProfileContent(controller)),
    );
  }

   /// Handles bottom navigation with proper navigation logic
  void _handleBottomNavigation(int index) {
    switch (index) {
      case 0:
        // Home - Navigate back to HomePage
        // Uncomment and update with your actual HomePage import
         Get.off(() => const HomePage());
        
        // Temporary fallback - navigate back
        Get.back();
        break;
        
      case 1:
        // Doctors - Already on Doctors page, no navigation needed
        break;
        
      case 2:
        // Prescriptions - Navigate to Prescriptions page
        // Uncomment and update with your actual prescriptions page
        Get.to(
          () => const Prescriptionpage(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 300),
        );

     
        break;
        
      case 3:
        // Profile - Navigate to Profile page
        // Uncomment and update with your actual profile page
         Get.to(
          () => const ProfilePage(),
           transition: Transition.rightToLeftWithFade,
           duration: const Duration(milliseconds: 300),
         );
        
     
        break;
        
      default:
        // Invalid index - should not happen
        break;
    }
  }

  /// Build app bar
  PreferredSizeWidget _buildAppBar(ProfileController controller) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF002180),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
        ),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        'Profile Details',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF061234),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.red),
          onPressed: controller.logout,
        ),
      ],
    );
  }

  /// Build main profile content
  Widget _buildProfileContent(ProfileController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Profile header with image and basic info
          _buildProfileHeader(controller),
          const SizedBox(height: 24),

          // General Profile Settings Section
          _buildSectionCard(
            title: 'GENERAL PROFILE SETTINGS',
            color: const Color(0xFFE8F5E8),
            children: [
              _buildProfileField(
                icon: Icons.person,
                title: 'Full Name',
                subtitle: controller.userProfile.value.fullName,
                onTap: () => _showEditDialog(
                  controller,
                  'Full Name',
                  controller.fullNameController,
                  'fullName',
                ),
              ),
              _buildProfileField(
                icon: Icons.info,
                title: 'About you',
                subtitle: controller.userProfile.value.aboutYou,
                maxLines: 2,
                onTap: () => _showEditDialog(
                  controller,
                  'About You',
                  controller.aboutYouController,
                  'aboutYou',
                  maxLines: 4,
                ),
              ),
              _buildProfileField(
                icon: Icons.fitness_center,
                title: 'Weight',
                subtitle: controller.userProfile.value.weight,
                onTap: () => _showEditDialog(
                  controller,
                  'Weight (kg)',
                  controller.weightController,
                  'weight',
                  keyboardType: TextInputType.number,
                ),
              ),
              _buildProfileField(
                icon: Icons.height,
                title: 'Height',
                subtitle: controller.userProfile.value.height,
                onTap: () => _showEditDialog(
                  controller,
                  'Height (m)',
                  controller.heightController,
                  'height',
                  keyboardType: TextInputType.number,
                ),
              ),
              _buildProfileField(
                icon: Icons.biotech,
                title: 'Genotype',
                subtitle: controller.userProfile.value.genotype,
                onTap: () => _showDropdownDialog(
                  controller,
                  'Genotype',
                  controller.genotypeOptions,
                  controller.selectedGenotype,
                  'genotype',
                ),
              ),
              _buildProfileField(
                icon: Icons.bloodtype,
                title: 'Blood group',
                subtitle: controller.userProfile.value.bloodGroup,
                onTap: () => _showDropdownDialog(
                  controller,
                  'Blood Group',
                  controller.bloodGroupOptions,
                  controller.selectedBloodGroup,
                  'bloodGroup',
                ),
              ),
              _buildProfileField(
                icon: Icons.person_outline,
                title: 'Gender',
                subtitle: controller.userProfile.value.gender,
                onTap: () => _showDropdownDialog(
                  controller,
                  'Gender',
                  controller.genderOptions,
                  controller.selectedGender,
                  'gender',
                ),
              ),
              _buildProfileField(
                icon: Icons.email,
                title: 'Email address',
                subtitle: controller.userProfile.value.email,
                onTap: () => _showEditDialog(
                  controller,
                  'Email Address',
                  controller.emailController,
                  'email',
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Login Details Section
          _buildSectionCard(
            title: 'LOGIN DETAILS',
            color: const Color(0xFFE8F5E8),
            children: [
              _buildProfileField(
                icon: Icons.person,
                title: 'Username',
                subtitle: controller.userProfile.value.username,
                onTap: () => _showEditDialog(
                  controller,
                  'Username',
                  controller.usernameController,
                  'username',
                ),
              ),
              _buildProfileField(
                icon: Icons.lock,
                title: 'My password',
                subtitle: '••••••••',
                onTap: () => controller.navigateToSection('change_password'),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Language and Country Section
          _buildSectionCard(
            title: 'LANGUAGE AND COUNTRY',
            color: const Color(0xFFE8F5E8),
            children: [
              _buildProfileField(
                icon: Icons.language,
                title: 'Display language',
                subtitle: controller.userProfile.value.displayLanguage,
                onTap: () => _showDropdownDialog(
                  controller,
                  'Display Language',
                  controller.languageOptions,
                  controller.selectedLanguage,
                  'displayLanguage',
                ),
              ),
              _buildProfileField(
                icon: Icons.flag,
                title: 'Your country',
                subtitle: controller.userProfile.value.country,
                onTap: () => _showEditDialog(
                  controller,
                  'Country',
                  controller.countryController,
                  'country',
                ),
              ),
              _buildProfileField(
                icon: Icons.location_city,
                title: 'Your state / City',
                subtitle: controller.userProfile.value.stateCity,
                onTap: () => _showEditDialog(
                  controller,
                  'State / City',
                  controller.stateCityController,
                  'stateCity',
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Notification Settings Section
          _buildSectionCard(
            title: 'NOTIFICATIONS SETTINGS',
            color: const Color(0xFFE8F5E8),
            children: [
              _buildProfileField(
                icon: Icons.notifications,
                title: 'Notifications',
                subtitle: 'Customize your notifications',
                onTap: () => controller.navigateToSection('notifications'),
                trailing: Switch(
                  value: controller.userProfile.value.notificationsEnabled,
                  onChanged: (_) => controller.toggleNotifications(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Account Verification Section
          _buildSectionCard(
            title: 'ACCOUNT VERIFICATION',
            color: const Color(0xFFE8F5E8),
            children: [
              _buildProfileField(
                icon: Icons.verified_user,
                title: 'Verify my account',
                subtitle: controller.userProfile.value.accountVerified 
                    ? 'Your account has been verified'
                    : 'Your account has not been verified',
                onTap: () => controller.navigateToSection('account_verification'),
                trailing: controller.userProfile.value.accountVerified
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : const Icon(Icons.error, color: Colors.orange),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Account Privacy Settings Section
          _buildSectionCard(
            title: 'ACCOUNT PRIVACY SETTINGS',
            color: const Color(0xFFE8F5E8),
            children: [
              _buildProfileField(
                icon: Icons.privacy_tip,
                title: 'Account privacy',
                subtitle: 'Set your account privacy',
                onTap: () => controller.navigateToSection('account_privacy'),
                trailing: Switch(
                  value: controller.userProfile.value.accountPrivacyEnabled,
                  onChanged: (_) => controller.toggleAccountPrivacy(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // My Account Information Section
          _buildSectionCard(
            title: 'MY ACCOUNT INFORMATION',
            color: const Color(0xFFE8F5E8),
            children: [
              _buildProfileField(
                icon: Icons.download,
                title: 'Download my data',
                subtitle: 'Get a copy of your data',
                onTap: () => _showDataDownloadDialog(),
              ),
              _buildProfileField(
                icon: Icons.delete_forever,
                title: 'Delete my account',
                subtitle: 'Permanently delete account',
                onTap: () => _showDeleteAccountDialog(),
                titleColor: Colors.red,
              ),
            ],
          ),

          const SizedBox(height: 100), // Space for bottom navigation
        ],
      ),
    );
  }

  /// Build profile header with image and basic info
  Widget _buildProfileHeader(ProfileController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile image with edit button
          Stack(
            children: [
              Obx(() => CircleAvatar(
                radius: 50,
                backgroundColor: const Color(0xFFFFA500),
                backgroundImage: controller.profileImagePath.value.isNotEmpty
                    ? FileImage(File(controller.profileImagePath.value))
                    : null,
                child: controller.profileImagePath.value.isEmpty
                    ? Text(
                        controller.userProfile.value.fullName.isNotEmpty
                            ? controller.userProfile.value.fullName[0].toUpperCase()
                            : 'U',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    : null,
              )),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: controller.showImageSourceDialog,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF002180),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Name and username
          Obx(() => Text(
            controller.userProfile.value.fullName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF061234),
            ),
          )),
          const SizedBox(height: 4),
          Obx(() => Text(
            controller.userProfile.value.username,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          )),
        ],
      ),
    );
  }

  /// Build section card with title and children
  Widget _buildSectionCard({
    required String title,
    required Color color,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF061234),
                  ),
                ),
              ],
            ),
          ),
          
          // Section content
          ...children,
        ],
      ),
    );
  }

  /// Build individual profile field
  Widget _buildProfileField({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    Widget? trailing,
    int maxLines = 1,
    Color? titleColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade100, width: 1),
          ),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 20,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(width: 16),
            
            // Title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: titleColor ?? const Color(0xFF061234),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.3,
                    ),
                    maxLines: maxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Trailing widget or edit icon
            trailing ?? const Icon(
              Icons.edit,
              size: 20,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  /// Show edit dialog for text fields
  void _showEditDialog(
    ProfileController controller,
    String title,
    TextEditingController textController,
    String fieldName, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    Get.dialog(
      AlertDialog(
        title: Text('Edit $title'),
        content: TextField(
          controller: textController,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: title,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.saveProfileChanges();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF002180),
            ),
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  /// Show dropdown dialog for selection fields
  void _showDropdownDialog(
    ProfileController controller,
    String title,
    List<String> options,
    RxString selectedValue,
    String fieldName,
  ) {
    Get.dialog(
      AlertDialog(
        title: Text('Select $title'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: selectedValue.value,
              onChanged: (value) {
                selectedValue.value = value!;
                Get.back();
                controller.saveProfileChanges();
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  /// Show data download confirmation dialog
  void _showDataDownloadDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Download Data'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.download, size: 48, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'We will prepare your data and send a download link to your email address. This may take a few minutes.',
              textAlign: TextAlign.center,
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
              Get.back();
              Get.snackbar(
                'Data Download',
                'Your data download has been requested. Check your email shortly.',
                backgroundColor: Colors.blue.shade400,
                colorText: Colors.white,
                duration: const Duration(seconds: 4),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text('Request Download', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  /// Show delete account confirmation dialog
  void _showDeleteAccountDialog() {
    final reasonController = TextEditingController();
    
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'This action cannot be undone. Your account and all associated data will be permanently deleted.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason for deletion (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
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
              Get.back();
              Get.snackbar(
                'Account Deletion',
                'Account deletion request submitted. You will receive a confirmation email.',
                backgroundColor: Colors.red.shade400,
                colorText: Colors.white,
                duration: const Duration(seconds: 4),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete Account', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// Add these dependencies to pubspec.yaml:
// dependencies:
//   get: ^4.6.6
//   image_picker: ^1.0.4
//   shared_preferences: ^2.2.2