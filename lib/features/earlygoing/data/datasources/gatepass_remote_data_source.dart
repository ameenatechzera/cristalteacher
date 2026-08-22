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

      final response = await dio.post(
        url,
        data: request.toJson(),
        options: options,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is! Map<String, dynamic>) {
          throw Exception('Invalid gate pass response format');
        }

        return GatePassResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      }

      if (response.data is Map<String, dynamic>) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(
            response.data as Map<String, dynamic>,
          ),
        );
      }

      throw Exception('Invalid gate pass error response format');
    } on DioException catch (e) {
      if (e.response?.data is Map<String, dynamic>) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(
            e.response!.data as Map<String, dynamic>,
          ),
        );
      }

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
      final response = await dio.post(
        url,
        data: request.toJson(),
        options: options,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is! Map<String, dynamic>) {
          throw Exception('Invalid update gate pass response format');
        }

        return MasterResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      }

      if (response.data is Map<String, dynamic>) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(
            response.data as Map<String, dynamic>,
          ),
        );
      }
      throw Exception('Invalid update gate pass error response format');
    } on DioException catch (e) {
      if (e.response?.data is Map<String, dynamic>) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(
            e.response!.data as Map<String, dynamic>,
          ),
        );
      }

      rethrow;
    }
  }
}
