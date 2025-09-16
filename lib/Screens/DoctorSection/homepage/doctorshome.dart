import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/doctors/controllers/doctorshomecontroller.dart';
import 'package:healio_version_2/models/appointmentmodel.dart';
import 'package:healio_version_2/models/patientrequetmodel.dart';
import 'package:healio_version_2/shared/widgets/doctorsappointmentcrdwidge.dart';

import 'package:healio_version_2/shared/widgets/patientreuestcardwidget.dart';

class DoctorsHome extends StatelessWidget {
  final int selectedIndex;
  final String username;
  
  const DoctorsHome({
    super.key, 
    this.selectedIndex = 0,
    this.username = '',
  });

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final DoctorsHomeController controller = Get.put(DoctorsHomeController());
    
    // Set initial selected index
    controller.initializeSelectedIndex(selectedIndex);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF094067)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('lib/assets/vectors/circleavatar.png'),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF002180),
            ),
          );
        }
        
        return RefreshIndicator(
          onRefresh: controller.refreshDashboard,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // Greeting
                Obx(() => Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      controller.getFullGreeting(),
                      style: const TextStyle(
                        fontFamily: 'NotoSans',
                        color: Color(0xFF094067),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )),

                // Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: TextFormField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      hintText: 'Search patients, appointments...',
                      filled: true,
                      fillColor: const Color(0xFFE8FEFA),
                      suffixIcon: Obx(() => controller.searchQuery.value.isEmpty
                          ? const Icon(Icons.search)
                          : IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: controller.clearSearch,
                            )),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0, 
                        horizontal: 16
                      ),
                    ),
                  ),
                ),

                // Today's Appointments Header
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Today's Appointments",
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        color: Color(0xFF094067),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                // Today's Appointments Horizontal List
                Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: SizedBox(
                    height: 170,
                    child: controller.todaysAppointments.isEmpty
                        ? const Center(
                            child: Text(
                              'No appointments for today',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.todaysAppointments.length,
                            itemBuilder: (context, index) {
                              final appointment = controller.todaysAppointments[index];
                              return AppointmentCard(
                                appointment: appointment,
                                onCall: () => controller.makeCall(
                                  appointment.id, 
                                  appointment.patientName
                                ),
                                onChat: () => controller.openChat(
                                  appointment.id, 
                                  appointment.patientName
                                ),
                                onTap: () => controller.navigateToPatientInfo(),
                              );
                            },
                          ),
                  ),
                )),

                // Upcoming Appointments
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Upcoming Appointments',
                        style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFF002180),
                        ),
                      ),
                      TextButton(
                        onPressed: controller.viewAllAppointments,
                        child: const Text(
                          'View all',
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            color: Color(0xFF094067),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Upcoming Appointment Cards
                Obx(() => Column(
                  children: controller.upcomingAppointments.map((appointment) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20, 
                        vertical: 10
                      ),
                      child: _UpcomingAppointmentCard(appointment: appointment),
                    );
                  }).toList(),
                )),

                // New Patients Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: Row(
                    children: [
                      const Text(
                        'New Patients',
                        style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFF002180),
                        ),
                      ),
                      Obx(() => controller.hasPendingRequests
                          ? Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8, 
                                vertical: 2
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${controller.pendingRequestsCount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : const SizedBox.shrink()),
                    ],
                  ),
                ),

                // New Patient Request Cards
                Obx(() => Column(
                  children: controller.newPatients.map((request) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20, 
                        vertical: 10
                      ),
                      child: PatientRequestCard(
                        request: request,
                        onAccept: () => controller.acceptPatientRequest(request.id),
                        onDecline: () => controller.declinePatientRequest(request.id),
                        onReschedule: () => controller.reschedulePatientRequest(request.id),
                      ),
                    );
                  }).toList(),
                )),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: controller.onBottomNavTap,
        selectedItemColor: const Color(0xFFA62BB9),
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/icons/home.png')),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/icons/iconappointment.png')),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/icons/iconpatient.png')),
            label: 'Patients',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/icons/iconprofile.png')),
            label: 'Profile',
          ),
        ],
      )),
    );
  }
}


// Upcoming Appointment Card
class _UpcomingAppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;

  const _UpcomingAppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 171,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.grey[300]!, width: 0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(appointment.patientImage),
                ),
                const SizedBox(width: 16),
                Text(
                  appointment.patientName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    fontFamily: 'NotoSans',
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 100.0),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.green, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        appointment.time,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.orange, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      appointment.duration ?? '1 hr',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'NotoSans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




