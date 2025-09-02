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

  // A method to check if the doctor matches a search query
  bool containsQuery(String query) {
    return name.toLowerCase().contains(query.toLowerCase()) ||
           specialty.toLowerCase().contains(query.toLowerCase());
  }
}