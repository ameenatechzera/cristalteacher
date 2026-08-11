import 'dart:convert';

import 'package:cristalteacher/core/errors/error_messege_model.dart';
import 'package:cristalteacher/core/errors/exceptions.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/network/api_endpoints.dart';
import 'package:cristalteacher/core/network/api_helper.dart';
import 'package:cristalteacher/features/diary/data/models/diary_model.dart';
import 'package:cristalteacher/features/diary/domain/parameters/fetch_diary_parameter.dart';
import 'package:cristalteacher/features/diary/domain/parameters/save_diary_parameter.dart';
import 'package:cristalteacher/services/shared_preference_helper.dart';
import 'package:dio/dio.dart';

abstract class DiaryRemoteDataSource {
  Future<DiaryResponseModel> fetchDiary(FetchDiaryParameter request);
  Future<MasterResponseModel> saveDiary(SaveDiaryParameter params);
}

class DiaryRemoteDataSourceImpl implements DiaryRemoteDataSource {
  final Dio dio = Dio();
  @override
  Future<DiaryResponseModel> fetchDiary(FetchDiaryParameter request) async {
    print('');
    print('==============================================');
    print('📘 FETCH DIARY API START');
    print('==============================================');

    try {
      /// Shared Preference Values
      final pref = SharedPreferenceHelper();

      final baseUrl = await pref.getBaseUrl();
      final token = await pref.getToken();
      final dbName = await pref.getDatabaseName();

      print('📌 Shared Preference Values');
      print('----------------------------------------------');
      print('Base URL        : $baseUrl');
      print('Token           : $token');
      print('Database Name   : $dbName');
      print('----------------------------------------------');

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// API URL
      final url = ApiConstants.getDiaryDetailsPath(baseUrl);

      print('📌 API URL');
      print('----------------------------------------------');
      print(url);
      print('----------------------------------------------');

      /// Headers
      final options = await ApiHelper.getAuthOptions(withToken: true);

      print('📌 Request Headers');
      print('----------------------------------------------');
      options.headers?.forEach((key, value) {
        print('$key : $value');
      });
      print('----------------------------------------------');

      /// Request Body
      print('📌 Request Body');
      print('----------------------------------------------');
      print(request.toJson());

      print('branchId    : ${request.branchId}');
      print('standardId  : ${request.standardId}');
      print('divisionId  : ${request.divisionId}');
      print('accyear     : ${request.accyear}');
      print('fromDate    : ${request.fromDate}');
      print('toDate      : ${request.toDate}');
      print('userId      : ${request.userId}');
      print('----------------------------------------------');
      print("Content-Type: ${options.contentType}");
      print("Request Headers: ${options.headers}");
      print("Request Data Type: ${request.toJson().runtimeType}");

      /// API Call
      final response = await dio.post(
        url,
        data: request.toJson(),
        options: options,
      );

      print('📌 Response');
      print('----------------------------------------------');
      print('HTTP Status : ${response.statusCode}');
      print(response.data);
      print('----------------------------------------------');

      if (response.data is Map<String, dynamic>) {
        final json = response.data as Map<String, dynamic>;

        print('📌 Parsed Response');
        print('----------------------------------------------');
        print('status  : ${json['status']}');
        print('error   : ${json['error']}');
        print('message : ${json['message']}');

        if (json.containsKey('data')) {
          if (json['data'] is List) {
            final list = json['data'] as List;

            print('Data Count : ${list.length}');

            if (list.isNotEmpty) {
              print('First Item');
              print(list.first);
            }
          } else {
            print('Data');
            print(json['data']);
          }
        }

        print('----------------------------------------------');
      }

      print('==============================================');
      print('📘 FETCH DIARY API END');
      print('==============================================');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return DiaryResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      }
      print('📸 ================= FILE DEBUG =================');
      print('📸 Full Response: ${response.data}');

      if (response.data is Map<String, dynamic>) {
        final data = response.data['data'];

        if (data is List) {
          for (var i = 0; i < data.length; i++) {
            print('📸 Diary $i files: ${data[i]['files']}');
            print('📸 Diary $i full item: ${data[i]}');
          }
        }
      }

      print('📸 ==============================================');
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    } on DioException catch (e, stackTrace) {
      print('');
      print('==============================================');
      print('❌ DIO EXCEPTION');
      print('==============================================');
      print('Message : ${e.message}');
      print('Status  : ${e.response?.statusCode}');
      print('Headers : ${e.response?.headers}');
      print('Response: ${e.response?.data}');
      print('Request : ${e.requestOptions.uri}');
      print('Method  : ${e.requestOptions.method}');
      print('==============================================');
      print(stackTrace);

      if (e.response?.data is Map<String, dynamic>) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(
            e.response!.data as Map<String, dynamic>,
          ),
        );
      }

      rethrow;
    } catch (e, stackTrace) {
      print('');
      print('==============================================');
      print('❌ GENERAL EXCEPTION');
      print('==============================================');
      print(e);
      print(stackTrace);
      print('==============================================');
      rethrow;
    }
  }

  // @override
  // Future<MasterResponseModel> saveDiary(SaveDiaryParameter params) async {
  //   print('📘 Save Diary Called');
  //   print('SaveDiaryParameter: ${params.toJson()}');

  //   try {
  //     final baseUrl = await SharedPreferenceHelper().getBaseUrl();

  //     if (baseUrl == null || baseUrl.isEmpty) {
  //       throw Exception("Base URL not set");
  //     }

  //     final url = ApiConstants.getSaveDiaryPath(baseUrl);

  //     print("URL : $url");

  //     final options = await ApiHelper.getAuthOptions(withToken: true);

  //     final response = await dio.post(
  //       url,
  //       data: params.toJson(),
  //       options: options,
  //     );

  //     print('📘 Status Code: ${response.statusCode}');
  //     print('📘 Response Data: ${response.data}');

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return MasterResponseModel.fromJson(response.data);
  //     } else {
  //       throw ServerException(
  //         errorMessageModel: ErrorMessageModel.fromJson(response.data),
  //       );
  //     }
  //   } catch (e, stackTrace) {
  //     print('❌ Exception in saveDiary: $e');
  //     print(stackTrace);
  //     rethrow;
  //   }
  // }
  // @override
  // Future<MasterResponseModel> saveDiary(SaveDiaryParameter params) async {
  //   print('');
  //   print('==========================================');
  //   print('🟢 SAVE DIARY START');
  //   print('==========================================');

  //   try {
  //     final pref = SharedPreferenceHelper();

  //     final baseUrl = await pref.getBaseUrl();
  //     final dbName = await pref.getDatabaseName();
  //     final token = await pref.getToken() ?? '';

  //     if (baseUrl == null || baseUrl.isEmpty) {
  //       throw Exception('Base URL not set');
  //     }

  //     if (token.isEmpty) {
  //       throw Exception('Token missing! Please login again.');
  //     }

  //     final url = ApiConstants.getSaveDiaryPath(baseUrl);

  //     print('🟢 Base URL: $baseUrl');
  //     print('🟢 DB Name: $dbName');
  //     print('🟢 API URL: $url');

  //     // ============================================================
  //     // NORMAL FIELDS
  //     // ============================================================

  //     final Map<String, dynamic> data = {
  //       'AccYear': params.accYear,
  //       'StandardId': params.standardId,
  //       'DivisionId': params.divisionId,
  //       'SubjectId': params.subjectId,
  //       'EmployeeId': params.employeeId,
  //       'diaryType': params.diaryType,
  //       'diaryTitle': params.diaryTitle,
  //       'Description': params.description,
  //       'diaryDate': params.diaryDate,
  //       'dueDate': params.dueDate,
  //       'isActive': params.isActive,
  //       'isFavourite': params.isFavourite,
  //       'branchId': params.branchId,
  //       'CreatedUser': params.createdUser,
  //       'videoUrl': params.videoUrl,
  //     };

  //     print('🟢 ===== FORM FIELDS =====');

  //     data.forEach((key, value) {
  //       print('$key : $value');
  //     });

  //     // ============================================================
  //     // FORMDATA
  //     // ============================================================

  //     final formData = FormData.fromMap(data);
  //     for (final field in formData.fields) {
  //       print('FIELD => ${field.key} : ${field.value}');
  //     }

  //     for (final file in formData.files) {
  //       print(
  //         'FILE => key: ${file.key}, '
  //         'filename: ${file.value.filename}, '
  //         'contentType: ${file.value.contentType}',
  //       );
  //     }
  //     // ============================================================
  //     // FILES
  //     // ============================================================

  //     print('🟡 Files Found: ${params.files.length}');

  //     for (int i = 0; i < params.files.length; i++) {
  //       final fileString = params.files[i];

  //       if (fileString.isEmpty) {
  //         continue;
  //       }

  //       print('🟡 Processing File ${i + 1}');
  //       print('🟡 File Length: ${fileString.length}');

  //       String base64String = fileString;
  //       String fileName = 'diary_file_${i + 1}.jpg';

  //       // ==========================================================
  //       // DATA URI
  //       // ==========================================================

  //       if (fileString.startsWith('data:')) {
  //         final commaIndex = fileString.indexOf(',');

  //         if (commaIndex == -1) {
  //           throw Exception('Invalid Base64 image format');
  //         }

  //         final header = fileString.substring(0, commaIndex);

  //         base64String = fileString.substring(commaIndex + 1);

  //         print('🟡 Header: $header');

  //         if (header.contains('image/png')) {
  //           fileName = 'diary_file_${i + 1}.png';
  //         } else if (header.contains('image/webp')) {
  //           fileName = 'diary_file_${i + 1}.webp';
  //         } else {
  //           fileName = 'diary_file_${i + 1}.jpg';
  //         }
  //       }

  //       // ==========================================================
  //       // BASE64 → BYTES
  //       // ==========================================================

  //       final bytes = base64Decode(base64String);

  //       print('🟢 Decoded Bytes: ${bytes.length}');
  //       print('🟢 File Name: $fileName');

  //       // ==========================================================
  //       // ADD FILE
  //       // ==========================================================

  //       formData.files.add(
  //         MapEntry(
  //           'files[]',
  //           MultipartFile.fromBytes(bytes, filename: fileName),
  //         ),
  //       );

  //       print('🟢 File added successfully');
  //     }

  //     // ============================================================
  //     // DEBUG
  //     // ============================================================

  //     print('');
  //     print('==========================================');
  //     print('🟢 FORMDATA FIELDS');
  //     print('==========================================');

  //     for (final field in formData.fields) {
  //       print('${field.key} : ${field.value}');
  //     }

  //     print('');
  //     print('==========================================');
  //     print('🟡 FORMDATA FILES');
  //     print('==========================================');

  //     for (final file in formData.files) {
  //       print('${file.key} : ${file.value.filename}');
  //     }

  //     // ============================================================
  //     // API OPTIONS
  //     // ============================================================

  //     final options = Options(
  //       contentType: 'multipart/form-data',
  //       headers: {
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $token',
  //         'X-Database-Name': dbName,
  //       },
  //     );

  //     // ============================================================
  //     // API CALL
  //     // ============================================================

  //     print('');
  //     print('==========================================');
  //     print('🟢 CALLING SAVE DIARY API');
  //     print('==========================================');

  //     final response = await dio.post(url, data: formData, options: options);

  //     // ============================================================
  //     // RESPONSE
  //     // ============================================================

  //     print('');
  //     print('==========================================');
  //     print('🟢 SAVE DIARY RESPONSE');
  //     print('==========================================');

  //     print('Status Code: ${response.statusCode}');
  //     print('Response Data: ${response.data}');

  //     print('==========================================');

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return MasterResponseModel.fromJson(response.data);
  //     }

  //     throw ServerException(
  //       errorMessageModel: ErrorMessageModel.fromJson(response.data),
  //     );
  //   } on DioException catch (e, stackTrace) {
  //     print('');
  //     print('==========================================');
  //     print('❌ DIO ERROR');
  //     print('==========================================');

  //     print('Message : ${e.message}');
  //     print('Status  : ${e.response?.statusCode}');
  //     print('Response: ${e.response?.data}');
  //     print('URL     : ${e.requestOptions.uri}');

  //     print('==========================================');
  //     print(stackTrace);

  //     if (e.response?.data is Map<String, dynamic>) {
  //       throw ServerException(
  //         errorMessageModel: ErrorMessageModel.fromJson(e.response!.data),
  //       );
  //     }

  //     rethrow;
  //   } catch (e, stackTrace) {
  //     print('');
  //     print('==========================================');
  //     print('❌ ERROR IN SAVE DIARY');
  //     print('==========================================');

  //     print(e);
  //     print(stackTrace);

  //     print('==========================================');

  //     rethrow;
  //   }
  // }
  @override
  Future<MasterResponseModel> saveDiary(SaveDiaryParameter params) async {
    print('');
    print('==========================================');
    print('🟢 SAVE DIARY START');
    print('==========================================');

    try {
      final pref = SharedPreferenceHelper();

      final baseUrl = await pref.getBaseUrl();
      final dbName = await pref.getDatabaseName();
      final token = await pref.getToken() ?? '';

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception('Base URL not set');
      }

      if (token.isEmpty) {
        throw Exception('Token missing! Please login again.');
      }

      final url = ApiConstants.getSaveDiaryPath(baseUrl);

      print('🟢 Base URL: $baseUrl');
      print('🟢 DB Name: $dbName');
      print('🟢 API URL: $url');

      // ============================================================
      // NORMAL FIELDS
      // ============================================================

      final Map<String, dynamic> data = {
        'AccYear': params.accYear,
        'StandardId': params.standardId,
        'DivisionId': params.divisionId,
        'SubjectId': params.subjectId,
        'EmployeeId': params.employeeId,
        'diaryType': params.diaryType,
        'diaryTitle': params.diaryTitle,
        'Description': params.description,
        'diaryDate': params.diaryDate,
        'dueDate': params.dueDate,
        'isActive': params.isActive,
        'isFavourite': params.isFavourite,
        'branchId': params.branchId,
        'CreatedUser': params.createdUser,
        'videoUrl': params.videoUrl,
      };

      print('🟢 ===== FORM FIELDS =====');

      data.forEach((key, value) {
        print('$key : $value');
      });

      // ============================================================
      // FORMDATA
      // ============================================================

      final formData = FormData.fromMap(data);

      // ============================================================
      // FILES
      // ============================================================

      print('');
      print('==========================================');
      print('🟡 PROCESSING FILES');
      print('==========================================');

      print('🟡 Files Found: ${params.files.length}');

      for (int i = 0; i < params.files.length; i++) {
        final fileString = params.files[i];

        if (fileString.isEmpty) {
          print('⚠️ File ${i + 1} is empty. Skipping.');
          continue;
        }

        print('');
        print('------------------------------------------');
        print('🟡 Processing File ${i + 1}');
        print('------------------------------------------');

        print('🟡 File Length: ${fileString.length}');

        String base64String = fileString;

        // DO NOT default to jpg
        String fileName = 'diary_file_${i + 1}';

        String? contentType;

        // ==========================================================
        // DATA URI
        // ==========================================================

        if (fileString.startsWith('data:')) {
          final commaIndex = fileString.indexOf(',');

          if (commaIndex == -1) {
            throw Exception('Invalid Base64 file format for file ${i + 1}');
          }

          final header = fileString.substring(0, commaIndex);

          base64String = fileString.substring(commaIndex + 1);

          print('🟡 File Header: $header');

          // ========================================================
          // IMAGES
          // ========================================================

          if (header.contains('image/jpeg')) {
            fileName = 'diary_file_${i + 1}.jpg';
            contentType = 'image/jpeg';
          } else if (header.contains('image/png')) {
            fileName = 'diary_file_${i + 1}.png';
            contentType = 'image/png';
          } else if (header.contains('image/webp')) {
            fileName = 'diary_file_${i + 1}.webp';
            contentType = 'image/webp';
          }
          // ========================================================
          // AUDIO
          // ========================================================
          else if (header.contains('audio/mpeg')) {
            fileName = 'diary_file_${i + 1}.mp3';
            contentType = 'audio/mpeg';
          } else if (header.contains('audio/mp3')) {
            fileName = 'diary_file_${i + 1}.mp3';
            contentType = 'audio/mpeg';
          } else if (header.contains('audio/mp4')) {
            fileName = 'diary_file_${i + 1}.m4a';
            contentType = 'audio/mp4';
          } else if (header.contains('audio/x-m4a')) {
            fileName = 'diary_file_${i + 1}.m4a';
            contentType = 'audio/x-m4a';
          } else if (header.contains('audio/wav')) {
            fileName = 'diary_file_${i + 1}.wav';
            contentType = 'audio/wav';
          } else if (header.contains('audio/x-wav')) {
            fileName = 'diary_file_${i + 1}.wav';
            contentType = 'audio/wav';
          } else if (header.contains('audio/aac')) {
            fileName = 'diary_file_${i + 1}.aac';
            contentType = 'audio/aac';
          } else if (header.contains('audio/ogg')) {
            fileName = 'diary_file_${i + 1}.ogg';
            contentType = 'audio/ogg';
          } else if (header.contains('audio/amr')) {
            fileName = 'diary_file_${i + 1}.amr';
            contentType = 'audio/amr';
          } else {
            throw Exception(
              'Unsupported file type.\n'
              'File: ${i + 1}\n'
              'Header: $header',
            );
          }
        } else {
          print('⚠️ No DATA URI header found.');

          print(
            '⚠️ The Base64 does not contain '
            'the file type information.',
          );

          // We don't assume JPG anymore.
          //
          // If the recorder sends raw Base64 without
          // "data:audio/...", the actual file type must
          // be supplied by the code creating params.files.
        }

        // ==========================================================
        // BASE64 → BYTES
        // ==========================================================

        final bytes = base64Decode(base64String);

        print('🟢 Decoded Bytes: ${bytes.length}');
        print('🟢 File Name: $fileName');
        print('🟢 Content Type: $contentType');

        // ==========================================================
        // ADD FILE TO FORMDATA
        // ==========================================================

        formData.files.add(
          MapEntry(
            'files[]',
            MultipartFile.fromBytes(
              bytes,
              filename: fileName,
              // contentType: contentType != null
              //     ? MediaType.parse(contentType)
              //     : null,
            ),
          ),
        );

        print('🟢 File added successfully');
      }

      // ============================================================
      // DEBUG FORMDATA
      // ============================================================

      print('');
      print('==========================================');
      print('🟢 FORMDATA FIELDS');
      print('==========================================');

      for (final field in formData.fields) {
        print('${field.key} : ${field.value}');
      }

      print('');
      print('==========================================');
      print('🟡 FORMDATA FILES');
      print('==========================================');

      for (final file in formData.files) {
        print(
          'Key: ${file.key} | '
          'Filename: ${file.value.filename} | '
          'ContentType: ${file.value.contentType}',
        );
      }

      // ============================================================
      // API OPTIONS
      // ============================================================

      final options = Options(
        contentType: 'multipart/form-data',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'X-Database-Name': dbName,
        },
      );

      // ============================================================
      // API CALL
      // ============================================================

      print('');
      print('==========================================');
      print('🟢 CALLING SAVE DIARY API');
      print('==========================================');

      final response = await dio.post(url, data: formData, options: options);

      // ============================================================
      // RESPONSE
      // ============================================================

      print('');
      print('==========================================');
      print('🟢 SAVE DIARY RESPONSE');
      print('==========================================');

      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      print('==========================================');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return MasterResponseModel.fromJson(response.data);
      }

      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    } on DioException catch (e, stackTrace) {
      print('');
      print('==========================================');
      print('❌ DIO ERROR');
      print('==========================================');

      print('Message : ${e.message}');
      print('Status  : ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');
      print('URL     : ${e.requestOptions.uri}');

      print('==========================================');
      print(stackTrace);

      if (e.response?.data is Map<String, dynamic>) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(e.response!.data),
        );
      }

      rethrow;
    } catch (e, stackTrace) {
      print('');
      print('==========================================');
      print('❌ ERROR IN SAVE DIARY');
      print('==========================================');

      print(e);
      print(stackTrace);

      print('==========================================');

      rethrow;
    }
  }
}
