import 'package:intl/intl.dart';

class Util {
  static DateTime stringToDate(String date) {
    return DateTime.parse(date);
  }

  static String formattedDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('hh:mm, dd-MM-yy');
    return formatter.format(dateTime);
  }
}
