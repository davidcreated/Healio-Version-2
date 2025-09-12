/// Model class for appointment checkout details
class AppointmentCheckout {
  final String doctorName;
  final String doctorSpecialization;
  final String doctorLocation;
  final String doctorHospital;
  final String doctorImage;
  final DateTime appointmentDate;
  final String appointmentTime;
  final double pricePerHour;
  final int durationHours;
  final bool isOnline;

  AppointmentCheckout({
    required this.doctorName,
    required this.doctorSpecialization,
    required this.doctorLocation,
    required this.doctorHospital,
    required this.doctorImage,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.pricePerHour,
    required this.durationHours,
    this.isOnline = true,
  });

  double get totalPrice => pricePerHour * durationHours;
}