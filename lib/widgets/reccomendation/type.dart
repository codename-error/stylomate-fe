class RecommendationCard {
  final String title;
  final String imageUrl;
  final bool isRecommended;
  final double aspectRatio;

  RecommendationCard({
    required this.title,
    required this.imageUrl,
    this.isRecommended = false,
    this.aspectRatio = 1.0,
  });
}