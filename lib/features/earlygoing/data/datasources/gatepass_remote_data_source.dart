// import 'package:cristalteacher/core/errors/error_messege_model.dart';
// import 'package:cristalteacher/core/errors/exceptions.dart';
// import 'package:cristalteacher/core/models/master_response_model.dart';
// import 'package:cristalteacher/core/network/api_endpoints.dart';
// import 'package:cristalteacher/core/network/api_helper.dart';
// import 'package:cristalteacher/features/earlygoing/data/models/gatepass_model.dart';
// import 'package:cristalteacher/features/earlygoing/domain/parameter/gatepass_parameter.dart';
// import 'package:cristalteacher/features/earlygoing/domain/parameter/update_gatepass_parameter.dart';
// import 'package:cristalteacher/services/shared_preference_helper.dart';
// import 'package:dio/dio.dart';

// abstract class GatePassRemoteDataSource {
//   Future<GatePassResponseModel> fetchGatePass(FetchGatePassParameter request);
//   Future<MasterResponseModel> updateGatePass(
//     UpdateGatePassParameter request,
//     int id,
//   );
// }

// class GatePassRemoteDataSourceImpl implements GatePassRemoteDataSource {
//   final Dio dio = Dio();

//   @override
//   Future<GatePassResponseModel> fetchGatePass(
//     FetchGatePassParameter request,
//   ) async {
//     try {
//       final pref = SharedPreferenceHelper();

//       final baseUrl = await pref.getBaseUrl();
//       final token = await pref.getToken();

//       if (baseUrl == null || baseUrl.isEmpty) {
//         throw Exception('Base URL not set');
//       }

//       if (token == null || token.isEmpty) {
//         throw Exception('Token missing! Please login again.');
//       }

//       final url = ApiConstants.getGatePassPath(baseUrl);

//       final options = await ApiHelper.getAuthOptions(withToken: true);

//       final response = await dio.post(
//         url,
//         data: request.toJson(),
//         options: options,
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         if (response.data is! Map<String, dynamic>) {
//           throw Exception('Invalid gate pass response format');
//         }

//         return GatePassResponseModel.fromJson(
//           response.data as Map<String, dynamic>,
//         );
//       }

//       if (response.data is Map<String, dynamic>) {
//         throw ServerException(
//           errorMessageModel: ErrorMessageModel.fromJson(
//             response.data as Map<String, dynamic>,
//           ),
//         );
//       }

//       throw Exception('Invalid gate pass error response format');
//     } on DioException catch (e) {
//       if (e.response?.data is Map<String, dynamic>) {
//         throw ServerException(
//           errorMessageModel: ErrorMessageModel.fromJson(
//             e.response!.data as Map<String, dynamic>,
//           ),
//         );
//       }

//       rethrow;
//     }
//   }

//   @override
//   Future<MasterResponseModel> updateGatePass(
//     UpdateGatePassParameter request,
//     int id,
//   ) async {
//     try {
//       final pref = SharedPreferenceHelper();

//       final baseUrl = await pref.getBaseUrl();
//       final token = await pref.getToken();

//       if (baseUrl == null || baseUrl.isEmpty) {
//         throw Exception('Base URL not set');
//       }

//       if (token == null || token.isEmpty) {
//         throw Exception('Token missing! Please login again.');
//       }

//       final url = '${ApiConstants.getUpdateGatePassPath(baseUrl)}/$id';
//       final options = await ApiHelper.getAuthOptions(withToken: true);
//       final response = await dio.post(
//         url,
//         data: request.toJson(),
//         options: options,
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         if (response.data is! Map<String, dynamic>) {
//           throw Exception('Invalid update gate pass response format');
//         }

//         return MasterResponseModel.fromJson(
//           response.data as Map<String, dynamic>,
//         );
//       }

//       if (response.data is Map<String, dynamic>) {
//         throw ServerException(
//           errorMessageModel: ErrorMessageModel.fromJson(
//             response.data as Map<String, dynamic>,
//           ),
//         );
//       }
//       throw Exception('Invalid update gate pass error response format');
//     } on DioException catch (e) {
//       if (e.response?.data is Map<String, dynamic>) {
//         throw ServerException(
//           errorMessageModel: ErrorMessageModel.fromJson(
//             e.response!.data as Map<String, dynamic>,
//           ),
//         );
//       }

//       rethrow;
//     }
//   }
// }
import 'package:cristalteacher/core/errors/error_messege_model.dart';
import 'package:cristalteacher/core/errors/exceptions.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/network/api_endpoints.dart';
import 'package:cristalteacher/core/network/api_helper.dart';
import 'package:cristalteacher/features/earlygoing/data/models/gatepass_model.dart';
import 'package:cristalteacher/features/earlygoing/domain/parameter/gatepass_parameter.dart';
import 'package:cristalteacher/features/earlygoing/domain/parameter/update_gatepass_parameter.dart';
import 'package:cristalteacher/services/shared_preference_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class GatePassRemoteDataSource {
  Future<GatePassResponseModel> fetchGatePass(FetchGatePassParameter request);

  Future<MasterResponseModel> updateGatePass(
    UpdateGatePassParameter request,
    int id,
  );
}

class GatePassRemoteDataSourceImpl implements GatePassRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<GatePassResponseModel> fetchGatePass(
    FetchGatePassParameter request,
  ) async {
    try {
      final pref = SharedPreferenceHelper();

      final baseUrl = await pref.getBaseUrl();
      final token = await pref.getToken();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception('Base URL not set');
      }

      if (token == null || token.isEmpty) {
        throw Exception('Token missing! Please login again.');
      }

      final url = ApiConstants.getGatePassPath(baseUrl);
      final options = await ApiHelper.getAuthOptions(withToken: true);

      final Map<String, dynamic> requestData = request.toJson();

      debugPrint('');
      debugPrint('==================================================');
      debugPrint('📤 FETCH GATE PASS API REQUEST');
      debugPrint('==================================================');
      debugPrint('URL           : $url');
      debugPrint('Method        : POST');
      debugPrint('Token Exists  : ${token.isNotEmpty}');
      debugPrint('Request Data  :');
      debugPrint(requestData.toString());

      debugPrint('');
      debugPrint('📦 FETCH GATE PASS REQUEST FIELDS');
      debugPrint('--------------------------------------------------');

      requestData.forEach((key, value) {
        debugPrint('$key : $value');
      });

      debugPrint('==================================================');

      final response = await dio.post(url, data: requestData, options: options);

      debugPrint('');
      debugPrint('==================================================');
      debugPrint('📥 FETCH GATE PASS API RESPONSE');
      debugPrint('==================================================');
      debugPrint('Status Code : ${response.statusCode}');
      debugPrint('Status Text : ${response.statusMessage}');
      debugPrint('Response    : ${response.data}');
      debugPrint('==================================================');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is! Map<String, dynamic>) {
          debugPrint('❌ Invalid response type: ${response.data.runtimeType}');

          throw Exception('Invalid gate pass response format');
        }

        debugPrint('✅ Fetch gate pass API success');

        return GatePassResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      }

      debugPrint(
        '❌ Fetch gate pass API failed with status ${response.statusCode}',
      );

      if (response.data is Map<String, dynamic>) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(
            response.data as Map<String, dynamic>,
          ),
        );
      }

      throw Exception('Invalid gate pass error response format');
    } on DioException catch (e, stackTrace) {
      debugPrint('');
      debugPrint('==================================================');
      debugPrint('❌ FETCH GATE PASS DIO ERROR');
      debugPrint('==================================================');
      debugPrint('Error Type      : ${e.type}');
      debugPrint('Error Message   : ${e.message}');
      debugPrint('Request URL     : ${e.requestOptions.uri}');
      debugPrint('Request Method  : ${e.requestOptions.method}');
      debugPrint('Request Data    : ${e.requestOptions.data}');
      debugPrint('Response Code   : ${e.response?.statusCode}');
      debugPrint('Response Message: ${e.response?.statusMessage}');
      debugPrint('Response Data   : ${e.response?.data}');
      debugPrint('Stack Trace     : $stackTrace');
      debugPrint('==================================================');

      if (e.response?.data is Map<String, dynamic>) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(
            e.response!.data as Map<String, dynamic>,
          ),
        );
      }

      rethrow;
    } catch (error, stackTrace) {
      debugPrint('');
      debugPrint('==================================================');
      debugPrint('❌ FETCH GATE PASS UNEXPECTED ERROR');
      debugPrint('==================================================');
      debugPrint('Error      : $error');
      debugPrint('Stack Trace: $stackTrace');
      debugPrint('==================================================');

      rethrow;
    }
  }

  @override
  Future<MasterResponseModel> updateGatePass(
    UpdateGatePassParameter request,
    int id,
  ) async {
    try {
      final pref = SharedPreferenceHelper();

      final baseUrl = await pref.getBaseUrl();
      final token = await pref.getToken();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception('Base URL not set');
      }

      if (token == null || token.isEmpty) {
        throw Exception('Token missing! Please login again.');
      }

      final url = '${ApiConstants.getUpdateGatePassPath(baseUrl)}/$id';
      final options = await ApiHelper.getAuthOptions(withToken: true);

      final Map<String, dynamic> requestData = request.toJson();

      debugPrint('');
      debugPrint('==================================================');
      debugPrint('📤 UPDATE GATE PASS API REQUEST');
      debugPrint('==================================================');
      debugPrint('URL           : $url');
      debugPrint('Method        : POST');
      debugPrint('Gate Pass ID  : $id');
      debugPrint('Token Exists  : ${token.isNotEmpty}');
      debugPrint('Request Data  :');
      debugPrint(requestData.toString());

      debugPrint('');
      debugPrint('📦 UPDATE GATE PASS REQUEST FIELDS');
      debugPrint('--------------------------------------------------');

      requestData.forEach((key, value) {
        debugPrint('$key : $value');
      });

      debugPrint('==================================================');

      final response = await dio.post(url, data: requestData, options: options);

      debugPrint('');
      debugPrint('==================================================');
      debugPrint('📥 UPDATE GATE PASS API RESPONSE');
      debugPrint('==================================================');
      debugPrint('Status Code : ${response.statusCode}');
      debugPrint('Status Text : ${response.statusMessage}');
      debugPrint('Response    : ${response.data}');
      debugPrint('==================================================');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is! Map<String, dynamic>) {
          debugPrint('❌ Invalid response type: ${response.data.runtimeType}');

          throw Exception('Invalid update gate pass response format');
        }

        debugPrint('✅ Update gate pass API success');

        return MasterResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      }

      debugPrint(
        '❌ Update gate pass API failed with status ${response.statusCode}',
      );

      if (response.data is Map<String, dynamic>) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(
            response.data as Map<String, dynamic>,
          ),
        );
      }

      throw Exception('Invalid update gate pass error response format');
    } on DioException catch (e, stackTrace) {
      debugPrint('');
      debugPrint('==================================================');
      debugPrint('❌ UPDATE GATE PASS DIO ERROR');
      debugPrint('==================================================');
      debugPrint('Error Type      : ${e.type}');
      debugPrint('Error Message   : ${e.message}');
      debugPrint('Request URL     : ${e.requestOptions.uri}');
      debugPrint('Request Method  : ${e.requestOptions.method}');
      debugPrint('Gate Pass ID    : $id');
      debugPrint('Request Data    : ${e.requestOptions.data}');
      debugPrint('Response Code   : ${e.response?.statusCode}');
      debugPrint('Response Message: ${e.response?.statusMessage}');
      debugPrint('Response Data   : ${e.response?.data}');
      debugPrint('Stack Trace     : $stackTrace');
      debugPrint('==================================================');

      if (e.response?.data is Map<String, dynamic>) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(
            e.response!.data as Map<String, dynamic>,
          ),
        );
      }

      rethrow;
    } catch (error, stackTrace) {
      debugPrint('');
      debugPrint('==================================================');
      debugPrint('❌ UPDATE GATE PASS UNEXPECTED ERROR');
      debugPrint('==================================================');
      debugPrint('Gate Pass ID: $id');
      debugPrint('Error       : $error');
      debugPrint('Stack Trace : $stackTrace');
      debugPrint('==================================================');

      rethrow;
    }
  }
}
