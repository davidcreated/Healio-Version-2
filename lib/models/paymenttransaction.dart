/// Model class for payment transaction
/// 
/// 
/// 
/// Enum for payment methods
enum PaymentMethod {
  card,
  transfer,
  wallet,
}

class PaymentTransaction {
  final String doctorName; 
  final String appointmentDate;
  final String appointmentTime;
  final int durationHours;
  final double totalAmount;
  final PaymentMethod paymentMethod;
  final DateTime createdAt;

  PaymentTransaction({
    required this.doctorName,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.durationHours,
    required this.totalAmount,
    required this.paymentMethod,
    required this.createdAt,
  });
}