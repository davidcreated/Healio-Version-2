import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:healio_version_2/models/appointmentmodel.dart';
import 'package:healio_version_2/models/patientrequetmodel.dart';

class DoctorsHomeController extends GetxController {
  // Observable variables
  final searchController = TextEditingController();
  var selectedIndex = 0.obs;
  var searchQuery = ''.obs;
  var todaysAppointments = <AppointmentModel>[].obs;
  var upcomingAppointments = <AppointmentModel>[].obs;
  var newPatients = <PatientRequestModel>[].obs;
  var isLoading = false.obs;
  var doctorName = 'Dr Philip'.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
    
    // Listen to search input
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      onSearchChanged(searchController.text);
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // Initialize with selected index from constructor
  void initializeSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  // Search functionality
  void onSearchChanged(String query) {
    // Implement search logic here
    // You can filter appointments, patients, etc.
    print('Searching for: $query');
    // TODO: Implement actual search functionality
  }

  // Clear search
  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }

  // Load dashboard data
  Future<void> loadDashboardData() async {
    isLoading.value = true;
    
    try {
      // Simulate API calls - replace with actual API calls
      await Future.delayed(const Duration(seconds: 1));
      
      // Load today's appointments
      todaysAppointments.value = [
        AppointmentModel(
          id: '1',
          patientName: 'Jonathan Bassey',
          patientImage: 'lib/assets/images/doctors/jonathan.png',
          time: '09:00 AM',
          status: AppointmentStatus.scheduled,
        ),
        AppointmentModel(
          id: '2',
          patientName: 'Roseline Ekong',
          patientImage: 'lib/assets/images/doctors/kong.png',
          time: '10:30 AM',
          status: AppointmentStatus.scheduled,
        ),
      ];

      // Load upcoming appointments
      upcomingAppointments.value = [
        AppointmentModel(
          id: '3',
          patientName: 'Sarah Johnson',
          patientImage: 'lib/assets/images/doctors/johnson.png',
          time: 'Wed, 4:00 PM',
          duration: '1 hr',
          status: AppointmentStatus.upcoming,
        ),
        AppointmentModel(
          id: '4',
          patientName: 'Ubong Fidelis',
          patientImage: 'lib/assets/images/doctors/ubong.png',
          time: 'Fri, 09:00 AM',
          duration: '2 hrs',
          status: AppointmentStatus.upcoming,
        ),
      ];

      // Load new patient requests
      newPatients.value = [
        PatientRequestModel(
          id: '1',
          patientName: 'Rita Cornelius',
          patientImage: 'lib/assets/images/doctors/rita.png',
          complaint: 'sharp pain in lowerback that radiates',
          requestedTime: '15, Jun, 10:00am',
          status: PatientRequestStatus.pending,
        ),
        PatientRequestModel(
          id: '2',
          patientName: 'Rita Cornelius',
          patientImage: 'lib/assets/images/doctors/rita.png',
          complaint: 'sharp pain in lowerback that radiates',
          requestedTime: '15, Jun, 10:00am',
          status: PatientRequestStatus.pending,
        ),
      ];
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load dashboard data',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh dashboard data
  Future<void> refreshDashboard() async {
    await loadDashboardData();
  }

  // Navigate to patient info
  void navigateToPatientInfo() {
    Get.toNamed('/patient-info');
  }

  // Navigate to prescription
  void navigateToPrescription() {
    Get.toNamed('/prescription');
  }

  // Navigate to view all appointments
  void viewAllAppointments() {
    Get.toNamed('/appointments');
  }

  // Handle bottom navigation
  void onBottomNavTap(int index) {
    selectedIndex.value = index;
    
    switch (index) {
      case 0:
        Get.offAllNamed('/doctorshome');
        break;
      case 1:
        Get.offAllNamed('/appointments');
        break;
      case 2:
        Get.offAllNamed('/patients');
        break;
      case 3:
        Get.offAllNamed('/profile');
        break;
    }
  }

  // Handle appointment actions
  void makeCall(String patientId, String patientName) {
    Get.snackbar(
      'Calling',
      'Calling $patientName...',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
    // TODO: Implement actual call functionality
  }

  void openChat(String patientId, String patientName) {
    Get.snackbar(
      'Opening Chat',
      'Opening chat with $patientName...',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
    // TODO: Navigate to chat screen
    // Get.toNamed('/chat', arguments: {'patientId': patientId, 'patientName': patientName});
  }

  // Handle patient request actions
  void acceptPatientRequest(String requestId) {
    final request = newPatients.firstWhere((p) => p.id == requestId);
    request.status = PatientRequestStatus.accepted;
    newPatients.refresh();
    
    Get.snackbar(
      'Request Accepted',
      'Patient request has been accepted',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade800,
    );
    
    // TODO: Send acceptance to backend
  }

  void declinePatientRequest(String requestId) {
    final request = newPatients.firstWhere((p) => p.id == requestId);
    request.status = PatientRequestStatus.declined;
    newPatients.refresh();
    
    Get.snackbar(
      'Request Declined',
      'Patient request has been declined',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange.shade100,
      colorText: Colors.orange.shade800,
    );
    
    // TODO: Send decline to backend
  }

  void reschedulePatientRequest(String requestId) {
    Get.snackbar(
      'Reschedule',
      'Opening reschedule options...',
      snackPosition: SnackPosition.BOTTOM,
    );
    
    // TODO: Navigate to reschedule screen or show reschedule dialog
    // Get.toNamed('/reschedule', arguments: {'requestId': requestId});
  }

  // Get greeting based on time of day
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  // Get full greeting text
  String getFullGreeting() {
    return '${getGreeting()}, ${doctorName.value}';
  }

  // Check if there are pending patient requests
  bool get hasPendingRequests {
    return newPatients.any((p) => p.status == PatientRequestStatus.pending);
  }

  // Get count of pending requests
  int get pendingRequestsCount {
    return newPatients.where((p) => p.status == PatientRequestStatus.pending).length;
  }

  // Get today's appointment count
  int get todayAppointmentCount => todaysAppointments.length;

  // Get upcoming appointment count
  int get upcomingAppointmentCount => upcomingAppointments.length;
}
