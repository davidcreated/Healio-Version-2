import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/doctors/controllers/doctorsignup2controller.dart';


class Doctorsignup2 extends StatelessWidget {
  const Doctorsignup2({super.key});

  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    // Initialize the GetX controller
    final DoctorSignup2Controller controller = Get.put(DoctorSignup2Controller());

    return Scaffold(
      
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      // Background Image
                      Positioned.fill(
                        child: Image.asset(
                          'lib/assets/images/doctors/Sign up Screen2.png',
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, 
                          vertical: 150.0
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Section
                            const Text(
                              'Professional Information',
                              style: TextStyle(
                                fontFamily: 'NotoSerif',
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Please provide your professional details for verification.',
                              style: TextStyle(
                                fontFamily: 'NotoSans',
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 30),

                            // Specialization Dropdown
                            const Text(
                              'Medical Specialization*',
                              style: TextStyle(
                                color: Color(0xFF002180),
                                fontFamily: "NotoSans",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Obx(() => DropdownButtonFormField<String>(
                              value: controller.selectedSpecialization.value.isEmpty 
                                  ? null 
                                  : controller.selectedSpecialization.value,
                              hint: const Text('Select your specialization'),
                              items: controller.medicalSpecializations
                                  .map((specialization) => DropdownMenuItem(
                                        value: specialization,
                                        child: Text(specialization),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.setSpecialization(value);
                                }
                              },
                              decoration: _getInputDecoration(''),
                            )),
                            const SizedBox(height: 20),

                            // Years of Experience
                            _buildTextField(
                              label: 'Years of Experience*',
                              hint: 'e.g., 5',
                              controller: controller.experienceController,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 20),

                            // Medical School
                            _buildTextField(
                              label: 'Medical School*',
                              hint: 'e.g., University of Lagos College of Medicine',
                              controller: controller.medicalSchoolController,
                            ),
                            const SizedBox(height: 20),

                            // MDCN License Number
                            _buildTextField(
                              label: 'MDCN License Number*',
                              hint: 'e.g., MDCN-12345',
                              controller: controller.licenseController,
                            ),
                            const SizedBox(height: 20),

                            // Fellowship/Postgraduate Training (Optional)
                            _buildTextField(
                              label: 'Fellowship/Postgraduate Training',
                              hint: 'e.g., FWACS, FMCP (Optional)',
                              controller: controller.fellowshipController,
                            ),
                            const SizedBox(height: 20),

                            // Phone Number
                            _buildTextField(
                              label: 'Professional Phone Number',
                              hint: 'e.g., +234 803 123 4567',
                              controller: controller.phoneNumberController,
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 20),

                            // State Selection
                            const Text(
                              'State of Practice*',
                              style: TextStyle(
                                color: Color(0xFF002180),
                                fontFamily: "NotoSans",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Obx(() => DropdownButtonFormField<String>(
                              value: controller.selectedState.value.isEmpty 
                                  ? null 
                                  : controller.selectedState.value,
                              hint: const Text('Select your state'),
                              items: controller.nigerianStates
                                  .map((state) => DropdownMenuItem(
                                        value: state,
                                        child: Text(state),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.setState(value);
                                }
                              },
                              decoration: _getInputDecoration(''),
                            )),
                            const SizedBox(height: 20),

                            // LGA Selection (appears when state is selected)
                            Obx(() {
                              if (controller.selectedState.value.isNotEmpty &&
                                  controller.getLGAsForSelectedState().isNotEmpty) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Local Government Area',
                                      style: TextStyle(
                                        color: Color(0xFF002180),
                                        fontFamily: "NotoSans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    DropdownButtonFormField<String>(
                                      value: controller.selectedLGA.value.isEmpty 
                                          ? null 
                                          : controller.selectedLGA.value,
                                      hint: const Text('Select your LGA'),
                                      items: controller.getLGAsForSelectedState()
                                          .map((lga) => DropdownMenuItem(
                                                value: lga,
                                                child: Text(lga),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          controller.setLGA(value);
                                        }
                                      },
                                      decoration: _getInputDecoration(''),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                );
                              }
                              return const SizedBox.shrink();
                            }),

                            // Clinic Address
                            _buildTextField(
                              label: 'Clinic/Hospital Address',
                              hint: 'Full address of your practice location',
                              controller: controller.clinicAddressController,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 20),

                            // Consultation Fee
                            _buildTextField(
                              label: 'Consultation Fee (₦)',
                              hint: 'e.g., 15000',
                              controller: controller.consultationFeeController,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 20),

                            // Consultation Types
                            const Text(
                              'Available Consultation Types*',
                              style: TextStyle(
                                color: Color(0xFF002180),
                                fontFamily: "NotoSans",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            
                            // Online Consultation Checkbox
                            Obx(() => CheckboxListTile(
                              title: const Text('Online Consultation'),
                              subtitle: const Text('Telemedicine/Video calls'),
                              value: controller.isConsultationOnline.value,
                              onChanged: (value) {
                                controller.toggleOnlineConsultation(value ?? false);
                              },
                              activeColor: const Color(0xFF002180),
                              contentPadding: EdgeInsets.zero,
                            )),

                            // In-Person Consultation Checkbox
                            Obx(() => CheckboxListTile(
                              title: const Text('In-Person Consultation'),
                              subtitle: const Text('Physical clinic visits'),
                              value: controller.isConsultationInPerson.value,
                              onChanged: (value) {
                                controller.toggleInPersonConsultation(value ?? false);
                              },
                              activeColor: const Color(0xFF002180),
                              contentPadding: EdgeInsets.zero,
                            )),
                            const SizedBox(height: 20),

                            // Upload Medical License Section
                            const Text(
                              "Upload Medical License*",
                              style: TextStyle(
                                color: Color(0xFF002180),
                                fontFamily: "NotoSans",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Obx(() => GestureDetector(
                              onTap: controller.pickLicenseFile,
                              child: Container(
                                width: double.infinity,
                                height: 120,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: controller.selectedLicenseFile.value != null
                                      ? Colors.green[50]
                                      : Colors.grey[50],
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: controller.selectedLicenseFile.value != null
                                        ? Colors.green
                                        : Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      controller.selectedLicenseFile.value != null
                                          ? Icons.check_circle
                                          : Icons.cloud_upload_outlined,
                                      size: 40,
                                      color: controller.selectedLicenseFile.value != null
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      controller.selectedLicenseFile.value != null
                                          ? 'License uploaded successfully'
                                          : 'Tap to upload your MDCN license',
                                      style: TextStyle(
                                        color: controller.selectedLicenseFile.value != null
                                            ? Colors.green
                                            : Colors.grey,
                                        fontSize: 14,
                                        fontFamily: "NotoSans",
                                      ),
                                    ),
                                    if (controller.selectedLicenseFile.value != null)
                                      Text(
                                        controller.selectedLicenseFile.value!.path.split('/').last,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontFamily: "NotoSans",
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                  ],
                                ),
                              ),
                            )),
                            const SizedBox(height: 20),

                            // Upload Medical Certificate Section (Optional)
                            const Text(
                              "Upload Medical Certificate (Optional)",
                              style: TextStyle(
                                color: Color(0xFF002180),
                                fontFamily: "NotoSans",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Fellowship certificate, specialty certification, etc.",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: "NotoSans",
                              ),
                            ),
                            const SizedBox(height: 15),
                            Obx(() => GestureDetector(
                              onTap: controller.pickCertificateFile,
                              child: Container(
                                width: double.infinity,
                                height: 120,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: controller.selectedCertificateFile.value != null
                                      ? Colors.green[50]
                                      : Colors.grey[50],
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: controller.selectedCertificateFile.value != null
                                        ? Colors.green
                                        : Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      controller.selectedCertificateFile.value != null
                                          ? Icons.check_circle
                                          : Icons.cloud_upload_outlined,
                                      size: 40,
                                      color: controller.selectedCertificateFile.value != null
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      controller.selectedCertificateFile.value != null
                                          ? 'Certificate uploaded successfully'
                                          : 'Tap to upload additional certificates',
                                      style: TextStyle(
                                        color: controller.selectedCertificateFile.value != null
                                            ? Colors.green
                                            : Colors.grey,
                                        fontSize: 14,
                                        fontFamily: "NotoSans",
                                      ),
                                    ),
                                    if (controller.selectedCertificateFile.value != null)
                                      Text(
                                        controller.selectedCertificateFile.value!.path.split('/').last,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontFamily: "NotoSans",
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                  ],
                                ),
                              ),
                            )),
                            const SizedBox(height: 30),

                            // Terms and Conditions Checkbox
                            Obx(() => Row(
                              children: [
                                Checkbox(
                                  value: controller.agreeToTerms.value,
                                  onChanged: controller.toggleTermsAgreement,
                                  activeColor: const Color(0xFF002180),
                                ),
                                const Flexible(
                                  child: Text(
                                    'I certify that the information provided is accurate, complete, and I consent to its verification by relevant medical authorities.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            const SizedBox(height: 30),

                            // Sign up Button
                            Obx(() => SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: controller.agreeToTerms.value && !controller.isLoading.value
                                    ? controller.submitRegistration
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF002180),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 5,
                                ),
                                child: controller.isLoading.value
                                    ? const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Processing...',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'NotoSans',
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Text(
                                        'Submit Registration',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'NotoSans',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            )),
                            const SizedBox(height: 20),

                            // Login Link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account?',
                                  style: TextStyle(color: Colors.black87),
                                ),
                                TextButton(
                                  onPressed: controller.navigateToSignIn,
                                  child: const Text(
                                    'Login instead',
                                    style: TextStyle(
                                      color: Color(0xE2190B99),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Builds a reusable text field widget with consistent styling
  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF002180),
            fontFamily: "NotoSans",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: _getInputDecoration(hint),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }

  /// Returns consistent input decoration for form fields
  InputDecoration _getInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF002180), width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      filled: true,
      fillColor: Colors.grey[50],
    );
  }
}