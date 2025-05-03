String displayDate(DateTime date) {
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String day = date.day.toString().padLeft(2, '0');
  String month = months[date.month - 1];
  String year = date.year.toString();

  return '$day $month $year';
}