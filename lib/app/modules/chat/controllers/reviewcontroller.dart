import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Model class for individual review data
class Review {
  final String reviewerName;
  final String reviewText;
  final String date;
  final double rating;
  final String emotion; // Happy, Sad, etc.

  Review({
    required this.reviewerName,
    required this.reviewText,
    required this.date,
    required this.rating,
    required this.emotion,
  });
}

/// Controller for managing patient reviews page state and data
class PatientReviewsController extends GetxController {
  // Reactive variables for state management
  final RxBool isLoading = false.obs;
  final RxList<Review> reviews = <Review>[].obs;
  final RxDouble overallRating = 4.9.obs;
  final RxString totalReviews = '2.3k ratings'.obs;
  
  // Rating breakdown - reactive map for star distribution
  final RxMap<int, int> ratingBreakdown = <int, int>{
    5: 210,
    4: 200,
    3: 1,
    2: 0,
    1: 0,
  }.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize reviews data on controller creation
    _loadReviews();
  }

  /// Load mock reviews data for MVP demonstration
  void _loadReviews() {
    // Set loading state
    isLoading.value = true;
    
    // Simulate API delay
    Future.delayed(const Duration(milliseconds: 500), () {
      // Mock reviews data
      reviews.value = [
        Review(
          reviewerName: 'Usuak Samson',
          reviewText: 'Dr. Sarah is very professional and very caring, she prescribed perfect medication for my symptoms',
          date: '13-03-2025',
          rating: 5.0,
          emotion: 'Happy',
        ),
        Review(
          reviewerName: 'Cameron Williamson',
          reviewText: 'Dr. Sarah is very professional and very caring, she prescribed perfect medication for my symptoms',
          date: '13-03-2025',
          rating: 5.0,
          emotion: 'Happy',
        ),
        Review(
          reviewerName: 'Albert Flores',
          reviewText: 'Dr. Sarah is very professional and very caring, she prescribed perfect medication for my symptoms',
          date: '13-03-2025',
          rating: 5.0,
          emotion: 'Happy',
        ),
        Review(
          reviewerName: 'Annette Black',
          reviewText: 'Dr. Sarah is very professional and very caring, she prescribed perfect medication for my symptoms',
          date: '13-03-2025',
          rating: 5.0,
          emotion: 'Happy',
        ),
        Review(
          reviewerName: 'Eleanor Pena',
          reviewText: 'Dr. Sarah is very professional and very caring, she prescribed perfect medication for my symptoms',
          date: '13-03-2025',
          rating: 5.0,
          emotion: 'Happy',
        ),
        Review(
          reviewerName: 'Joseph Salami',
          reviewText: 'Dr. Sarah is very professional and very caring, she prescribed perfect medication for my symptoms',
          date: '13-03-2025',
          rating: 5.0,
          emotion: 'Happy',
        ),
      ];
      
      // Clear loading state
      isLoading.value = false;
    });
  }

  /// Navigate back to previous screen
  void goBack() {
    Get.back();
  }

  /// Get total number of reviews for a specific rating
  int getRatingCount(int rating) {
    return ratingBreakdown[rating] ?? 0;
  }

  /// Get total number of all reviews
  int get totalRatingCount {
    return ratingBreakdown.values.fold(0, (sum, count) => sum + count);
  }

  /// Calculate percentage for rating bar
  double getRatingPercentage(int rating) {
    final count = getRatingCount(rating);
    final total = totalRatingCount;
    return total > 0 ? count / total : 0.0;
  }

  /// Get appropriate emotion icon based on emotion string
  IconData getEmotionIcon(String emotion) {
    switch (emotion.toLowerCase()) {
      case 'happy':
        return Icons.sentiment_very_satisfied;
      case 'sad':
        return Icons.sentiment_dissatisfied;
      case 'neutral':
        return Icons.sentiment_neutral;
      default:
        return Icons.sentiment_satisfied;
    }
  }

  /// Get emotion icon color
  Color getEmotionColor(String emotion) {
    switch (emotion.toLowerCase()) {
      case 'happy':
        return const Color(0xFFFFA726);
      case 'sad':
        return Colors.red;
      case 'neutral':
        return Colors.grey;
      default:
        return const Color(0xFFFFA726);
    }
  }

  /// Format rating display (e.g., 4.9/5)
  String get formattedRating {
    return '${overallRating.value}/5';
  }

  /// Generate star rating widget list
  List<Widget> generateStarRating(double rating) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      stars.add(
        Icon(
          i <= rating ? Icons.star : Icons.star_border,
          color: const Color(0xFFFFA726),
          size: 16,
        ),
      );
    }
    return stars;
  }

  /// Refresh reviews data
  Future<void> refreshReviews() async {
    _loadReviews();
  }

  @override
  void onClose() {
    // Clean up resources when controller is disposed
    super.onClose();
  }
}