import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healio_version_2/app/modules/payments/controllers/appointmentcheckoutcontroller.dart';


class AppointmentCheckoutPage extends StatefulWidget {
  const AppointmentCheckoutPage({super.key});

  @override
  State<AppointmentCheckoutPage> createState() => _AppointmentCheckoutPageState();
}

class _AppointmentCheckoutPageState extends State<AppointmentCheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Appointmentcheckoutcontroller());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildAppBar(controller),
              const SizedBox(height: 24),
              _buildHeaderText(),
              const SizedBox(height: 24),
              _buildAppointmentCard(controller),
              const SizedBox(height: 24),
              _buildCheckoutButton(controller),
              const SizedBox(height: 16),
              _buildPolicyLinks(controller),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(Appointmentcheckoutcontroller controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          InkWell(
            onTap: controller.goBack,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF002180),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Checkout',
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

  Widget _buildHeaderText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'You will be re-directed to payment page. Below are the details of your payment.',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFF686868),
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(Appointmentcheckoutcontroller controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE0E6ED)),
        ),
        child: Column(
          children: [
            const Text(
              'Appointment Scheduling',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF061234),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'with',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF686868),
              ),
            ),
            const SizedBox(height: 20),

            // Doctor information card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // Doctor avatar
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.person, size: 32, color: Colors.grey),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(1),
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

                  // Doctor details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              controller.doctorName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF061234),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.verified,
                              color: Color(0xFF2735FD),
                              size: 16,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.medical_services,
                              color: Color(0xFFE91E63),
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              controller.doctorSpecialization,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF686868),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.location_on,
                              color: Color(0xFF1BF2C9),
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              controller.doctorLocation,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF686868),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.business,
                              color: Color(0xFF2735FD),
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                controller.doctorHospital,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF061234),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Color(0xFF05BB98),
                              size: 12,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Online',
                              style: TextStyle(
                                fontSize: 12,
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
              ),
            ),
            const SizedBox(height: 24),

            // Date and Time (fixed for MVP)
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E6ED)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: Color(0xFF2735FD),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Date',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF686868),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.formattedDate,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF061234),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E6ED)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: Color(0xFF2735FD),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Time',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF686868),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.formattedTime,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF061234),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Pricing section
            Row(
              children: [
                // Price column
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Price',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF686868),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        controller.formatPrice(controller.pricePerHour),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF002180),
                        ),
                      ),
                    ],
                  ),
                ),

                // Hours selector
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Hrs',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF686868),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF002180),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: controller.decreaseDuration,
                              icon: const Icon(Icons.remove, color: Colors.white, size: 16),
                              constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                              padding: EdgeInsets.zero,
                            ),
                            Obx(() => Text(
                              controller.selectedDurationHours.value.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            )),
                            IconButton(
                              onPressed: controller.increaseDuration,
                              icon: const Icon(Icons.add, color: Colors.white, size: 16),
                              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Total column
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF686868),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => Text(
                        controller.formatPrice(controller.totalPrice),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF061234),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutButton(Appointmentcheckoutcontroller controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Obx(() => SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: controller.isProcessingPayment.value 
              ? null 
              : controller.processCheckout,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF002180),
            foregroundColor: Colors.white,
            disabledBackgroundColor: const Color(0xFFE0E6ED),
            disabledForegroundColor: const Color(0xFF686868),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
          ),
          child: controller.isProcessingPayment.value
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      )),
    );
  }

  Widget _buildPolicyLinks(Appointmentcheckoutcontroller controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const Text(
            'By continuing you agree to our',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF686868),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: controller.viewPaymentPolicy,
                child: const Text(
                  'payment policy',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF002180),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const Text(
                ' and ',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF686868),
                ),
              ),
              GestureDetector(
                onTap: controller.viewTermsOfService,
                child: const Text(
                  'terms of services',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF2735FD),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const Text(
                '.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF686868),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}