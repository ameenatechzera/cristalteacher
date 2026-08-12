import 'dart:convert';
import 'dart:io';

import 'package:cristalteacher/core/errors/error_messege_model.dart';
import 'package:cristalteacher/core/errors/exceptions.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/network/api_endpoints.dart';
import 'package:cristalteacher/core/network/api_helper.dart';
import 'package:cristalteacher/features/feed/data/models/fetch_feed_model.dart';
import 'package:cristalteacher/features/feed/domain/parameters/fetch_feed_parameter.dart';
import 'package:cristalteacher/features/feed/domain/parameters/save_feed_parameter.dart';
import 'package:cristalteacher/services/shared_preference_helper.dart';
import 'package:dio/dio.dart';

abstract class FeedRemoteDataSource {
  Future<FetchFeedModel> fetchFeed(FetchFeedParams params);
  Future<MasterResponseModel> saveFeed(SaveFeedParameter params);
  Future<MasterResponseModel> deleteFeed(int feedId);
}

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<FetchFeedModel> fetchFeed(FetchFeedParams params) async {
    print('📘 Fetch Feed Called');
    print('📘 Params: ${params.toJson()}');

    try {
      /// Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// API URL
      final url = ApiConstants.getFeedReportPath(baseUrl);

      print("📘 URL => $url");

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
        return FetchFeedModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in fetchFeed: $e');
      print(stacktrace);
      rethrow;
    }
  }

  @override
  Future<MasterResponseModel> saveFeed(SaveFeedParameter params) async {
    print('📘 Save Feed Called');
    print('📘 Params: ${params.toJson()}');

    try {
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      final url = ApiConstants.getSaveFeedPath(baseUrl);

      print("📘 URL => $url");

      final options = await ApiHelper.getAuthOptions(withToken: true);

      // ============================================================
      // CREATE FORM DATA
      // ============================================================

      final FormData formData = FormData();

      // ------------------------------------------------------------
      // NORMAL FIELDS
      // ------------------------------------------------------------

      formData.fields.add(MapEntry('feedText', params.feedText));

      formData.fields.add(MapEntry('feedTarget', params.feedTarget));

      formData.fields.add(MapEntry('userId', params.userId));

      formData.fields.add(MapEntry('branchId', params.branchId.toString()));

      formData.fields.add(MapEntry('CreatedUser', params.createdUser));

      formData.fields.add(MapEntry('AccYear', params.accYear.toString()));

      // ------------------------------------------------------------
      // STANDARD ID
      // ------------------------------------------------------------

      final String standardIdJson = jsonEncode(
        params.standardId.map((e) => e.toJson()).toList(),
      );

      formData.fields.add(MapEntry('StandardId', standardIdJson));

      // ============================================================
      // SINGLE FILE
      // ============================================================

      if (params.feedMasterFiles.isNotEmpty) {
        final String filePath = params.feedMasterFiles.first.file;

        final File file = File(filePath);

        if (!await file.exists()) {
          throw Exception('Selected file does not exist: $filePath');
        }

        final String fileName = filePath.split(Platform.pathSeparator).last;

        final int fileSize = await file.length();

        print('==========================================');
        print('📎 ADDING FILE');
        print('📎 Parameter: FeedMasterFiles');
        print('📎 File name: $fileName');
        print('📎 File path: $filePath');
        print('📎 File size: $fileSize bytes');
        print('==========================================');

        final MultipartFile multipartFile = await MultipartFile.fromFile(
          filePath,
          filename: fileName,
        );

        // IMPORTANT:
        // Backend expects SINGLE file.
        formData.files.add(MapEntry('FeedMasterFiles', multipartFile));
      }

      // ============================================================
      // DEBUG
      // ============================================================

      print('==========================================');
      print('📘 MULTIPART SAVE FEED REQUEST');
      print('📘 URL: $url');
      print('📘 feedText: ${params.feedText}');
      print('📘 feedTarget: ${params.feedTarget}');
      print('📘 userId: ${params.userId}');
      print('📘 branchId: ${params.branchId}');
      print('📘 CreatedUser: ${params.createdUser}');
      print('📘 AccYear: ${params.accYear}');
      print('📘 StandardId: $standardIdJson');
      print('📘 File attached: ${params.feedMasterFiles.isNotEmpty}');
      print('==========================================');

      // ============================================================
      // API CALL
      // ============================================================

      final response = await dio.post(url, data: formData, options: options);

      print('==========================================');
      print('📘 SAVE FEED RESPONSE');
      print('📘 Status Code: ${response.statusCode}');
      print('📘 Response: ${response.data}');
      print('==========================================');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return MasterResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in saveFeed: $e');
      print(stacktrace);

      if (e is DioException) {
        print('==========================================');
        print('❌ DIO ERROR');
        print('❌ Status Code: ${e.response?.statusCode}');
        print('❌ Response Data: ${e.response?.data}');
        print('❌ Response Headers: ${e.response?.headers}');
        print('==========================================');
      }

      rethrow;
    }
  }

  @override
  Future<MasterResponseModel> deleteFeed(int feedId) async {
    print('📘 Delete Feed Called');
    print('📘 Feed ID: $feedId');

    try {
      /// Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// API URL
      final url = '${ApiConstants.getDeleteFeedPath(baseUrl)}$feedId';

      print("📘 URL => $url");

      /// Headers
      final options = await ApiHelper.getAuthOptions(withToken: true);

      /// API Call
      final response = await dio.get(
        url,
        data: {"feedId": feedId},
        options: options,
      );

      print('📘 Status Code: ${response.statusCode}');
      print('📘 Response: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return MasterResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in deleteFeed: $e');
      print(stacktrace);
      rethrow;
    }
  }
}
