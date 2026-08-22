import 'dart:io';

import 'package:cristalteacher/core/errors/error_messege_model.dart';
import 'package:cristalteacher/core/errors/exceptions.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/network/api_endpoints.dart';
import 'package:cristalteacher/core/network/api_helper.dart';
import 'package:cristalteacher/features/workplan/data/models/workplan_repsonse_model.dart';
import 'package:cristalteacher/features/workplan/data/models/workplandetails_response_model.dart';
import 'package:cristalteacher/features/workplan/domain/parameters/fetch_workplan_parameter.dart';
import 'package:cristalteacher/features/workplan/domain/parameters/fetch_workplandetails_parameter.dart';
import 'package:cristalteacher/features/workplan/domain/parameters/save_workplan_parameter.dart';
import 'package:cristalteacher/services/shared_preference_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class WorkPlanRemoteDataSource {
  Future<WorkPlanResponseModel> fetchWorkPlans(FetchWorkPlanParameter request);
  Future<WorkPlanDetailsResponseModel> fetchWorkPlanDetails(
    FetchWorkPlanDetailsParameter request,
  );
  Future<MasterResponseModel> saveWorkPlan(SaveWorkPlanParameter request);
}

class WorkPlanRemoteDataSourceImpl implements WorkPlanRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<WorkPlanResponseModel> fetchWorkPlans(
    FetchWorkPlanParameter request,
  ) async {
    try {
      final preference = SharedPreferenceHelper();

      final baseUrl = await preference.getBaseUrl();
      final token = await preference.getToken();

      if (baseUrl == null || baseUrl.trim().isEmpty) {
        throw Exception('Base URL not set');
      }

      if (token == null || token.trim().isEmpty) {
        throw Exception('Token missing! Please login again.');
      }

      final url = ApiConstants.getWorkPlanPath(baseUrl);

      final options = await ApiHelper.getAuthOptions(withToken: true);

      final response = await dio.post<dynamic>(
        url,
        data: request.toJson(),
        options: options,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is! Map<String, dynamic>) {
          throw Exception('Invalid work plan response format');
        }

        return WorkPlanResponseModel.fromJson(
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

      throw Exception('Invalid work plan error response format');
    } on DioException catch (error) {
      final responseData = error.response?.data;

      if (responseData is Map<String, dynamic>) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(responseData),
        );
      }

      throw Exception(error.message ?? 'Unable to fetch work plans');
    }
  }

  @override
  Future<WorkPlanDetailsResponseModel> fetchWorkPlanDetails(
    FetchWorkPlanDetailsParameter request,
  ) async {
    try {
      final preference = SharedPreferenceHelper();

      final baseUrl = await preference.getBaseUrl();
      final token = await preference.getToken();

      if (baseUrl == null || baseUrl.trim().isEmpty) {
        throw Exception('Base URL not set');
      }

      if (token == null || token.trim().isEmpty) {
        throw Exception('Token missing! Please login again.');
      }

      final url = ApiConstants.getWorkPlanDetailsPath(baseUrl);

      final options = await ApiHelper.getAuthOptions(withToken: true);

      final response = await dio.post<dynamic>(
        url,
        data: request.toJson(),
        options: options,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is! Map<String, dynamic>) {
          throw Exception('Invalid work plan details response format');
        }

        return WorkPlanDetailsResponseModel.fromJson(
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

      throw Exception('Invalid work plan details error response format');
    } on DioException catch (error) {
      final responseData = error.response?.data;

      if (responseData is Map<String, dynamic>) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(responseData),
        );
      }

      throw Exception(error.message ?? 'Unable to fetch work plan details');
    }
  }

  @override
  Future<MasterResponseModel> saveWorkPlan(
    SaveWorkPlanParameter request,
  ) async {
    try {
      final preference = SharedPreferenceHelper();

      final baseUrl = await preference.getBaseUrl();
      final token = await preference.getToken();

      if (baseUrl == null || baseUrl.trim().isEmpty) {
        throw Exception('Base URL not set');
      }

      if (token == null || token.trim().isEmpty) {
        throw Exception('Token missing! Please login again.');
      }

      final url = ApiConstants.saveWorkPlanPath(baseUrl);

      final options = await ApiHelper.getAuthOptions(withToken: true);

      // Let Dio automatically set multipart/form-data with boundary.
      options.contentType = null;
      options.headers?.remove('Content-Type');
      options.headers?.remove('content-type');

      final FormData formData = FormData.fromMap(request.toJson());

      if (request.attachment != null) {
        final File file = request.attachment!;

        if (!await file.exists()) {
          throw Exception('Selected attachment does not exist: ${file.path}');
        }

        final String fileName = file.path.split(Platform.pathSeparator).last;

        formData.files.add(
          MapEntry(
            'Attachments',
            await MultipartFile.fromFile(file.path, filename: fileName),
          ),
        );
      }

      debugPrint('');
      debugPrint('==============================================');
      debugPrint('📤 SAVE WORK PLAN API REQUEST');
      debugPrint('==============================================');
      debugPrint('URL             : $url');
      debugPrint('Master ID       : ${request.masterId}');
      debugPrint('Employee ID     : ${request.employeeId}');
      debugPrint('Standard ID     : ${request.standardId}');
      debugPrint('Division ID     : ${request.divisionId}');
      debugPrint('Subject ID      : ${request.subjectId}');
      debugPrint('Duration        : ${request.duration}');
      debugPrint('Periods         : ${request.periods}');
      debugPrint('Topic           : ${request.topic}');
      debugPrint('Activity        : ${request.activity}');
      debugPrint('Tools           : ${request.tools}');
      debugPrint('Remarks         : ${request.remarks}');
      debugPrint('Branch ID       : ${request.branchId}');
      debugPrint('Created User    : ${request.createdUser}');
      debugPrint('Attachment      : ${request.attachment?.path}');
      debugPrint('Form fields     : ${formData.fields}');
      debugPrint('Attachment count: ${formData.files.length}');
      debugPrint('==============================================');

      final response = await dio.post<dynamic>(
        url,
        data: formData,
        options: options,
        onSendProgress: (sent, total) {
          if (total <= 0) return;

          final progress = (sent / total) * 100;

          debugPrint(
            '📤 Upload: ${progress.toStringAsFixed(1)}% '
            '($sent/$total bytes)',
          );
        },
      );

      debugPrint('');
      debugPrint('==============================================');
      debugPrint('📥 SAVE WORK PLAN API RESPONSE');
      debugPrint('==============================================');
      debugPrint('Status Code : ${response.statusCode}');
      debugPrint('Response    : ${response.data}');
      debugPrint('==============================================');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is! Map<String, dynamic>) {
          throw Exception('Invalid save work plan response format');
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

      throw Exception('Unable to save work plan');
    } on DioException catch (error, stackTrace) {
      final responseData = error.response?.data;

      debugPrint('');
      debugPrint('==============================================');
      debugPrint('❌ SAVE WORK PLAN DIO EXCEPTION');
      debugPrint('==============================================');
      debugPrint('Status Code : ${error.response?.statusCode}');
      debugPrint('Response    : $responseData');
      debugPrint('Message     : ${error.message}');
      debugPrintStack(stackTrace: stackTrace);
      debugPrint('==============================================');

      if (responseData is Map<String, dynamic>) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(responseData),
        );
      }

      throw Exception(error.message ?? 'Unable to save work plan');
    } catch (error, stackTrace) {
      debugPrint('');
      debugPrint('==============================================');
      debugPrint('❌ SAVE WORK PLAN EXCEPTION');
      debugPrint('==============================================');
      debugPrint('Error: $error');
      debugPrintStack(stackTrace: stackTrace);
      debugPrint('==============================================');

      rethrow;
    }
  }
}
