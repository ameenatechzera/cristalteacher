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

  @override
  Future<MasterResponseModel> saveDiary(SaveDiaryParameter params) async {
    print('📘 Save Diary Called');
    print('SaveDiaryParameter: ${params.toJson()}');

    try {
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      final url = ApiConstants.getSaveDiaryPath(baseUrl);

      print("URL : $url");

      final options = await ApiHelper.getAuthOptions(withToken: true);

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
    } catch (e, stackTrace) {
      print('❌ Exception in saveDiary: $e');
      print(stackTrace);
      rethrow;
    }
  }
}
//   @override
//   Future<DiaryResponseModel> fetchDiary(FetchDiaryParameter request) async {
//     print('📘 Fetch Diary Called');
//     print('📘 Params: ${request.toJson()}');

//     try {
//       final baseUrl = await SharedPreferenceHelper().getBaseUrl();

//       if (baseUrl == null || baseUrl.isEmpty) {
//         throw Exception('Base URL not set');
//       }

//       final url = '${baseUrl}classdiary';

//       print('📘 Base URL: $baseUrl');
//       print('📘 URL: $url');

//       final options = await ApiHelper.getAuthOptions(withToken: true);

//       print('📘 Headers: ${options.headers}');

//       final response = await dio.post(
//         url,
//         data: request.toJson(),
//         options: options,
//       );

//       print('📘 Status Code: ${response.statusCode}');
//       print('📘 Response Data: ${response.data}');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return DiaryResponseModel.fromJson(
//           response.data as Map<String, dynamic>,
//         );
//       }

//       throw ServerException(
//         errorMessageModel: ErrorMessageModel.fromJson(response.data),
//       );
//     } on DioException catch (e, stackTrace) {
//       print('❌ DioException in Fetch Diary');
//       print('❌ Message: ${e.message}');
//       print('❌ Status: ${e.response?.statusCode}');
//       print('❌ Data: ${e.response?.data}');
//       print(stackTrace);

//       if (e.response?.data is Map<String, dynamic>) {
//         throw ServerException(
//           errorMessageModel: ErrorMessageModel.fromJson(
//             e.response!.data as Map<String, dynamic>,
//           ),
//         );
//       }

//       rethrow;
//     } catch (e, stackTrace) {
//       print('❌ Exception in Fetch Diary: $e');
//       print(stackTrace);
//       rethrow;
//     }
//   }
// }
