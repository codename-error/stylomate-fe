class HistoryType {
  final String serviceTitle;
  final int tokenActivity;
  final DateTime date;
  final bool isDecreased;

  HistoryType({
    required this.serviceTitle,
    required this.tokenActivity,
    required this.date,
    this.isDecreased = false,
  });
}