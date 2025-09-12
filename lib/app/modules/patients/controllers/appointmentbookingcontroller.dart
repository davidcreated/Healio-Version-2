import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Model class for appointment slots
class AppointmentSlot {
  final DateTime date;
  final String time;
  final bool isBooked;
  final String? patientName; // For booked appointments
  
  AppointmentSlot({
    required this.date,
    required this.time,
    this.isBooked = false,
    this.patientName,
  });
  
  AppointmentSlot copyWith({
    DateTime? date,
    String? time,
    bool? isBooked,
    String? patientName,
  }) {
    return AppointmentSlot(
      date: date ?? this.date,
      time: time ?? this.time,
      isBooked: isBooked ?? this.isBooked,
      patientName: patientName ?? this.patientName,
    );
  }
}

/// Controller for managing appointment booking state
class AppointmentBookingController extends GetxController {
  // Available appointments map (Date -> List of AppointmentSlots)
  RxMap<DateTime, List<AppointmentSlot>> availableAppointments = 
      <DateTime, List<AppointmentSlot>>{}.obs;
  
  // Selected appointment slot
  Rx<AppointmentSlot?> selectedAppointmentSlot = Rx<AppointmentSlot?>(null);
  
  // Doctor information (would come from arguments in real app)
  var doctorName = 'Dr. Sarah Udy'.obs;
  var doctorSpecialization = 'Cardiologist'.obs;
  var doctorLocation = 'Uyo Nigeria'.obs;
  var doctorHospital = 'University of Uyo Teaching Hospital'.obs;
  var doctorRating = '4.9/5'.obs;
  var doctorReviews = '(2.3k ratings)'.obs;
  var consultationFee = '₦10,000/hr'.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Get doctor data from arguments if available
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      doctorName.value = arguments['doctorName'] ?? 'Dr. Sarah Udy';
      // Set other doctor details based on the selected doctor
      _setDoctorDetails(arguments['doctorName'] ?? 'Dr. Sarah Udy');
    }
    
    // Initialize doctor's available appointments
    _initializeAvailableAppointments();
  }
  
  /// Initialize doctor's available appointment slots
  void _initializeAvailableAppointments() {
    final now = DateTime.now();
    final appointments = <DateTime, List<AppointmentSlot>>{};
    
    // Generate appointments for the next 14 days
    for (int i = 1; i <= 14; i++) {
      final date = DateTime(now.year, now.month, now.day + i);
      
      // Skip weekends for this example (can be customized per doctor)
      if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
        continue;
      }
      
      final slots = _generateSlotsForDate(date);
      if (slots.isNotEmpty) {
        appointments[date] = slots;
      }
    }
    
    availableAppointments.value = appointments;
  }
  
  /// Generate appointment slots for a specific date based on doctor's schedule
  List<AppointmentSlot> _generateSlotsForDate(DateTime date) {
    final slots = <AppointmentSlot>[];
    
    // Different doctors might have different schedules
    switch (doctorName.value.toLowerCase()) {
      case 'dr. sarah udy':
        // Morning slots
        slots.addAll([
          AppointmentSlot(date: date, time: '8:00 AM'),
          AppointmentSlot(date: date, time: '9:00 AM'),
          AppointmentSlot(date: date, time: '10:00 AM'),
          AppointmentSlot(date: date, time: '11:00 AM'),
        ]);
        
        // Afternoon slots
        slots.addAll([
          AppointmentSlot(date: date, time: '2:00 PM'),
          AppointmentSlot(date: date, time: '3:00 PM'),
          AppointmentSlot(date: date, time: '4:00 PM'),
          AppointmentSlot(date: date, time: '5:00 PM'),
        ]);
        break;
        
      case 'dr. sarah johnson':
        // Different schedule for dermatologist
        slots.addAll([
          AppointmentSlot(date: date, time: '9:00 AM'),
          AppointmentSlot(date: date, time: '10:30 AM'),
          AppointmentSlot(date: date, time: '12:00 PM'),
          AppointmentSlot(date: date, time: '1:30 PM'),
          AppointmentSlot(date: date, time: '3:00 PM'),
          AppointmentSlot(date: date, time: '4:30 PM'),
        ]);
        break;
        
      case 'dr. nuurdeen ahmad':
        // General practitioner with longer hours
        slots.addAll([
          AppointmentSlot(date: date, time: '7:00 AM'),
          AppointmentSlot(date: date, time: '8:30 AM'),
          AppointmentSlot(date: date, time: '10:00 AM'),
          AppointmentSlot(date: date, time: '11:30 AM'),
          AppointmentSlot(date: date, time: '1:00 PM'),
          AppointmentSlot(date: date, time: '2:30 PM'),
          AppointmentSlot(date: date, time: '4:00 PM'),
          AppointmentSlot(date: date, time: '5:30 PM'),
        ]);
        break;
        
      default:
        // Default schedule
        slots.addAll([
          AppointmentSlot(date: date, time: '9:00 AM'),
          AppointmentSlot(date: date, time: '11:00 AM'),
          AppointmentSlot(date: date, time: '2:00 PM'),
          AppointmentSlot(date: date, time: '4:00 PM'),
        ]);
    }
    
    // Simulate some booked appointments (randomly mark some as booked)
    _simulateBookedAppointments(slots, date);
    
    return slots;
  }
  
  /// Simulate some booked appointments for demonstration
  void _simulateBookedAppointments(List<AppointmentSlot> slots, DateTime date) {
    final random = DateTime.now().millisecond;
    
    // Mark some slots as booked based on date and doctor
    for (int i = 0; i < slots.length; i++) {
      // Create a pseudo-random pattern based on date and slot index
      final shouldBeBooked = (date.day + i + random) % 5 == 0;
      
      if (shouldBeBooked) {
        slots[i] = slots[i].copyWith(
          isBooked: true,
          patientName: 'Patient ${i + 1}',
        );
      }
    }
  }
  
  /// Set doctor details based on selected doctor
  void _setDoctorDetails(String doctor) {
    switch (doctor.toLowerCase()) {
      case 'dr. sarah udy':
        doctorSpecialization.value = 'Cardiologist';
        doctorLocation.value = 'Uyo Nigeria';
        doctorHospital.value = 'University of Uyo Teaching Hospital';
        doctorRating.value = '4.9/5';
        doctorReviews.value = '(2.3k ratings)';
        consultationFee.value = '₦15,000/hr';
        break;
      case 'dr. sarah johnson':
        doctorSpecialization.value = 'Dermatologist';
        doctorLocation.value = 'Lagos Nigeria';
        doctorHospital.value = 'Lagos University Teaching Hospital';
        doctorRating.value = '4.7/5';
        doctorReviews.value = '(1.8k ratings)';
        consultationFee.value = '₦12,000/hr';
        break;
      case 'dr. nuurdeen ahmad':
        doctorSpecialization.value = 'General Practitioner';
        doctorLocation.value = 'Abuja Nigeria';
        doctorHospital.value = 'National Hospital Abuja';
        doctorRating.value = '4.8/5';
        doctorReviews.value = '(3.1k ratings)';
        consultationFee.value = '₦8,000/hr';
        break;
    }
  }
  
  /// Navigate back to previous screen
  void goBack() {
    Get.back();
  }
  
  /// Select an appointment slot
  void selectAppointmentSlot(AppointmentSlot slot) {
    if (slot.isBooked) {
      Get.snackbar(
        'Slot Unavailable',
        'This appointment slot is already booked',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }
    
    selectedAppointmentSlot.value = slot;
  }
  
  /// Format date for display
  String formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    
    const weekdays = [
      'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
    ];
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);
    
    if (dateOnly == today) {
      return 'Today, ${months[date.month - 1]} ${date.day}';
    } else if (dateOnly == tomorrow) {
      return 'Tomorrow, ${months[date.month - 1]} ${date.day}';
    } else {
      return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}';
    }
  }
  
  /// Book appointment
  void bookAppointment() {
    if (selectedAppointmentSlot.value == null) {
      Get.snackbar(
        'No Slot Selected',
        'Please select an appointment slot first',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }
    
    final slot = selectedAppointmentSlot.value!;
    
    // Mark the slot as booked
    _markSlotAsBooked(slot);
    
    // Show success message
    Get.snackbar(
      'Appointment Booked!',
      'Appointment with ${doctorName.value} on ${formatDate(slot.date)} at ${slot.time}',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
    );
      Get.toNamed('/checkout', arguments: {
        'doctorName': doctorName.value,
        'doctorSpecialization': doctorSpecialization.value,
        'doctorLocation': doctorLocation.value,
        'doctorHospital': doctorHospital.value,
        'appointmentDate': slot.date,
        'appointmentTime': slot.time,
        'pricePerHour': double.tryParse(consultationFee.value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0.0,
      });
    // Navigate to payment or confirmation page
    // Get.toNamed('/payment', arguments: {'appointmentSlot': slot});
  }
  
  /// Mark a slot as booked and update the list
  void _markSlotAsBooked(AppointmentSlot slot) {
    final dateKey = DateTime(slot.date.year, slot.date.month, slot.date.day);
    final slots = availableAppointments[dateKey];
    
    if (slots != null) {
      final index = slots.indexWhere((s) => 
          s.date.day == slot.date.day && 
          s.time == slot.time);
      
      if (index != -1) {
        slots[index] = slot.copyWith(
          isBooked: true,
          patientName: 'You', // Current user
        );
        availableAppointments.refresh();
        selectedAppointmentSlot.value = null;
      }
    }
  }
  
  /// Start consultation
  void startConsultation() {
    Get.snackbar(
      'Starting Consultation',
      'Connecting with ${doctorName.value}...',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
    
    // Navigate to checkout page
    Get.toNamed('/checkout', arguments: {
      'doctorName': doctorName.value,
      'doctorSpecialization': doctorSpecialization.value,
      'doctorLocation': doctorLocation.value,
      'doctorHospital': doctorHospital.value,
      'appointmentDate': DateTime.now(),
      'appointmentTime': TimeOfDay.now(),
      'pricePerHour': double.tryParse(consultationFee.value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0.0,
    });
  }
  
  /// Refresh available appointments (useful for real-time updates)
  void refreshAppointments() {
    _initializeAvailableAppointments();
  }
  
  /// Get total available slots count
  int get totalAvailableSlots {
    int count = 0;
    for (final slots in availableAppointments.values) {
      count += slots.where((slot) => !slot.isBooked).length;
    }
    return count;
  }
  
  /// Get next available appointment
  AppointmentSlot? get nextAvailableSlot {
    for (final entry in availableAppointments.entries) {
      for (final slot in entry.value) {
        if (!slot.isBooked) {
          return slot;
        }
      }
    }
    return null;
  }
}