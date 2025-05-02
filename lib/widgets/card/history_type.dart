class HistoryType {
  final int tokenDecrease;
  final String imageUrl;
  final bool isRecommended;
  final double aspectRatio;

  HistoryType({
    required this.tokenDecrease,
    required this.imageUrl,
    this.isRecommended = false,
    this.aspectRatio = 1.0,
  });
}