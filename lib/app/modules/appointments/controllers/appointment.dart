// SEPARATE FILE: lib/src/models/appointment.dart
// ==============================================================================
/// Represents an Appointment with its details.
class Appointment {
  final String doctorName;
  final String specialty;
  final String doctorImage;
  final String date;
  final String time;
  final String duration;
  final String appointmentId;

  Appointment({
    required this.doctorName,
    required this.specialty,
    required this.doctorImage,
    required this.date,
    required this.time,
    required this.duration,
    required this.appointmentId,
  });

  // Factory constructor for creating from JSON
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      doctorName: json['doctorName'] ?? '',
      specialty: json['specialty'] ?? '',
      doctorImage: json['doctorImage'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      duration: json['duration'] ?? '',
      appointmentId: json['appointmentId'] ?? '',
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'doctorName': doctorName,
      'specialty': specialty,
      'doctorImage': doctorImage,
      'date': date,
      'time': time,
      'duration': duration,
      'appointmentId': appointmentId,
    };
  }
}
