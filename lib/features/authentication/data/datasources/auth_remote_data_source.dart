import 'dart:convert';

import 'package:cristalteacher/core/errors/error_messege_model.dart';
import 'package:cristalteacher/core/errors/exceptions.dart';
import 'package:cristalteacher/core/network/api_endpoints.dart';
import 'package:cristalteacher/core/network/api_helper.dart';
import 'package:cristalteacher/features/authentication/data/models/class_details_model.dart';
import 'package:cristalteacher/features/authentication/data/models/fetch_accyear_model.dart';
import 'package:cristalteacher/features/authentication/data/models/fetch_branch_model.dart';
import 'package:cristalteacher/features/authentication/data/models/fetch_school_model.dart';
import 'package:cristalteacher/features/authentication/data/models/login_model.dart';
import 'package:cristalteacher/features/authentication/domain/entities/fetch_branch_entity.dart';
import 'package:cristalteacher/features/authentication/domain/entities/fetch_school_entity.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_school_parameter.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_tutorshipclass_parameter.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/login_parameter.dart';
import 'package:cristalteacher/services/shared_preference_helper.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequest params);
  Future<FetchSchoolEntity> fetchSchools(FetchSchoolRequest request);
  Future<GetBranchEntity> getBranchDetails();
  Future<FetchTutorshipClassResponseModel> fetchTutorshipClass(
    FetchTutorshipClassRequest request,
  );
  Future<FetchAccYearModel> fetchAccYear();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<LoginResponseModel> login(LoginRequest params) async {
    print('📘 Login Called');
    print('📘 Params: ${params.toJson()}');

    try {
      /// Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      print('📘 Base Url => $baseUrl');

      /// API URL
      final url = ApiConstants.getLoginPath(baseUrl);

      print('📘 URL => $url');

      /// Without Token for Login API
      final options = await ApiHelper.getAuthOptions(withToken: false);

      final response = await dio.post(
        url,
        data: params.toJson(),
        options: options,
      );

      print('📘 Status Code: ${response.statusCode}');
      print('📘 Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in Login: $e');
      print(stacktrace);
      rethrow;
    }
  }

  @override
  Future<FetchSchoolResponseModel> fetchSchools(
    FetchSchoolRequest request,
  ) async {
    print('📘 Fetch School Called');
    print('📘 Params: ${request.toJson()}');

    try {
      // /// Base URL
      // final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      // if (baseUrl == null || baseUrl.isEmpty) {
      //   throw Exception("Base URL not set");
      // }

      // print('📘 Base Url => $baseUrl');

      /// API URL
      final url = "https://online.cristaledu.com/Api/public/api/get-school";

      print('📘 URL => $url');

      /// Without Token

      final response = await dio.post(
        url,
        data: request.toJson(),
        options: Options(
          contentType: "application/json",
          headers: {"Accept": "application/json"},
        ),
      );

      print('📘 Status Code: ${response.statusCode}');
      print('📘 Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return FetchSchoolResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in Fetch School: $e');
      print(stacktrace);
      rethrow;
    }
  }

  @override
  Future<GetBranchResponseModel> getBranchDetails() async {
    print('📘 Get Branch Called');

    try {
      /// Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      print('📘 Base Url => $baseUrl');

      /// API URL
      final url = "${baseUrl}app/branch-byid/1";

      print('📘 URL => $url');

      /// With Token
      final options = await ApiHelper.getAuthOptions();

      final response = await dio.get(url, options: options);

      print('📘 Status Code: ${response.statusCode}');
      print('📘 Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return GetBranchResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in Get Branch: $e');
      print(stacktrace);
      rethrow;
    }
  }

  @override
  Future<FetchTutorshipClassResponseModel> fetchTutorshipClass(
    FetchTutorshipClassRequest request,
  ) async {
    print('📘 Fetch Tutorship Class Called');
    print('📘 Params: ${request.toJson()}');

    try {
      /// Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      print('📘 Base Url => $baseUrl');

      /// API URL
      final url =
          "${baseUrl}std-div-from-accyear"; // Change if your endpoint is different

      print('📘 URL => $url');

      /// Authorization Header
      final options = await ApiHelper.getAuthOptions(withToken: true);
      print("Headers: ${options.headers}");

      /// API Call
      final response = await dio.post(
        url,
        data: request.toJson(),
        options: options,
      );

      print('📘 Status Code: ${response.statusCode}');
      print('📘 Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return FetchTutorshipClassResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in Fetch Tutorship Class: $e');
      print(stacktrace);
      rethrow;
    }
  }

  @override
  Future<FetchAccYearModel> fetchAccYear() async {
    print('📘 Fetch Academic Year Called');

    try {
      /// Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// API URL
      final url = ApiConstants.getAccYearsServerPath(baseUrl);

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
        return FetchAccYearModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in fetchAccYear: $e');
      print(stacktrace);
      rethrow;
    }
  }
}
