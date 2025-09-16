class PatientRequestModel {
  final String id;
  final String patientName;
  final String patientImage;
  final String complaint;
  final String requestedTime;
  PatientRequestStatus status;

  PatientRequestModel({
    required this.id,
    required this.patientName,
    required this.patientImage,
    required this.complaint,
    required this.requestedTime,
    required this.status,
  });
}

enum PatientRequestStatus { pending, accepted, declined }