import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String getDateUsingDot({required DateTime dateTime}) {
    final String formattedDate = DateFormat('yy.MM.dd').format(dateTime);
    return formattedDate;
  }
}
