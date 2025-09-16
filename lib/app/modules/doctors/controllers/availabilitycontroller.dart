import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AvailabilityController extends GetxController {
  // Observable variables
  var focusedDay = DateTime.now().obs;
  var selectedDays = <DateTime>{}.obs;
  var selectedTime = Rx<TimeOfDay?>(null);
  var currentWeek = DateTime.now().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Set the current week start (Monday)
    currentWeek.value = _getWeekStart(DateTime.now());
    _scheduleNextWeekReminder();
  }

  // Get the start of the week (Monday)
  DateTime _getWeekStart(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  // Get the end of the week (Sunday)
  DateTime _getWeekEnd(DateTime date) {
    return _getWeekStart(date).add(const Duration(days: 6));
  }

  // Check if a day is in the current week
  bool _isInCurrentWeek(DateTime day) {
    final weekStart = _getWeekStart(currentWeek.value);
    final weekEnd = _getWeekEnd(currentWeek.value);
    return day.isAfter(weekStart.subtract(const Duration(days: 1))) && 
           day.isBefore(weekEnd.add(const Duration(days: 1)));
  }

  // Handle day selection (only allow current week)
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!_isInCurrentWeek(selectedDay)) {
      Get.snackbar(
        'Invalid Selection',
        'You can only select days from the current week',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    this.focusedDay.value = focusedDay;
    
    // Create a new set to trigger reactivity
    final updatedDays = Set<DateTime>.from(selectedDays.value);
    
    if (updatedDays.contains(selectedDay)) {
      updatedDays.remove(selectedDay);
    } else {
      updatedDays.add(selectedDay);
    }
    
    selectedDays.value = updatedDays;
    selectedDays.refresh(); // Force update
  }

  // Open time picker
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value ?? TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      selectedTime.value = picked;
    }
  }

  // Format time for display
  String formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  // Save availability for the current week
  Future<void> saveAvailability() async {
    if (selectedDays.isEmpty || selectedTime.value == null) {
      Get.snackbar(
        'Incomplete Selection',
        'Please select at least one day and a time',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade100,
        colorText: Colors.orange.shade800,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    isLoading.value = true;

    try {
      // Simulate saving to backend
      await Future.delayed(const Duration(seconds: 1));
      
      // Here you would typically save to your backend/database
      // Example:
      // await ApiService.saveAvailability({
      //   'days': selectedDays.map((d) => d.toIso8601String()).toList(),
      //   'time': '${selectedTime.value!.hour}:${selectedTime.value!.minute}',
      //   'week': currentWeek.value.toIso8601String(),
      // });

      Get.snackbar(
        'Success',
        'Availability saved for this week',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade800,
        duration: const Duration(seconds: 2),
      );

      // Navigate to next screen - adjust route as needed
      Get.offAllNamed('/doctorshome'); // Replace with your actual route
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save availability. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Schedule reminder for next week
  void _scheduleNextWeekReminder() {
    final nextWeekStart = _getWeekStart(currentWeek.value.add(const Duration(days: 7)));
    final now = DateTime.now();
    
    if (nextWeekStart.isAfter(now)) {
      // Calculate duration until next week starts
      final duration = nextWeekStart.difference(now);
      
      // Schedule the reminder (you would typically use a proper scheduler like flutter_local_notifications)
      Future.delayed(duration, () {
        _showWeeklyAvailabilityReminder();
      });
    }
  }

  // Show weekly availability reminder
  void _showWeeklyAvailabilityReminder() {
    Get.dialog(
      AlertDialog(
        title: const Text('Set Weekly Availability'),
        content: const Text('It\'s time to set your availability for the new week. Would you like to set it now?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              // Schedule for later
              Future.delayed(const Duration(hours: 2), () {
                _showWeeklyAvailabilityReminder();
              });
            },
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _resetForNewWeek();
              Get.toNamed('/availability'); // Navigate to availability page
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF002180),
            ),
            child: const Text('Set Now', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  // Reset selections for new week
  void _resetForNewWeek() {
    currentWeek.value = _getWeekStart(DateTime.now());
    selectedDays.clear();
    selectedTime.value = null;
    focusedDay.value = DateTime.now();
  }

  // Get current week range as string
  String getCurrentWeekRange() {
    final start = _getWeekStart(currentWeek.value);
    final end = _getWeekEnd(currentWeek.value);
    return '${_formatDate(start)} - ${_formatDate(end)}';
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}';
  }

  // Check if form is valid - this getter is used in the UI
  bool get isFormValid => selectedDays.isNotEmpty && selectedTime.value != null;

  // Method to check if a day is selected - used by calendar
  bool isSelected(DateTime day) {
    return selectedDays.contains(day);
  }

  // Method to remove a selected day - used by chip delete
  void removeSelectedDay(DateTime day) {
    final updatedDays = Set<DateTime>.from(selectedDays.value);
    updatedDays.remove(day);
    selectedDays.value = updatedDays;
    selectedDays.refresh();
  }

  // Get list of selected days for display
  List<DateTime> get selectedDaysList => selectedDays.toList()..sort();

  // Format day name for chips
  String getDayName(DateTime day) {
    const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return dayNames[day.weekday - 1];
  }
}