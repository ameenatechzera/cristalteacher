import 'dart:convert';

import 'package:cristalteacher/core/errors/error_messege_model.dart';
import 'package:cristalteacher/core/errors/exceptions.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/network/api_endpoints.dart';
import 'package:cristalteacher/core/network/api_helper.dart';
import 'package:cristalteacher/features/exams/data/models/fetch_gradeplan_model.dart';
import 'package:cristalteacher/features/exams/data/models/fetchexam_model.dart';
import 'package:cristalteacher/features/exams/data/models/get_all_exam_model.dart';
import 'package:cristalteacher/features/exams/data/models/markentry_detailsforupdate_model.dart';
import 'package:cristalteacher/features/exams/data/models/save_exam_model.dart';
import 'package:cristalteacher/features/exams/domain/parameters/fetch_exam_parameter.dart';
import 'package:cristalteacher/features/exams/domain/parameters/save_exam_parameter.dart';
import 'package:cristalteacher/features/exams/domain/parameters/update_exam_parameter.dart';
import 'package:cristalteacher/services/shared_preference_helper.dart';
import 'package:dio/dio.dart';

abstract class ExamRemoteDataSource {
  Future<FetchExamResponseModel> fetchMarkEntry(FetchMarkEntryParameter params);
  Future<GradePlanResponseModel> fetchGradePlan();
  Future<GetAllExamResponseModel> getAllExams();
  Future saveExamMarks(SaveExamMarksParameter params);
  Future<MasterResponseModel> deleteExams(int id);
  Future<MasterResponseModel> updateExamMarks(
    UpdateMarkEntryParameter params,
    int markEntryId,
  );
  Future<MarkEntryDetailsModel> fetchMarkEntryDetails(int markEntryId);
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

  // @override
  // Future<MasterResponseModel> updateExamMarks(
  //   UpdateMarkEntryParameter params,
  //   int examId,
  // ) async {
  //   print('✏️ Update Exam Marks Called');
  //   print('UpdateMarkEntryParameter: ${params.toJson()}');

  //   try {
  //     /// Base URL
  //     final baseUrl = await SharedPreferenceHelper().getBaseUrl();

  //     if (baseUrl == null || baseUrl.isEmpty) {
  //       throw Exception("Base URL not set");
  //     }

  //     /// API URL
  //     final url = '${ApiConstants.updateExamMarksPath(baseUrl)}$examId';

  //     print("✏️ Update Exam Marks URL: $url");

  //     /// Headers
  //     final options = await ApiHelper.getAuthOptions(withToken: true);

  //     /// API Call
  //     final response = await dio.post(
  //       url,
  //       data: params.toJson(),
  //       options: options,
  //     );

  //     print('✏️ Status Code: ${response.statusCode}');

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
  //       return MasterResponseModel.fromJson(response.data);
  //     } else {
  //       throw ServerException(
  //         errorMessageModel: ErrorMessageModel.fromJson(response.data),
  //       );
  //     }
  //   } catch (e, stacktrace) {
  //     print('❌ Exception in updateExamMarks: $e');
  //     print(stacktrace);
  //     rethrow;
  //   }
  // }
  @override
  Future<MasterResponseModel> updateExamMarks(
    UpdateMarkEntryParameter params,
    int markEntryId,
  ) async {
    print('✏️ Update Exam Marks Called');
    print('UpdateMarkEntryParameter: ${params.toJson()}');

    try {
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      final url = '${ApiConstants.updateExamMarksPath(baseUrl)}$markEntryId';
      print("✏️ Update Exam Marks URL: $url");

      final options = await ApiHelper.getAuthOptions(withToken: true);

      final response = await dio.post(
        url,
        data: params.toJson(),
        options: options,
      );

      print('✏️ Status Code: ${response.statusCode}');

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
      print('❌ Exception in updateExamMarks: $e');
      print(stacktrace);
      rethrow;
    }
  }

  @override
  Future<MarkEntryDetailsModel> fetchMarkEntryDetails(int markEntryId) async {
    print('');
    print('======================================================');
    print('📘 FETCH MARK ENTRY DETAILS');
    print('======================================================');
    print('📌 MarkEntryId: $markEntryId');

    try {
      // =====================================================
      // BASE URL
      // =====================================================

      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      print('📌 Base URL: $baseUrl');

      if (baseUrl == null || baseUrl.isEmpty) {
        print('❌ Base URL IS NULL OR EMPTY');
        throw Exception('Base URL not set');
      }

      // =====================================================
      // API URL
      // =====================================================

      final url =
          '${ApiConstants.getMarkEntryDetailsPath(baseUrl)}$markEntryId';

      print('📌 API URL: $url');

      // =====================================================
      // HEADERS
      // =====================================================

      final options = await ApiHelper.getAuthOptions(withToken: true);

      print('📌 Headers available: ${options.headers != null}');

      // =====================================================
      // API CALL
      // =====================================================

      print('');
      print('🚀 Calling API...');
      print('➡️ GET: $url');

      final response = await dio.get(url, options: options);

      // =====================================================
      // RESPONSE
      // =====================================================

      print('');
      print('======================================================');
      print('📥 API RESPONSE');
      print('======================================================');

      print('📌 Status Code: ${response.statusCode}');
      print('📌 Response Type: ${response.data.runtimeType}');

      print('📦 Response Data:');
      print(response.data);

      // =====================================================
      // SUCCESS
      // =====================================================

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('');
        print('✅ API SUCCESS');

        // ---------------------------------------------------
        // CHECK RESPONSE STRUCTURE
        // ---------------------------------------------------

        if (response.data is! Map) {
          print('❌ response.data is NOT a Map');

          throw Exception('Invalid mark entry response format');
        }

        final responseMap = Map<String, dynamic>.from(response.data);

        print('📌 Response keys: ${responseMap.keys.toList()}');

        // ---------------------------------------------------
        // GET DATA
        // ---------------------------------------------------

        final data = responseMap['data'];

        print('');
        print('🔍 DATA FIELD');
        print('📌 data type: ${data.runtimeType}');

        if (data == null) {
          print('❌ data IS NULL');

          throw Exception('Mark entry data is null');
        }

        if (data is! Map) {
          print('❌ data IS NOT A MAP');

          throw Exception('Invalid mark entry data format');
        }

        final markEntryData = Map<String, dynamic>.from(data);

        // ---------------------------------------------------
        // DEBUG MARK ENTRY DATA
        // ---------------------------------------------------

        print('');
        print('======================================================');
        print('🔍 MARK ENTRY DATA');
        print('======================================================');

        print(
          '📌 MarkEntryId: '
          '${markEntryData['MarkEntryId']}',
        );

        print(
          '📌 StandardId: '
          '${markEntryData['StandardId']}',
        );

        print(
          '📌 DivisionId: '
          '${markEntryData['DivisionId']}',
        );

        print(
          '📌 SubjectId: '
          '${markEntryData['SubjectId']}',
        );

        print(
          '📌 GradePlanId: '
          '${markEntryData['GradePlanId']}',
        );

        print(
          '📌 MaxTE: '
          '${markEntryData['MaxTE']}',
        );

        print(
          '📌 MaxCE: '
          '${markEntryData['MaxCE']}',
        );

        print(
          '📌 ExamId: '
          '${markEntryData['examId']}',
        );

        print(
          '📌 ExamName: '
          '${markEntryData['examName']}',
        );

        // ---------------------------------------------------
        // DETAILS
        // ---------------------------------------------------

        final details = markEntryData['Details'];

        print('');
        print('======================================================');
        print('👨‍🎓 STUDENT DETAILS');
        print('======================================================');

        print('📌 Details type: ${details.runtimeType}');

        if (details is List) {
          print('📌 Details count: ${details.length}');

          if (details.isNotEmpty) {
            print('');
            print('👨‍🎓 FIRST STUDENT:');
            print(details.first);
          } else {
            print('❌ Details list is EMPTY');
          }
        } else {
          print('❌ Details is NOT a List');
        }

        // ---------------------------------------------------
        // MODEL PARSING
        // ---------------------------------------------------

        print('');
        print('======================================================');
        print('🧩 PARSING MARK ENTRY MODEL');
        print('======================================================');

        final model = MarkEntryDetailsModel.fromJson(markEntryData);

        // ---------------------------------------------------
        // MODEL DEBUG
        // ---------------------------------------------------

        print('');
        print('======================================================');
        print('✅ PARSED MODEL');
        print('======================================================');

        print(
          '📌 Model MarkEntryId: '
          '${model.markEntryId}',
        );

        print(
          '📌 Model Details Count: '
          '${model.details.length}',
        );

        print(
          '📌 Model Details Type: '
          '${model.details.runtimeType}',
        );

        if (model.details.isNotEmpty) {
          print('');
          print('✅ FIRST PARSED STUDENT');
          print(model.details.first);
        } else {
          print('');
          print('❌ MODEL DETAILS ARE EMPTY');
          print(
            '⚠️ API has Details, but fromJson() is not '
            'parsing them.',
          );
        }

        print('');
        print('======================================================');
        print('📤 RETURNING MODEL');
        print('======================================================');

        return model;
      } else {
        // ===================================================
        // API FAILED
        // ===================================================

        print('');
        print('======================================================');
        print('❌ API FAILED');
        print('======================================================');

        print('📌 Status Code: ${response.statusCode}');

        print('📌 Response: ${response.data}');

        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('');
      print('======================================================');
      print('❌ EXCEPTION IN FETCH MARK ENTRY DETAILS');
      print('======================================================');

      print('📌 Exception: $e');
      print('📌 Exception Type: ${e.runtimeType}');

      print('');
      print('📚 STACKTRACE');
      print(stacktrace);

      rethrow;
    }
  }
  // @override
  // Future<MarkEntryDetailsModel> fetchMarkEntryDetails(int markEntryId) async {
  //   print('📘 Fetch Mark Entry Details Called');
  //   print('MarkEntryId: $markEntryId');

  //   try {
  //     /// Base URL
  //     final baseUrl = await SharedPreferenceHelper().getBaseUrl();

  //     if (baseUrl == null || baseUrl.isEmpty) {
  //       throw Exception("Base URL not set");
  //     }

  //     /// API URL
  //     final url =
  //         '${ApiConstants.getMarkEntryDetailsPath(baseUrl)}$markEntryId';

  //     print('📘 Fetch Mark Entry Details URL: $url');

  //     /// Headers
  //     final options = await ApiHelper.getAuthOptions(withToken: true);

  //     /// API Call
  //     final response = await dio.get(url, options: options);

  //     print('📘 Status Code: ${response.statusCode}');

  //     // /// Print response
  //     // final responseString = jsonEncode(response.data);

  //     // const chunkSize = 800;

  //     // for (int i = 0; i < responseString.length; i += chunkSize) {
  //     //   print(
  //     //     responseString.substring(
  //     //       i,
  //     //       i + chunkSize > responseString.length
  //     //           ? responseString.length
  //     //           : i + chunkSize,
  //     //     ),
  //     //   );
  //     // }

  //     // /// Success
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return MarkEntryDetailsModel.fromJson(response.data['data']);
  //     } else {
  //       throw ServerException(
  //         errorMessageModel: ErrorMessageModel.fromJson(response.data),
  //       );
  //     }
  //   } catch (e, stacktrace) {
  //     print('❌ Exception in fetchMarkEntryDetails: $e');
  //     print(stacktrace);
  //     rethrow;
  //   }
  // }
}
