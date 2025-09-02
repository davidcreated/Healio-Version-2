// SEPARATE FILE: lib/src/models/doctor.dart
// ==============================================================================
/// Represents a Doctor with their details.
class Doctor {
  final String name;
  final String specialty;
  final String imageUrl;
  final double rating;
  final int reviews;

  Doctor({
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
  });

  /// Checks if the doctor's name or specialty contains the given query.
  bool containsQuery(String query) {
    return name.toLowerCase().contains(query.toLowerCase()) ||
        specialty.toLowerCase().contains(query.toLowerCase());
  }

  // Factory constructor for creating from JSON
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'] ?? '',
      specialty: json['specialty'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviews: json['reviews'] ?? 0,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'specialty': specialty,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviews': reviews,
    };
  }
}
