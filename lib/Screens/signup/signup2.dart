import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/patients/controllers/signup2controller.dart';
import 'package:healio_version_2/app/routes/approutes.dart';
// import 'package:healio_version_2/app/modules/patients/controllers/profile_completion_controller.dart';
// import 'package:healio_version_2/core/constants/appcolors.dart';
// import 'package:healio_version_2/core/constants/appsizes.dart';
// import 'package:healio_version_2/core/constants/apptextstyles.dart';

/// Patient Profile Completion Page - Properly Structured UI
class PatientProfileCompletionPage extends StatelessWidget {
  const PatientProfileCompletionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileCompletionController>(
      init: ProfileCompletionController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(controller),
          body: _buildBody(context, controller),
        );
      },
    );
  }

  // =============================================================================
  // APP BAR
  // =============================================================================

  PreferredSizeWidget _buildAppBar(ProfileCompletionController controller) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        'Complete Profile',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(8.0),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() => Column(
            children: [
              LinearProgressIndicator(
                value: controller.formProgress.value,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(controller.progressColor),
              ),
              const SizedBox(height: 4),
              Text(
                '${controller.completionPercentage} - ${controller.currentStepDescription}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )),
        ),
      ),
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
          _buildBackgroundImage(context),
          _buildScrollableContent(context, controller),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/patient/signupscreen1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.7),
                Colors.white.withOpacity(0.9),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScrollableContent(BuildContext context, ProfileCompletionController controller) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPageHeader(),
              const SizedBox(height: 24),
              _buildPersonalInfoSection(controller),
              _buildContactInfoSection(controller),
              _buildMedicalInfoSection(controller),
              _buildIdentificationSection(context, controller),
              _buildEmergencyContactSection(controller),
              const SizedBox(height: 24),
              _buildCompleteProfileButton(context, controller),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // =============================================================================
  // PAGE HEADER
  // =============================================================================

  Widget _buildPageHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Let\'s complete your profile',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This information helps us provide better healthcare services',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            height: 1.4,
          ),
        ),
      ],
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
              child: _buildTextField(
                controller: controller.ageController,
                label: 'Age',
                hint: 'Enter your age',
                icon: Icons.cake_outlined,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                validator: controller.validateAge,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Obx(() => _buildDropdownField(
                label: 'Gender',
                hint: 'Select gender',
                icon: Icons.people_outline,
                value: controller.selectedGender.value.isEmpty ? null : controller.selectedGender.value,
                items: ProfileCompletionController.genderOptions,
                onChanged: controller.updateGender,
                validator: (value) => value?.isEmpty ?? true ? 'Please select gender' : null,
              )),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: controller.addressController,
          label: 'Home Address',
          hint: 'Enter your full address',
          icon: Icons.home_outlined,
          maxLines: 2,
          validator: controller.validateAddress,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Obx(() => _buildDropdownField(
                label: 'State',
                hint: 'Select state',
                icon: Icons.location_on_outlined,
                value: controller.selectedState.value.isEmpty ? null : controller.selectedState.value,
                items: ProfileCompletionController.nigerianStates,
                onChanged: controller.updateState,
                validator: (value) => value?.isEmpty ?? true ? 'Please select state' : null,
              )),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: controller.cityController,
                label: 'City/LGA',
                hint: 'Enter city',
                icon: Icons.location_city_outlined,
                validator: (value) => value?.isEmpty ?? true ? 'Please enter city' : null,
              ),
            ),
          ],
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
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
          validator: controller.validatePhoneNumber,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: controller.alternativePhoneController,
          label: 'Alternative Phone (Optional)',
          hint: 'e.g., 07098765432',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
          validator: controller.validateAlternativePhone,
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
          hint: 'Select blood type',
          icon: Icons.opacity_outlined,
          value: controller.selectedBloodType.value.isEmpty ? null : controller.selectedBloodType.value,
          items: ProfileCompletionController.bloodTypes,
          onChanged: controller.updateBloodType,
          validator: (value) => value?.isEmpty ?? true ? 'Please select blood type' : null,
        )),
        const SizedBox(height: 16),
        _buildTextField(
          controller: controller.allergiesController,
          label: 'Known Allergies (Optional)',
          hint: 'List any known allergies',
          icon: Icons.warning_outlined,
          maxLines: 2,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: controller.medicalConditionsController,
          label: 'Existing Medical Conditions (Optional)',
          hint: 'List any existing conditions',
          icon: Icons.health_and_safety_outlined,
          maxLines: 2,
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
        const SizedBox(height: 16),
        _buildTextField(
          controller: controller.idNumberController,
          label: 'ID Number',
          hint: 'Enter your ID number',
          icon: Icons.confirmation_number_outlined,
          validator: controller.validateIdNumber,
        ),
        const SizedBox(height: 20),
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
        const SizedBox(height: 16),
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
        const SizedBox(height: 16),
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
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Please upload clear photos of both sides of your ID',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildIdUploadCard(
                title: 'Front Side',
                controller: controller,
                isBack: false,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildIdUploadCard(
                title: 'Back Side',
                controller: controller,
                isBack: true,
              ),
            ),
          ],
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
          height: 140,
          decoration: BoxDecoration(
            border: Border.all(
              color: image != null ? Colors.green : Colors.grey[400]!,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
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
        CircularProgressIndicator(strokeWidth: 2),
        SizedBox(height: 12),
        Text(
          'Uploading...',
          style: TextStyle(
            fontSize: 12,
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
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            image,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 16),
              onPressed: () => controller.removeIdImage(isBack: isBack),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          left: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              isBack ? 'Back Side' : 'Front Side',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
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
          size: 40,
          color: Colors.grey[600],
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Tap to upload',
          style: TextStyle(
            fontSize: 12,
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
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.blue, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
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
      keyboardType: maxLines > 1 ? TextInputType.multiline : keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      textInputAction: maxLines > 1 ? TextInputAction.newline : TextInputAction.next,
      style: const TextStyle(fontSize: 16),
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
      value: value,
      decoration: _buildInputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon,
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      style: const TextStyle(fontSize: 16, color: Colors.black87),
      dropdownColor: Colors.white,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
      isExpanded: true,
    );
  }

  InputDecoration _buildInputDecoration({
    required String labelText,
    required String hintText,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      labelStyle: TextStyle(
        color: Colors.grey[700],
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(
        color: Colors.grey[500],
        fontSize: 16,
      ),
      prefixIcon: prefixIcon != null 
          ? Icon(prefixIcon, color: Colors.grey[600], size: 22) 
          : null,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    );
  }

  // =============================================================================
  // SUBMIT BUTTON
  // =============================================================================

  Widget _buildCompleteProfileButton(BuildContext context, ProfileCompletionController controller) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Obx(() {
        final bool canSubmit = controller.canSubmitForm;
        final bool isLoading = controller.isLoading.value;
        
        return ElevatedButton(
          onPressed: () {
            Get.offNamed(AppRoutes.patienthomepage);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: canSubmit ? Colors.blue : Colors.grey[400],
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: isLoading 
              ? _buildLoadingButtonContent()
              : _buildButtonContent(canSubmit, controller),
        );
      }),
    );
  }

  Widget _buildLoadingButtonContent() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        SizedBox(width: 12),
        Text('Completing Profile...'),
      ],
    );
  }

  Widget _buildButtonContent(bool canSubmit, ProfileCompletionController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          canSubmit ? Icons.check_circle_outline : Icons.info_outline,
          size: 24,
        ),
        const SizedBox(width: 8),
        Text(canSubmit ? 'Complete Profile' : controller.currentStepDescription),
      ],
    );
  }
}