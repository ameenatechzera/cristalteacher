import 'dart:convert';

import 'package:cristalteacher/core/errors/error_messege_model.dart';
import 'package:cristalteacher/core/errors/exceptions.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/network/api_endpoints.dart';
import 'package:cristalteacher/core/network/api_helper.dart';
import 'package:cristalteacher/features/exams/data/models/fetch_gradeplan_model.dart';
import 'package:cristalteacher/features/exams/data/models/fetchexam_model.dart';
import 'package:cristalteacher/features/exams/data/models/get_all_exam_model.dart';
import 'package:cristalteacher/features/exams/data/models/save_exam_model.dart';
import 'package:cristalteacher/features/exams/domain/parameters/fetch_exam_parameter.dart';
import 'package:cristalteacher/features/exams/domain/parameters/save_exam_parameter.dart';
import 'package:cristalteacher/services/shared_preference_helper.dart';
import 'package:dio/dio.dart';

abstract class ExamRemoteDataSource {
  Future<FetchExamResponseModel> fetchMarkEntry(FetchMarkEntryParameter params);
  Future<GradePlanResponseModel> fetchGradePlan();
  Future<GetAllExamResponseModel> getAllExams();
  Future saveExamMarks(SaveExamMarksParameter params);
  Future<MasterResponseModel> deleteExams(int id);
}

class ExamRemoteDataSourceImpl implements ExamRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<FetchExamResponseModel> fetchMarkEntry(
    FetchMarkEntryParameter params,
  ) async {
    print('📘 Fetch Mark Entry Called');
    print('FetchMarkEntryParameter: ${params.toJson()}');

    try {
      /// Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// API URL
      final url = ApiConstants.getMarkEntryPath(baseUrl);

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
        return FetchExamResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in fetchMarkEntry: $e');
      print(stacktrace);
      rethrow;
    }
  }

  @override
  Future<GradePlanResponseModel> fetchGradePlan() async {
    print('📘 Fetch Grade Plan Called');

    try {
      /// Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// API URL
      final url = ApiConstants.getGradePlanPath(baseUrl);

      print("URL : $url");

      /// Headers
      final options = await ApiHelper.getAuthOptions(withToken: true);

      /// API Call
      final response = await dio.get(url, options: options);

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
        return GradePlanResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in fetchGradePlan: $e');
      print(stacktrace);
      rethrow;
    }
  }

  @override
  Future<GetAllExamResponseModel> getAllExams() async {
    print('📘 Get All Exams Called');

    try {
      /// Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// API URL
      final url = ApiConstants.getAllExamPath(baseUrl);

      print("URL : $url");

      /// Headers
      final options = await ApiHelper.getAuthOptions(withToken: true);

      /// API Call
      final response = await dio.get(url, options: options);

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
        return GetAllExamResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in getAllExams: $e');
      print(stacktrace);
      rethrow;
    }
  }

  @override
  Future<SaveExamMarksModel> saveExamMarks(
    SaveExamMarksParameter params,
  ) async {
    print('📘 Save Exam Marks Called');
    print('SaveExamMarksParameter: ${params.toJson()}');

    try {
      /// Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// API URL
      final url = ApiConstants.saveExamMarksPath(baseUrl);

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
        return SaveExamMarksModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in saveExamMarks: $e');
      print(stacktrace);
      rethrow;
    }
  }

  @override
  Future<MasterResponseModel> deleteExams(int id) async {
    print('🗑️ Delete Exam Mark Called');
    print('Exam Mark ID: $id');

    try {
      /// Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// API URL
      /// ID is passed along with the URL
      final url = '${ApiConstants.deleteExamMarkPath(baseUrl)}$id';

      print('🗑️ Delete Exam Mark URL: $url');

      /// Headers
      final options = await ApiHelper.getAuthOptions(withToken: true);

      /// API Call
      final response = await dio.post(url, options: options);

      print('🗑️ Status Code: ${response.statusCode}');

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
        return MasterResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in deleteExamMark: $e');
      print(stacktrace);
      rethrow;
    }
  }
}
