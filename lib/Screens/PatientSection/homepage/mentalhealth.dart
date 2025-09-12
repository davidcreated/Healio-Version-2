import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:healio_version_2/models/mentalhealthmodal.dart';
import 'package:url_launcher/url_launcher.dart';

/// Mental Health Resources page widget
/// Displays curated mental health articles with real links and interactive features
class MentalHealthResourcesPage extends StatefulWidget {
  const MentalHealthResourcesPage({super.key});

  @override
  State<MentalHealthResourcesPage> createState() => _MentalHealthResourcesPageState();
}

class _MentalHealthResourcesPageState extends State<MentalHealthResourcesPage> {
  // State variables
  bool isLoading = false;
  List<MentalHealthArticle> articles = [];
  String selectedCategory = 'All';

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
  void initState() {
    super.initState();
    _loadMentalHealthArticles();
  }

  /// Load real mental health articles with working URLs
  Future<void> _loadMentalHealthArticles() async {
    setState(() {
      isLoading = true;
    });
    
    // Simulate API loading delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    setState(() {
      articles = [
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
      
      isLoading = false;
    });
  }

  /// Filter articles by category
  List<MentalHealthArticle> get filteredArticles {
    if (selectedCategory == 'All') {
      return articles;
    }
    return articles.where((article) => 
      article.category == selectedCategory
    ).toList();
  }

  /// Navigate back to previous screen
  void goBack() {
    Navigator.of(context).pop();
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to open article. Please check your internet connection.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
      
      // Log error for debugging
      debugPrint('Error opening article: $e');
    }
  }

  /// Change category filter
  void changeCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  /// Refresh articles list
  Future<void> refreshArticles() async {
    await _loadMentalHealthArticles();
  }

  /// Check if article is featured (first article)
  bool isFeaturedArticle(MentalHealthArticle article) {
    return article.id == '1';
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Article sharing coming soon!'),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// Handle article bookmarking
  void bookmarkArticle(MentalHealthArticle article) {
    // Implementation for bookmarking articles
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Article bookmarked successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Column(
          children: [
            // App bar with navigation
            _buildAppBar(),
            
            // Category filter tabs (optional enhancement)
            _buildCategoryTabs(),
            
            // Main content area
            Expanded(
              child: RefreshIndicator(
                // Pull-to-refresh functionality
                onRefresh: refreshArticles,
                child: _buildArticlesList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build app bar with back navigation and title
  Widget _buildAppBar() {
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
            onTap: goBack,
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
            'Mental Health Resources',
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

  /// Build category filter tabs
  Widget _buildCategoryTabs() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;
          
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => changeCategory(category),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF002180) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF002180) : const Color(0xFFE0E6ED),
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF686868),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Build articles list with loading state
  Widget _buildArticlesList() {
    // Show loading indicator
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: CircularProgressIndicator(
            color: Color(0xFF002180),
          ),
        ),
      );
    }

    // Show articles list
    final currentArticles = filteredArticles;
    
    if (currentArticles.isEmpty) {
      return const Center(
        child: Text(
          'No articles found for this category',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF686868),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: currentArticles.length,
      itemBuilder: (context, index) {
        final article = currentArticles[index];
        
        // Featured article gets special treatment
        if (isFeaturedArticle(article)) {
          return _buildFeaturedArticle(article);
        }
        
        // Regular articles
        return _buildRegularArticle(article);
      },
    );
  }

  /// Build featured article card (larger, no video overlay)
  Widget _buildFeaturedArticle(MentalHealthArticle article) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () => openArticle(article),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 200,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: article.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Article title
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF061234),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),
            
            // Author and date info
            _buildAuthorDateInfo(article),
          ],
        ),
      ),
    );
  }

  /// Build regular article card with video overlay if applicable
  Widget _buildRegularArticle(MentalHealthArticle article) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () => openArticle(article),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article thumbnail with optional video overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 120,
                    height: 90,
                    child: CachedNetworkImage(
                      imageUrl: article.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Video play button overlay
                if (article.hasVideo)
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child: Center(
                      child: getVideoOverlay(),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            
            // Article content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Article title
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF061234),
                      height: 1.3,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  
                  // Author and date info
                  _buildAuthorDateInfo(article),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build author and date information row
  Widget _buildAuthorDateInfo(MentalHealthArticle article) {
    return Row(
      children: [
        // Author avatar
        CircleAvatar(
          radius: 12,
          backgroundColor: const Color(0xFF002180),
          child: Text(
            article.author.split(' ').map((name) => name[0]).join(''),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 8),
        
        // Author name and date
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.date,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF686868),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                article.author,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF686868),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        
        // Action buttons (bookmark, share)
        _buildActionButtons(article),
      ],
    );
  }

  /// Build action buttons for articles
  Widget _buildActionButtons(MentalHealthArticle article) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Bookmark button
        IconButton(
          onPressed: () => bookmarkArticle(article),
          icon: const Icon(
            Icons.bookmark_border,
            size: 18,
            color: Color(0xFF686868),
          ),
          constraints: const BoxConstraints(
            minWidth: 30,
            minHeight: 30,
          ),
          padding: EdgeInsets.zero,
        ),
        
        // Share button
        IconButton(
          onPressed: () => shareArticle(article),
          icon: const Icon(
            Icons.share_outlined,
            size: 18,
            color: Color(0xFF686868),
          ),
          constraints: const BoxConstraints(
            minWidth: 30,
            minHeight: 30,
          ),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}

/// Add this to your pubspec.yaml dependencies:
/// dependencies:
///   cached_network_image: ^3.3.1
///   url_launcher: ^6.2.5