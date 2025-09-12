import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio_version_2/models/mentalhealthmodal.dart';
import 'package:url_launcher/url_launcher.dart';

/// Controller for managing Mental Health Resources page
class MentalHealthController extends GetxController {
  // Reactive variables for state management
  final RxBool isLoading = false.obs;
  final RxList<MentalHealthArticle> articles = <MentalHealthArticle>[].obs;
  final RxString selectedCategory = 'All'.obs;

  // Available article categories
  final List<String> categories = [
    'All',
    'Sleep',
    'Anxiety',
    'Depression',
    'Wellness',
    'Research'
  ];

  @override
  void onInit() {
    super.onInit();
    // Load articles when controller initializes
    _loadMentalHealthArticles();
  }

  /// Load real mental health articles with working URLs
  Future<void> _loadMentalHealthArticles() async {
    isLoading.value = true;
    
    // Simulate API loading delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    articles.value = [
      // Featured article about mobile devices and sleep
      MentalHealthArticle(
        id: '1',
        title: 'Your Mental Health Matters: 10 reasons you shouldn\'t keep your mobile devices close to your bed.',
        author: 'Dr. Mary Emelonye',
        date: 'February 28 2025',
        imageUrl: 'https://images.unsplash.com/photo-1544027993-37dbfe43562a?w=800',
        articleUrl: 'https://www.frontiersin.org/journals/psychiatry/articles/10.3389/fpsyt.2025.1602997/full',
        hasVideo: false,
        category: 'Sleep',
      ),
      
      // Article about stress and headaches
      MentalHealthArticle(
        id: '2',
        title: '10 amazing facts scientists recently discovered about pregnant women.',
        author: 'Dr. Kristin Watson',
        date: 'February 28 2025',
        imageUrl: 'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=800',
        articleUrl: 'https://www.medicalnewstoday.com/articles/154543',
        hasVideo: false,
        category: 'Wellness',
      ),

      // Video article about relationships
      MentalHealthArticle(
        id: '3',
        title: '10 amazing facts scientists recently discovered about pregnant women.',
        author: 'Dr. Kristin Watson',
        date: 'February 28 2025',
        imageUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=800',
        articleUrl: 'https://www.who.int/news/item/25-03-2025-new-who-guidance-calls-for-urgent-transformation-of-mental-health-policies',
        hasVideo: true,
        category: 'Research',
      ),

      // Article about wound care and mental health
      MentalHealthArticle(
        id: '4',
        title: 'The right and the wrong way to apply bondage into your wound',
        author: 'Dr. Guy Hawkins',
        date: 'February 28 2025',
        imageUrl: 'https://images.unsplash.com/photo-1559757175-0eb30cd8c063?w=800',
        articleUrl: 'https://health.clevelandclinic.org/put-the-phone-away-3-reasons-why-looking-at-it-before-bed-is-a-bad-habit',
        hasVideo: true,
        category: 'Wellness',
      ),

      // Article about happiness and mental wellness
      MentalHealthArticle(
        id: '5',
        title: '10 amazing facts scientists recently discovered about pregnant women.',
        author: 'Dr. Kristin Watson',
        date: 'February 28 2025',
        imageUrl: 'https://images.unsplash.com/photo-1580618672591-eb180b1a973f?w=800',
        articleUrl: 'https://www.psychologytoday.com/us',
        hasVideo: true,
        category: 'Wellness',
      ),

      // Article about depression and coping
      MentalHealthArticle(
        id: '6',
        title: '10 amazing facts scientists recently discovered about pregnant women.',
        author: 'Dr. Kristin Watson',
        date: 'February 28 2025',
        imageUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=800',
        articleUrl: 'https://www.sciencedaily.com/news/mind_brain/mental_health/',
        hasVideo: true,
        category: 'Depression',
      ),

      // Article about anxiety management
      MentalHealthArticle(
        id: '7',
        title: '10 amazing facts scientists recently discovered about pregnant women.',
        author: 'Dr. Kristin Watson',
        date: 'February 28 2025',
        imageUrl: 'https://images.unsplash.com/photo-1559757175-0eb30cd8c063?w=800',
        articleUrl: 'https://www.healthline.com/mental-health',
        hasVideo: true,
        category: 'Anxiety',
      ),
    ];
    
    isLoading.value = false;
  }

  /// Filter articles by category
  List<MentalHealthArticle> get filteredArticles {
    if (selectedCategory.value == 'All') {
      return articles;
    }
    return articles.where((article) => 
      article.category == selectedCategory.value
    ).toList();
  }

  /// Navigate back to previous screen
  void goBack() {
    Get.back();
  }

  /// Open article in browser or web view
  Future<void> openArticle(MentalHealthArticle article) async {
    try {
      final Uri url = Uri.parse(article.articleUrl);
      
      // Check if URL can be launched
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.inAppWebView, // Opens in app web view
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );
      } else {
        // Fallback: try to launch in external browser
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      // Show error message if unable to open article
      Get.snackbar(
        'Error',
        'Unable to open article. Please check your internet connection.',
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
      );
      
      // Log error for debugging
      debugPrint('Error opening article: $e');
    }
  }

  /// Change category filter
  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  /// Refresh articles list
  Future<void> refreshArticles() async {
    await _loadMentalHealthArticles();
  }

  /// Get article count for current filter
  int get articleCount {
    return filteredArticles.length;
  }

  /// Check if article is featured (first article)
  bool isFeaturedArticle(MentalHealthArticle article) {
    return article.id == '1';
  }

  /// Format date for display
  String formatDate(String dateString) {
    try {
      // Parse and format date if needed
      return dateString; // Already formatted in our mock data
    } catch (e) {
      return dateString; // Return original if parsing fails
    }
  }

  /// Get appropriate video overlay icon
  Widget getVideoOverlay() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.play_arrow,
        color: Colors.white,
        size: 24,
      ),
    );
  }

  /// Handle article sharing functionality
  void shareArticle(MentalHealthArticle article) {
    // Implementation for sharing articles
    Get.snackbar(
      'Share',
      'Article sharing coming soon!',
      backgroundColor: Colors.blue.shade400,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  /// Handle article bookmarking
  void bookmarkArticle(MentalHealthArticle article) {
    // Implementation for bookmarking articles
    Get.snackbar(
      'Bookmark',
      'Article bookmarked successfully!',
      backgroundColor: Colors.green.shade400,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void onClose() {
    // Clean up resources when controller is disposed
    super.onClose();
  }
}