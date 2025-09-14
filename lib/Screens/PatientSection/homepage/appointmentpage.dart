import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/appointments/appointmentbookingcontroller.dart';

/// Main Appointment Booking Page Widget
class AppointmentBookingPage extends StatelessWidget {
  const AppointmentBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller using GetX dependency injection
    final controller = Get.put(AppointmentBookingController());
    
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
              _buildAvailabilitySection(controller),
              const SizedBox(height: 24),
              _buildRatingSection(controller),
              const SizedBox(height: 32),
              _buildActionButtons(controller),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Build app bar with back button and title
  Widget _buildAppBar(AppointmentBookingController controller) {
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
                  size: 20,
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

  /// Build doctor information card
  Widget _buildDoctorCard(AppointmentBookingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F2F8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE0E6ED)),
        ),
        child: Obx(() => Row(
          children: [
            // Doctor avatar with online indicator
            Stack(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: const AssetImage('lib/assets/images/doctors/Doctor img.png'),
                  onBackgroundImageError: (_, __) {},
                  child: const Icon(Icons.person, size: 40, color: Colors.grey),
                ),
                // Online status indicator (green dot)
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Color(0xFF05BB98),
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
                        controller.doctorName.value,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF061234),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.verified,
                        color: Color(0xFF2735FD),
                        size: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  // Specialization and location row
                  Row(
                    children: [
                      const Icon(
                        Icons.medical_services,
                        color: Color(0xFFE91E63),
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        controller.doctorSpecialization.value,
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
                        controller.doctorLocation.value,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF686868),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  
                  // Hospital information
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
                          controller.doctorHospital.value,
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
                  const Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Color(0xFF05BB98),
                        size: 14,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Online',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF05BB98),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  /// Build availability section with predefined available slots
  Widget _buildAvailabilitySection(AppointmentBookingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Available Appointments',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF061234),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Select from doctor\'s available time slots',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF686868),
            ),
          ),
          const SizedBox(height: 16),
          
          // Available appointment slots
          _buildAvailableSlots(controller),
        ],
      ),
    );
  }

  /// Build available appointment slots grouped by date
  Widget _buildAvailableSlots(AppointmentBookingController controller) {
    return Obx(() {
      if (controller.availableAppointments.isEmpty) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E6ED)),
          ),
          child: const Column(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                color: Color(0xFF686868),
                size: 48,
              ),
              SizedBox(height: 12),
              Text(
                'No available appointments',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF686868),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Please check back later',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF686868),
                ),
              ),
            ],
          ),
        );
      }

      return Column(
        children: controller.availableAppointments.entries.map((entry) {
          final date = entry.key;
          final slots = entry.value;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E6ED)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: const Color(0xFF002180),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        controller.formatDate(date),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF061234),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${slots.length} slots available',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF686868),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Time slots for this date
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: slots.map((appointmentSlot) {
                      final isSelected = controller.selectedAppointmentSlot.value?.date == date && 
                                       controller.selectedAppointmentSlot.value?.time == appointmentSlot.time;
                      final isBooked = appointmentSlot.isBooked;
                      
                      return GestureDetector(
                        onTap: isBooked ? null : () => controller.selectAppointmentSlot(appointmentSlot),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isBooked 
                                ? const Color(0xFFF5F6FA)
                                : isSelected 
                                    ? const Color(0xFF002180)
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isBooked
                                  ? const Color(0xFFE0E6ED)
                                  : isSelected 
                                      ? const Color(0xFF002180)
                                      : const Color(0xFFE0E6ED),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isBooked ? Icons.lock_outline : Icons.access_time,
                                size: 14,
                                color: isBooked
                                    ? const Color(0xFF686868)
                                    : isSelected
                                        ? Colors.white
                                        :const Color(0xFF002180),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                appointmentSlot.time,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isBooked
                                      ? const Color(0xFF686868)
                                      : isSelected
                                          ? Colors.white
                                          : const Color(0xFF061234),
                                ),
                              ),
                              if (isBooked) ...[
                                const SizedBox(width: 6),
                                const Text(
                                  '(Booked)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF686868),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    });
  }

  /// Build rating section (read-only display)
  Widget _buildRatingSection(AppointmentBookingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                const Text(
                  'Patients Rating & Reviews',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF061234),
                  ),
                ),
                const SizedBox(height: 8),
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
                    Obx(() => Text(
                      controller.doctorRating.value,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF061234),
                      ),
                    )),
                  ],
                ),
                const SizedBox(height: 4),
                Obx(() => Text(
                  controller.doctorReviews.value,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF686868),
                  ),
                )),
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
    );
  }

  /// Build action buttons (Book Appointment & Consult Now)
  Widget _buildActionButtons(AppointmentBookingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // Book Appointment button
          Obx(() => SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: controller.selectedAppointmentSlot.value != null 
                  ? controller.bookAppointment 
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF002180),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(0xFFE0E6ED),
                disabledForegroundColor: const Color(0xFF686868),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: Text(
                controller.selectedAppointmentSlot.value != null
                    ? 'Book Appointment'
                    : 'Select a time slot first',
              ),
            ),
          )),
          const SizedBox(height: 12),
          
          // Consult Now button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
              onPressed: controller.startConsultation,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF686868),
                side: const BorderSide(color: Color(0xFFE0E6ED)),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: Obx(() => Text('Consult now ${controller.consultationFee.value}')),
            ),
          ),
        ],
      ),
    );
  }
}