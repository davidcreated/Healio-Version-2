
// Data models
class AppointmentModel {
  final String id;
  final String patientName;
  final String patientImage;
  final String time;
  final String? duration;
  final AppointmentStatus status;

  AppointmentModel({
    required this.id,
    required this.patientName,
    required this.patientImage,
    required this.time,
    this.duration,
    required this.status,
  });
}

enum AppointmentStatus { scheduled, upcoming, completed, cancelled }

