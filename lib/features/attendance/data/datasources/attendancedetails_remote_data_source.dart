import 'dart:convert';

import 'package:cristalteacher/core/errors/error_messege_model.dart';
import 'package:cristalteacher/core/errors/exceptions.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/network/api_endpoints.dart';
import 'package:cristalteacher/core/network/api_helper.dart';
import 'package:cristalteacher/features/attendance/data/models/attendance_report_model.dart';
import 'package:cristalteacher/features/attendance/data/models/fetch_attendancedetails_model.dart';
import 'package:cristalteacher/features/attendance/domain/parameters/attendance_report_parameter.dart';
import 'package:cristalteacher/features/attendance/domain/parameters/fetch_attendancedetails_parameter.dart';
import 'package:cristalteacher/features/attendance/domain/parameters/save_attendance_parameter.dart';
import 'package:cristalteacher/services/shared_preference_helper.dart';
import 'package:dio/dio.dart';

abstract class AttendanceRemoteDataSource {
  Future<AttendanceDetailsResponseModel> fetchAttendanceDetails(
    AttendanceDetailsRequest params,
  );
  Future<MasterResponseModel> saveAttendance(SaveAttendanceRequest params);
  Future<AttendanceReportResponseModel> fetchAttendanceReport(
    AttendanceReportParameter params,
  );
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<AttendanceDetailsResponseModel> fetchAttendanceDetails(
    AttendanceDetailsRequest params,
  ) async {
    print('📘 Attendance Details Called');
    print('AttendanceDetailsRequest: ${params.toJson()}');

    try {
      /// Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// API URL
      final url = ApiConstants.getAttendanceDetailsPath(baseUrl);

      print("URL : $url");

      /// Headers
      final options = await ApiHelper.getAuthOptions(withToken: true);

      /// API Call
      final response = await dio.post(
        url,
        data: params.toJson(),
        options: options,
      );

      print('📘 Status Code: ${response.statusCode}');

      final responseString = jsonEncode(response.data);

      const chunkSize = 800;

      for (int i = 0; i < responseString.length; i += chunkSize) {
        print(
          responseString.substring(
            i,
            i + chunkSize > responseString.length
                ? responseString.length
                : i + chunkSize,
          ),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AttendanceDetailsResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in fetchAttendanceDetails: $e');
      print(stacktrace);
      rethrow;
    }
  }

  @override
  Future<MasterResponseModel> saveAttendance(
    SaveAttendanceRequest params,
  ) async {
    print('📘 Save Attendance Called');
    print('SaveAttendanceRequest: ${params.toJson()}');

    try {
      /// Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// API URL
      final url = ApiConstants.getSaveAttendancePath(baseUrl);

      print("URL : $url");

      /// Headers
      final options = await ApiHelper.getAuthOptions(withToken: true);

      /// API Call
      final response = await dio.post(
        url,
        data: params.toJson(),
        options: options,
      );

      print('📘 Status Code: ${response.statusCode}');
      print('📘 Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return MasterResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in saveAttendance: $e');
      print(stacktrace);
      rethrow;
    }
  }

  // @override
  // Future<AttendanceReportResponseModel> fetchAttendanceReport(
  //   AttendanceReportParameter params,
  // ) async {
  //   print('📘 Attendance Report Called');

  //   try {
  //     /// Base URL
  //     final baseUrl = await SharedPreferenceHelper().getBaseUrl();

  //     if (baseUrl == null || baseUrl.isEmpty) {
  //       throw Exception("Base URL not set");
  //     }

  //     /// API URL
  //     final url = ApiConstants.getAttendanceReportPath(baseUrl);

  //     print("URL : $url");

  //     /// Headers
  //     final options = await ApiHelper.getAuthOptions(withToken: true);

  //     /// API Call
  //     final response = await dio.post(url, options: options);

  //     print('📘 Status Code: ${response.statusCode}');

  //     final responseString = jsonEncode(response.data);

  //     const chunkSize = 800;

  //     for (int i = 0; i < responseString.length; i += chunkSize) {
  //       print(
  //         responseString.substring(
  //           i,
  //           i + chunkSize > responseString.length
  //               ? responseString.length
  //               : i + chunkSize,
  //         ),
  //       );
  //     }

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return AttendanceReportResponseModel.fromJson(response.data);
  //     } else {
  //       throw ServerException(
  //         errorMessageModel: ErrorMessageModel.fromJson(response.data),
  //       );
  //     }
  //   } catch (e, stacktrace) {
  //     print('❌ Exception in fetchAttendanceReport: $e');
  //     print(stacktrace);
  //     rethrow;
  //   }
  // }
  @override
  Future<AttendanceReportResponseModel> fetchAttendanceReport(
    AttendanceReportParameter params,
  ) async {
    print('📘 Attendance Report Called');

    try {
      /// Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// API URL
      final url = ApiConstants.getAttendanceReportPath(baseUrl);

      print("📘 URL : $url");

      /// Request
      print("📘 Attendance Request: ${params.toJson()}");

      /// Headers
      final options = await ApiHelper.getAuthOptions(withToken: true);

      /// API Call
      final response = await dio.post(
        url,
        data: params.toJson(), // ⭐ THIS WAS MISSING
        options: options,
      );

      print('📘 Status Code: ${response.statusCode}');

      final responseString = jsonEncode(response.data);

      const chunkSize = 800;

      for (int i = 0; i < responseString.length; i += chunkSize) {
        print(
          responseString.substring(
            i,
            i + chunkSize > responseString.length
                ? responseString.length
                : i + chunkSize,
          ),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AttendanceReportResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in fetchAttendanceReport: $e');
      print(stacktrace);
      rethrow;
    }
  }
}
