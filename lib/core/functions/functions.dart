import 'package:shared_preferences/shared_preferences.dart';

class DailyTaskRunner {
  static const String _lastRunKey = 'last_run_date';

  /// Runs [task] only if it hasn't been run yet today.
  static Future<void> runOncePerDay(Future<void> Function() task) async {
    final prefs = await SharedPreferences.getInstance();
    final today = _todayString();
    final lastRun = prefs.getString(_lastRunKey);

    if (lastRun != today) {
      await task();
      await prefs.setString(_lastRunKey, today);
    }
  }

  static String _todayString() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }
}