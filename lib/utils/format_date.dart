import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final thisYear = DateTime(now.year);

  if (dateTime.isAfter(now.subtract(const Duration(days: 1)))) {
    return DateFormat('HH:mm').format(dateTime);
  } else if (dateTime.isAfter(yesterday)) {
    return 'Yesterday';
  } else if (dateTime.isAfter(thisYear)) {
    return DateFormat('MM-dd').format(dateTime);
  } else {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}
