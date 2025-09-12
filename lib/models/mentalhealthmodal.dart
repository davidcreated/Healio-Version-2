/// Model class for mental health articles
class MentalHealthArticle {
  final String id;
  final String title;
  final String author;
  final String date;
  final String imageUrl;
  final String articleUrl;
  final bool hasVideo;
  final String category;

  MentalHealthArticle({
    required this.id,
    required this.title,
    required this.author,
    required this.date,
    required this.imageUrl,
    required this.articleUrl,
    this.hasVideo = false,
    required this.category,
  });
}