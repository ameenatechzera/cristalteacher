import 'package:intl/intl.dart';

class DateUtilsHelper {
  DateUtilsHelper._();

  /// Returns current date in yyyy-MM-dd format
  static String getCurrentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  /// Returns current date and time in yyyy-MM-dd HH:mm:ss format
  static String getCurrentDateTime() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

  /// Formats any DateTime to yyyy-MM-dd
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// Formats any DateTime to hh:mm a
  static String formatTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }
}
