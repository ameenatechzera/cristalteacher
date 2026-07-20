import 'package:cristalteacher/services/shared_preference_helper.dart';
import 'package:dio/dio.dart';

class ApiHelper {
  static Future<Options> getAuthOptions({bool withToken = false}) async {
    final pref = SharedPreferenceHelper();

    final dbName = await pref.getDatabaseName();
    print('dbName $dbName');
    if (dbName == null || dbName.isEmpty) {
      throw Exception("Database name not set");
    }

    final headers = {"Accept": "application/json", "X-Database-Name": dbName};

    /// 🔥 Add token only if required
    if (withToken) {
      final token = await pref.getToken();
      print("token: $token");
      if (token != null && token.isNotEmpty) {
        headers["Authorization"] = "Bearer $token";
      }
    }

    return Options(contentType: "application/json", headers: headers);
  }
}
