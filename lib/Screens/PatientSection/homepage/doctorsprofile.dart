import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/patients/controllers/doctorprofilecontroller.dart';

// TODO: Import your controller file
// import 'package:your_app/controllers/doctor_profile_controller.dart';

// TODO: Import your payment checkout page
// import 'package:your_app/screens/payment/payment_checkout_page.dart';

/// Doctor Profile Page - Matches the provided UI design exactly
/// Uses GetX for state management and clean architecture principles
class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller with dependency injection
    return GetBuilder<DoctorProfileController>(
      init: DoctorProfileController(), // TODO: Replace with Get.find() if using dependency injection
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F6FA),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(controller),
                  const SizedBox(height: 20),
                  _buildDoctorCard(controller),
                  const SizedBox(height: 32),
                  _buildAboutSection(controller),
                  const SizedBox(height: 24),
                  _buildStatsSection(controller),
                  const SizedBox(height: 32),
                  _buildAvailabilitySection(controller),
                  const SizedBox(height: 20),
                  _buildRatingsSection(controller),
                  const SizedBox(height: 32),
                  _buildConsultButton(controller),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// App bar with back button and "Details" title
  Widget _buildAppBar(DoctorProfileController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Row(
        children: [
          // Custom back button with rounded corners and blue background
          InkWell(
            onTap: controller.goBack,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF002180),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF061234),
            ),
          ),
        ],
      ),
    );
  }

  /// Doctor information card with image, name, specialization, and status
  Widget _buildDoctorCard(DoctorProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F2F8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE0E6ED)),
        ),
        child: Row(
          children: [
            // Doctor image with online indicator
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 72,
                    height: 72,
                    color: Colors.grey[300], // Placeholder background
                    child: controller.doctorImage.isNotEmpty
                        ? Image.asset(
                            controller.doctorImage,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.person, size: 40, color: Colors.grey);
                            },
                          )
                        : const Icon(Icons.person, size: 40, color: Colors.grey),
                  ),
                ),
                // Online status indicator
                if (controller.isOnline)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: controller.getStatusColor(),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            
            // Doctor information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name with verification badge
                  Row(
                    children: [
                      Text(
                        controller.doctorName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF061234),
                        ),
                      ),
                      if (controller.isVerified) ...[
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.verified,
                          color: Color(0xFF2735FD),
                          size: 18,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  // Specialization with icon
                  Row(
                    children: [
                      const Icon(
                        Icons.medical_services,
                        color: Color(0xFFE91E63),
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        controller.specialization,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF686868),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.location_on,
                        color: Color(0xFF1BF2C9),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        controller.location,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF686868),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  
                  // Hospital with icon
                  Row(
                    children: [
                      const Icon(
                        Icons.business,
                        color: Color(0xFF2735FD),
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          controller.hospital,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF061234),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  
                  // Online status
                  Row(
                    children: [
                      Icon(
                        controller.getStatusIcon(),
                        color: controller.getStatusColor(),
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        controller.status,
                        style: TextStyle(
                          fontSize: 13,
                          color: controller.getStatusColor(),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// About section with doctor's description
  Widget _buildAboutSection(DoctorProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF061234),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            controller.aboutText,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF555555),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  /// Statistics section with patients, experience, and reviews
  Widget _buildStatsSection(DoctorProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatCard(
            icon: Icons.groups,
            iconColor: const Color(0xFF7B61FF),
            value: controller.patientCount,
            label: 'Patients',
          ),
          _buildStatCard(
            icon: Icons.schedule,
            iconColor: const Color(0xFF05BB98),
            value: controller.experience,
            label: 'Experience',
          ),
          _buildStatCard(
            icon: Icons.star,
            iconColor: const Color(0xFFFFC107),
            value: controller.reviewCount,
            label: 'Reviews',
          ),
        ],
      ),
    );
  }

  /// Individual stat card widget
  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E6ED)),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF061234),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF686868),
            ),
          ),
        ],
      ),
    );
  }

  /// Availability section with navigation to booking
  Widget _buildAvailabilitySection(DoctorProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Availability',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF061234),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: controller.navigateToAvailability,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0E6ED)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select time and date to book\nappointment with Dr. Sarah',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF555555),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF686868),
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Ratings and reviews section
  Widget _buildRatingsSection(DoctorProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Patients Rating & Reviews',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF061234),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: controller.navigateToReviews,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0E6ED)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Star rating display
                          Row(
                            children: List.generate(5, (index) {
                              return const Icon(
                                Icons.star,
                                color: Color(0xFFFFC107),
                                size: 16,
                              );
                            }),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            controller.rating,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF061234),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.totalRatings,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF686868),
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF686868),
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Consultation booking button
  Widget _buildConsultButton(DoctorProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: Obx(() => ElevatedButton(
          onPressed: controller.isBookingInProgress 
              ? null 
              : controller.bookConsultation,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF002180),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: controller.isBookingInProgress
              ? const Row(
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
                    Text('Processing...'),
                  ],
                )
              : Text(controller.getFormattedConsultationFee()),
        )),
      ),
    );
  }
}