import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/app/modules/chat/controllers/reviewcontroller.dart';

/// Patient Ratings & Reviews page widget
/// Displays doctor reviews with overall rating and individual review cards
class PatientReviewsPage extends StatelessWidget {
  const PatientReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller using GetX dependency injection
    final controller = Get.put(PatientReviewsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Column(
          children: [
            // App bar with back button and title
            _buildAppBar(controller),
            
            // Main content area - scrollable
            Expanded(
              child: RefreshIndicator(
                // Pull-to-refresh functionality
                onRefresh: controller.refreshReviews,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Overall rating summary card
                        _buildRatingSummaryCard(controller),
                        const SizedBox(height: 20),
                        
                        // Individual reviews list
                        Obx(() => _buildReviewsList(controller)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build app bar with back navigation and title
  Widget _buildAppBar(PatientReviewsController controller) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE0E6ED), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Back button with blue background
          InkWell(
            onTap: controller.goBack,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF002180),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Page title
          const Text(
            'Patients Rating & Reviews',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF061234),
            ),
          ),
        ],
      ),
    );
  }

  /// Build overall rating summary card
  Widget _buildRatingSummaryCard(PatientReviewsController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E6ED)),
      ),
      child: Column(
        children: [
          // Overall rating display
          Row(
            children: [
              // Large rating number
              Obx(() => Text(
                controller.formattedRating,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF061234),
                ),
              )),
              const SizedBox(width: 16),
              
              // Stars and rating count
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Star rating display
                    Row(
                      children: [
                        ...List.generate(5, (index) => const Icon(
                          Icons.star,
                          color: Color(0xFFFFA726),
                          size: 16,
                        )),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Total ratings text
                    Obx(() => Text(
                      controller.totalReviews.value,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF686868),
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Rating breakdown bars
          _buildRatingBreakdown(controller),
        ],
      ),
    );
  }

  /// Build rating breakdown with horizontal bars
  Widget _buildRatingBreakdown(PatientReviewsController controller) {
    return Column(
      children: [
        // Generate rating bars for 5 down to 1 star
        ...List.generate(5, (index) {
          final rating = 5 - index; // Start from 5 stars down to 1
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: _buildRatingBar(controller, rating),
          );
        }),
      ],
    );
  }

  /// Build individual rating bar
  Widget _buildRatingBar(PatientReviewsController controller, int rating) {
    return Obx(() {
      final count = controller.getRatingCount(rating);
      final percentage = controller.getRatingPercentage(rating);
      
      return Row(
        children: [
          // Star number
          Text(
            '$rating',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF686868),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          
          // Star icon
          const Icon(
            Icons.star,
            color: Color(0xFFFFA726),
            size: 14,
          ),
          const SizedBox(width: 12),
          
          // Progress bar
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E6ED),
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA726),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Count with parentheses
          Text(
            '($count)',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF686868),
            ),
          ),
        ],
      );
    });
  }

  /// Build reviews list with individual review cards
  Widget _buildReviewsList(PatientReviewsController controller) {
    // Show loading indicator while data loads
    if (controller.isLoading.value) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Show reviews list
    return Column(
      children: controller.reviews.map((review) => 
        _buildReviewCard(controller, review)
      ).toList(),
    );
  }

  /// Build individual review card
  Widget _buildReviewCard(PatientReviewsController controller, Review review) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E6ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Review header with stars and date
          Row(
            children: [
              // Star rating for individual review
              Row(
                children: controller.generateStarRating(review.rating),
              ),
              const Spacer(),
              
              // Review date
              Text(
                review.date,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF686868),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Review title/summary (extracted from review text)
          Text(
            _getReviewTitle(review),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF061234),
            ),
          ),
          const SizedBox(height: 8),
          
          // Review content text
          Text(
            review.reviewText,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF686868),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          
          // Bottom row with emotion and reviewer name
          Row(
            children: [
              // Emotion indicator
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: controller.getEmotionColor(review.emotion).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      controller.getEmotionIcon(review.emotion),
                      size: 16,
                      color: controller.getEmotionColor(review.emotion),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      review.emotion,
                      style: TextStyle(
                        fontSize: 12,
                        color: controller.getEmotionColor(review.emotion),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              
              // Reviewer name with "by" prefix
              Row(
                children: [
                  const Text(
                    'by ',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF686868),
                    ),
                  ),
                  Text(
                    review.reviewerName,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF061234),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Extract review title from review text or generate based on content
  /// This is a helper method to create meaningful titles from review content
  String _getReviewTitle(Review review) {
    // Simple title generation based on common patterns
    if (review.reviewText.toLowerCase().contains('professional')) {
      if (review.reviewText.toLowerCase().contains('caring')) {
        return 'Very professional';
      }
      return 'She\'s very professional';
    } else if (review.reviewText.toLowerCase().contains('compassionate')) {
      return 'She\'s so Compassionate.';
    } else if (review.reviewText.toLowerCase().contains('time')) {
      if (review.reviewText.toLowerCase().contains('responds')) {
        return 'She responds on time';
      }
      return 'She doesn\'t waste time';
    } else if (review.reviewText.toLowerCase().contains('communicat')) {
      return 'She\'s a good communicator';
    }
    
    // Default title
    return 'Very professional';
  }
}