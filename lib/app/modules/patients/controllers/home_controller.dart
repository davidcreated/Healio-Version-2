// SEPARATE FILE: lib/src/controllers/home_controller.dart
// ==============================================================================
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:healio_version_2/app/modules/appointments/controllers/appointment.dart';
import 'package:healio_version_2/app/modules/doctors/controllers/doctor.dart';
// Import your models here
// import '../models/doctor.dart';
// import '../models/appointment.dart';

/// Controller for managing HomePage state and business logic
class HomeController extends GetxController {
  // Reactive variables using GetX
  final RxString greeting = ''.obs;
  final RxList<Doctor> allDoctors = <Doctor>[].obs;
  final RxList<Doctor> filteredDoctors = <Doctor>[].obs;
  final Rxn<Appointment> upcomingAppointment = Rxn<Appointment>();
  final RxString searchQuery = ''.obs;
  final RxInt selectedBottomNavIndex = 0.obs;

  // Text controller for search
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _setGreeting();
    _initializeData();
    _setupSearchListener();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// Sets up search listener with debouncing for better performance
  void _setupSearchListener() {
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
    
    // Use GetX debouncing for search functionality
    debounce(searchQuery, _performSearch, time: const Duration(milliseconds: 300));
  }

  /// Sets the greeting based on the current time of day.
  void _setGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      greeting.value = 'Good morning,';
    } else if (hour < 17) {
      greeting.value = 'Good afternoon,';
    } else {
      greeting.value = 'Good evening,';
    }
  }

  /// Initializes mock data - In production, this would fetch from API
  void _initializeData() {
    // Initialize doctors list with mock data
    allDoctors.value = [
      Doctor(
        name: 'Dr Sarah Wilson',
        specialty: 'Cardiologist',
        imageUrl: 'lib/assets/images/doctors/wilson.png',
        rating: 4.9,
        reviews: 20,
      ),
      Doctor(
        name: 'Dr Joseph Bassey',
        specialty: 'Endocrinologist',
        imageUrl: 'lib/assets/images/doctors/bassey.png',
        rating: 4.8,
        reviews: 10,
      ),
      Doctor(
        name: 'Dr Alice Wonderland',
        specialty: 'Pediatrician',
        imageUrl: 'lib/assets/images/doctors/doctor.png',
        rating: 4.7,
        reviews: 15,
      ),
      Doctor(
        name: 'Dr Bob The Builder',
        specialty: 'Orthopedic',
        imageUrl: 'lib/assets/images/doctors/doctor.png',
        rating: 4.5,
        reviews: 8,
      ),
    ];

    // Initially show all doctors
    filteredDoctors.value = List.from(allDoctors);

    // Set upcoming appointment
    _setUpcomingAppointment();
  }

  /// Sets the upcoming appointment data
  void _setUpcomingAppointment() {
    upcomingAppointment.value = Appointment(
      doctorName: 'Dr Sarah Wilson',
      specialty: 'Cardiologist',
      doctorImage: 'lib/assets/images/doctors/wilson.png',
      date: 'Wed, 4:00 PM',
      time: '4:00 PM',
      duration: '1hr',
      appointmentId: 'APT001',
    );
  }

  /// Performs search filtering on doctors list
  void _performSearch(String query) {
    if (query.isEmpty) {
      filteredDoctors.value = List.from(allDoctors);
    } else {
      filteredDoctors.value = allDoctors
          .where((doctor) => doctor.containsQuery(query))
          .toList();
    }
  }

  /// Clears the search query and resets filtered doctors
  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    filteredDoctors.value = List.from(allDoctors);
  }

  /// Updates the upcoming appointment with new data
  void updateUpcomingAppointment(Appointment newAppointment) {
    upcomingAppointment.value = newAppointment;
  }

  /// Clears the upcoming appointment
  void clearUpcomingAppointment() {
    upcomingAppointment.value = null;
  }

  /// Handles bottom navigation selection
  void onBottomNavTap(int index) {
    selectedBottomNavIndex.value = index;
  }

  /// Method to refresh doctors data - useful for pull-to-refresh
  Future<void> refreshDoctors() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    // In production, this would fetch fresh data from API
    _initializeData();
  }

  /// Method to load more doctors - useful for pagination
  Future<void> loadMoreDoctors() async {
    // Simulate loading more doctors from API
    await Future.delayed(const Duration(seconds: 1));
    // Add more doctors to the list
    // This is where you'd implement pagination logic
  }
}
