import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/auth/controllers/signup2controller.dart';
import 'package:healio_version_2/app/routes/approutes.dart';

// Define the primary color
const Color primaryColor = Color(0xFF002180);

/// Patient Profile Completion Page - Fixed Overflow Issues
class PatientProfileCompletionPage extends StatelessWidget {
  const PatientProfileCompletionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileCompletionController>(
      init: ProfileCompletionController(),
      builder: (controller) {
        return Scaffold(
          body: _buildBody(context, controller),
        );
      },
    );
  }

  // =============================================================================
  // BODY
  // =============================================================================

  Widget _buildBody(BuildContext context, ProfileCompletionController controller) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          _buildBackgroundImage(),
          _buildScrollableContent(context, controller),
          _buildAppBar(controller),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/images/patient/signupscreen1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildScrollableContent(BuildContext context, ProfileCompletionController controller) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 80.0, // Space for app bar
            bottom: MediaQuery.of(context).viewInsets.bottom + 40,
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildProfileImageSection(controller),
                const SizedBox(height: 24),
                _buildPageHeader(),
                const SizedBox(height: 20),
                _buildPersonalInfoSection(controller),
                _buildContactInfoSection(controller),
                _buildMedicalInfoSection(controller),
                _buildIdentificationSection(context, controller),
                _buildEmergencyContactSection(controller),
                const SizedBox(height: 24),
                _buildCompleteProfileButton(context, controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  // =============================================================================
  // PROFILE IMAGE SECTION
  // =============================================================================

  Widget _buildProfileImageSection(ProfileCompletionController controller) {
    return Center(
      child: Stack(
        children: [
          Obx(() {
            final image = controller.profileImage.value;
            return CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white.withOpacity(0.8),
              backgroundImage: image != null ? FileImage(image) : null,
              child: image == null
                  ? const Icon(Icons.person, size: 50, color: primaryColor)
                  : null,
            );
          }),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => controller.showImageSourceDialog(isProfile: true),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================================
  // APP BAR (CUSTOM)
  // =============================================================================

  Widget _buildAppBar(ProfileCompletionController controller) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
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
          title: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Complete Your Profile',
              style: TextStyle(
                color: primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
    );
  }

  // =============================================================================
  // PAGE HEADER
  // =============================================================================

  Widget _buildPageHeader() {
    return const Text(
      'Fill in your details to get started.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
        color: Colors.black54,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // =============================================================================
  // FORM SECTIONS
  // =============================================================================

  Widget _buildPersonalInfoSection(ProfileCompletionController controller) {
    return _buildSection(
      title: 'Personal Information',
      icon: Icons.person_outline,
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                controller: controller.ageController,
                label: 'Age',
                hint: 'Your age',
                icon: Icons.cake_outlined,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                validator: controller.validateAge,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: Obx(() => _buildDropdownField(
                label: 'Gender',
                hint: 'Select',
                icon: Icons.people_outline,
                value: controller.selectedGender.value.isEmpty ? null : controller.selectedGender.value,
                items: ProfileCompletionController.genderOptions,
                onChanged: controller.updateGender,
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              )),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: controller.addressController,
          label: 'Home Address',
          hint: 'Enter your full address',
          icon: Icons.home_outlined,
          maxLines: 2,
          validator: controller.validateAddress,
        ),
      ],
    );
  }

  Widget _buildContactInfoSection(ProfileCompletionController controller) {
    return _buildSection(
      title: 'Contact Information',
      icon: Icons.contact_phone_outlined,
      children: [
        _buildTextField(
          controller: controller.phoneController,
          label: 'Phone Number',
          hint: 'e.g., 08012345678',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: controller.validatePhoneNumber,
        ),
      ],
    );
  }

  Widget _buildMedicalInfoSection(ProfileCompletionController controller) {
    return _buildSection(
      title: 'Medical Information',
      icon: Icons.medical_services_outlined,
      children: [
        Obx(() => _buildDropdownField(
          label: 'Blood Type',
          hint: 'Select',
          icon: Icons.opacity_outlined,
          value: controller.selectedBloodType.value.isEmpty ? null : controller.selectedBloodType.value,
          items: ProfileCompletionController.bloodTypes,
          onChanged: controller.updateBloodType,
          validator: (value) => value == null || value.isEmpty ? 'Required' : null,
        )),
        const SizedBox(height: 12),
        _buildTextField(
          controller: controller.allergiesController,
          label: 'Known Allergies (Optional)',
          hint: 'e.g., Pollen, Peanuts',
          icon: Icons.warning_outlined,
        ),
      ],
    );
  }
  
  Widget _buildIdentificationSection(BuildContext context, ProfileCompletionController controller) {
    return _buildSection(
      title: 'Government Identification',
      icon: Icons.badge_outlined,
      children: [
        Obx(() => _buildDropdownField(
          label: 'ID Type',
          hint: 'Select ID type',
          icon: Icons.credit_card_outlined,
          value: controller.selectedIdType.value.isEmpty ? null : controller.selectedIdType.value,
          items: ProfileCompletionController.nigerianIdTypes,
          onChanged: controller.updateIdType,
          validator: (value) => value?.isEmpty ?? true ? 'Please select ID type' : null,
        )),
        const SizedBox(height: 12),
        _buildTextField(
          controller: controller.idNumberController,
          label: 'ID Number',
          hint: 'Enter your ID number',
          icon: Icons.confirmation_number_outlined,
          validator: controller.validateIdNumber,
        ),
        const SizedBox(height: 16),
        _buildIdUploadSection(controller),
      ],
    );
  }

  Widget _buildEmergencyContactSection(ProfileCompletionController controller) {
    return _buildSection(
      title: 'Emergency Contact',
      icon: Icons.emergency_outlined,
      children: [
        _buildTextField(
          controller: controller.emergencyContactNameController,
          label: 'Contact Name',
          hint: 'Enter emergency contact name',
          icon: Icons.person_outlined,
          validator: (value) => value?.isEmpty ?? true ? 'Please enter emergency contact name' : null,
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: controller.emergencyContactPhoneController,
          label: 'Contact Phone',
          hint: 'e.g., 08012345678',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
          validator: controller.validateEmergencyPhone,
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: controller.emergencyContactRelationshipController,
          label: 'Relationship',
          hint: 'e.g., Spouse, Parent, Sibling',
          icon: Icons.family_restroom_outlined,
          validator: (value) => value?.isEmpty ?? true ? 'Please enter relationship' : null,
        ),
      ],
    );
  }

  // =============================================================================
  // ID UPLOAD SECTION
  // =============================================================================

  Widget _buildIdUploadSection(ProfileCompletionController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload ID Documents',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Please upload clear photos of both sides of your ID',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            // Calculate available width for each card
            final availableWidth = constraints.maxWidth - 12; // Subtract spacing
            final cardWidth = availableWidth / 2;
            
            return Row(
              children: [
                SizedBox(
                  width: cardWidth,
                  child: _buildIdUploadCard(
                    title: 'Front Side',
                    controller: controller,
                    isBack: false,
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: cardWidth,
                  child: _buildIdUploadCard(
                    title: 'Back Side',
                    controller: controller,
                    isBack: true,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildIdUploadCard({
    required String title,
    required ProfileCompletionController controller,
    required bool isBack,
  }) {
    return Obx(() {
      final File? image = isBack ? controller.idBackImage.value : controller.idFrontImage.value;
      final bool isUploading = controller.isUploadingImage.value;
      
      return GestureDetector(
        onTap: isUploading ? null : () => controller.showImageSourceDialog(isBack: isBack),
        child: Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: image != null ? Colors.green : Colors.grey[400]!,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: isUploading 
              ? _buildUploadingWidget()
              : image != null
                  ? _buildImagePreview(image, isBack, controller)
                  : _buildUploadPlaceholder(title),
        ),
      );
    });
  }

  Widget _buildUploadingWidget() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2, 
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor)
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Uploading...',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview(File image, bool isBack, ProfileCompletionController controller) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            image,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: GestureDetector(
              onTap: () => controller.removeIdImage(isBack: isBack),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.close, color: Colors.white, size: 14),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          left: 4,
          right: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              isBack ? 'Back Side' : 'Front Side',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadPlaceholder(String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_photo_alternate_outlined,
          size: 28,
          color: Colors.grey[600],
        ),
        const SizedBox(height: 6),
        Flexible(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Tap to upload',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  // =============================================================================
  // FORM COMPONENTS
  // =============================================================================

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: primaryColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: _buildInputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon,
      ),
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 15, color: Color(0xFF333333)),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required IconData icon,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: _buildInputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon,
      ),
      items: items.map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item, 
          style: const TextStyle(fontSize: 15),
          overflow: TextOverflow.ellipsis,
        ),
      )).toList(),
      onChanged: onChanged,
      validator: validator,
      style: const TextStyle(fontSize: 15, color: Color(0xFF333333)),
      icon: const Icon(Icons.arrow_drop_down_rounded, color: Colors.grey),
      isExpanded: true,
    );
  }

  InputDecoration _buildInputDecoration({
    required String labelText,
    required String hintText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      labelStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 14),
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: primaryColor, size: 20) : null,
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primaryColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      isDense: true,
    );
  }

  // =============================================================================
  // SUBMIT BUTTON
  // =============================================================================

  Widget _buildCompleteProfileButton(BuildContext context, ProfileCompletionController controller) {
    return Obx(() {
      final isLoading = controller.isLoading.value;
      return ElevatedButton(
        onPressed: () {
          // TODO: Implement profile completion logic
           Get.offNamed(AppRoutes.patienthomepage);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text('Complete Profile'),
      );
    });
  }
}