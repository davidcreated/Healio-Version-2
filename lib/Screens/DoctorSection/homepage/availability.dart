import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/doctors/controllers/availabilitycontroller.dart';
import 'package:table_calendar/table_calendar.dart';


// Import the controller (make sure to create this file)
// import 'availability_controller.dart';

class Availability extends StatelessWidget {
  const Availability({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final AvailabilityController controller = Get.put(AvailabilityController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Set Weekly Availability",
                    style: TextStyle(
                      fontFamily: "Notosans",
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                ],
              ),
            ),
            
            // Week Range Display
            Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF002180).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF002180).withOpacity(0.3)),
                ),
                child: Text(
                  "Current Week: ${controller.getCurrentWeekRange()}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Notosans",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF002180),
                  ),
                ),
              ),
            )),
            
            const SizedBox(height: 20),
            const Text(
              "Select the days you'll be available\nthis week. You can choose multiple days.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Notosans",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),

            // Date Selection Section
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Select Available Days",
                    style: TextStyle(
                      color: Color(0xFF2D2D2D),
                      fontFamily: "Notosans",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            // Calendar Widget
            Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: TableCalendar<DateTime>(
                firstDay: controller.currentWeek.value,
                lastDay: controller.currentWeek.value.add(const Duration(days: 6)),
                focusedDay: controller.focusedDay.value,
                calendarFormat: CalendarFormat.week,
                selectedDayPredicate: (day) {
                  return controller.isSelected(day);
                },
                onDaySelected: controller.onDaySelected,
                availableGestures: AvailableGestures.none, // Disable swipe gestures
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Color(0xFF002180),
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  todayTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  weekendTextStyle: TextStyle(color: Colors.red),
                  defaultTextStyle: TextStyle(color: Colors.black),
                  outsideTextStyle: TextStyle(color: Colors.grey),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleTextStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: const TextStyle(color: Colors.red),
                  weekdayStyle: TextStyle(color: Colors.grey[800]),
                ),
              ),
            )),

            // Selected Days Display
            Obx(() {
              if (controller.selectedDays.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Selected Days:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 8,
                          children: controller.selectedDaysList.map((day) {
                            final dayName = controller.getDayName(day);
                            return Chip(
                              label: Text(
                                '$dayName ${day.day}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              backgroundColor: const Color(0xFF002180),
                              labelStyle: const TextStyle(color: Colors.white),
                              deleteIcon: const Icon(Icons.close, size: 16, color: Colors.white),
                              onDeleted: () => controller.removeSelectedDay(day),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            // Time Selection Section
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Available Time",
                  style: TextStyle(
                    color: Color(0xFF2D2D2D),
                    fontFamily: "Notosans",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Time Picker Button
            Obx(() => GestureDetector(
              onTap: () => controller.selectTime(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: controller.selectedTime.value != null 
                        ? const Color(0xFF002180) 
                        : Colors.grey.shade400,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: controller.selectedTime.value != null
                      ? const Color(0xFF002180).withOpacity(0.1)
                      : Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.selectedTime.value != null
                          ? controller.formatTime(controller.selectedTime.value!)
                          : "Tap to choose your available time",
                      style: TextStyle(
                        color: controller.selectedTime.value != null 
                            ? const Color(0xFF002180)
                            : Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: "Notosans",
                      ),
                    ),
                    Icon(
                      Icons.access_time,
                      color: controller.selectedTime.value != null 
                          ? const Color(0xFF002180)
                          : Colors.black54,
                    )
                  ],
                ),
              ),
            )),

            const SizedBox(height: 30),

            // Form Validation Message
            Obx(() {
              if (!controller.isFormValid) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.shade300),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Please select at least one day and a time to continue",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            // Save Button
            Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.isFormValid && !controller.isLoading.value
                      ? controller.saveAvailability
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF002180),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    disabledBackgroundColor: Colors.grey.shade300,
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
                            SizedBox(width: 12),
                            Text(
                              'Saving...',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      : const Text(
                          'Save Weekly Availability',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            )),
            
            const SizedBox(height: 20),

            // Info Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "You'll be prompted to set your availability again next week. You can always change this in settings.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  fontFamily: "Notosans",
                ),
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}