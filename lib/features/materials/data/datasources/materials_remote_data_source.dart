import 'dart:convert';
import 'dart:io';

import 'package:cristalteacher/core/errors/error_messege_model.dart';
import 'package:cristalteacher/core/errors/exceptions.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/network/api_endpoints.dart';
import 'package:cristalteacher/core/network/api_helper.dart';
import 'package:cristalteacher/features/materials/data/models/fetch_material_model.dart';
import 'package:cristalteacher/features/materials/domain/parameter/fetch_material_parameter.dart';
import 'package:cristalteacher/features/materials/domain/parameter/save_material_parameter.dart';
import 'package:cristalteacher/services/shared_preference_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class MaterialRemoteDataSource {
  Future<FetchMaterialModel> fetchMaterials(FetchMaterialParameter params);
  Future<MasterResponseModel> saveMaterial(SaveMaterialParameter params);
}

class MaterialRemoteDataSourceImpl implements MaterialRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<FetchMaterialModel> fetchMaterials(
    FetchMaterialParameter params,
  ) async {
    print('📘 Fetch Materials Called');
    print('FetchMaterialParameter: ${params.toJson()}');

    try {
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      final url = ApiConstants.getFetchMaterialPath(baseUrl);

      print("📘 URL : $url");

      final options = await ApiHelper.getAuthOptions(withToken: true);

      final response = await dio.post(
        url,
        data: params.toJson(),
        options: options,
      );

      print('📘 Status Code: ${response.statusCode}');
      print('📘 Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return FetchMaterialModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stackTrace) {
      print('❌ Exception in fetchMaterials: $e');
      print(stackTrace);
      rethrow;
    }
  }
  //   @override
  //   Future<MasterResponseModel> saveMaterial(SaveMaterialParameter params) async {
  //     print('📘 Save Material Called');

  //     try {
  //       /// Base URL
  //       final baseUrl = await SharedPreferenceHelper().getBaseUrl();

  //       if (baseUrl == null || baseUrl.isEmpty) {
  //         throw Exception("Base URL not set");
  //       }

  //       /// API URL
  //       final url = ApiConstants.saveMaterialPath(baseUrl);

  //       print("📘 URL => $url");

  //       /// Headers
  //       final options = await ApiHelper.getAuthOptions(withToken: true);

  //       /// FormData
  //       final formData = FormData.fromMap({
  //         "StaffId": params.staffId,
  //         "AccYear": params.accYear,
  //         "StandardId": params.standardId,
  //         "DivisionId": params.divisionId,
  //         "SubjectId": params.subjectId,
  //         "branchId": params.branchId,
  //         "CreatedUser": params.createdUser,
  //         "documentName": params.documentName,
  //         "notes": params.notes,
  //         "link": params.link,
  //         "favorite": params.favorite,

  //         "Material[]": await Future.wait(
  //           params.materials.map(
  //             (file) => MultipartFile.fromFile(
  //               file.path,
  //               filename: file.path.split('/').last,
  //             ),
  //           ),
  //         ),
  //       });

  //       final response = await dio.post(url, data: formData, options: options);

  //       print('📘 Status Code: ${response.statusCode}');
  //       print('📘 Response: ${response.data}');

  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         return MasterResponseModel.fromJson(response.data);
  //       } else {
  //         throw ServerException(
  //           errorMessageModel: ErrorMessageModel.fromJson(response.data),
  //         );
  //       }
  //     } catch (e, stackTrace) {
  //       print('❌ Exception in saveMaterial: $e');
  //       print(stackTrace);
  //       rethrow;
  //     }
  //   }
  // }
  @override
  Future<MasterResponseModel> saveMaterial(SaveMaterialParameter params) async {
    debugPrint('📘 Save Material Called');

    try {
      final String? baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.trim().isEmpty) {
        throw Exception('Base URL not set');
      }

      final String url = ApiConstants.saveMaterialPath(baseUrl);

      final Options options = await ApiHelper.getAuthOptions(withToken: true);

      /*
     * Do not manually assign:
     * Content-Type: multipart/form-data
     *
     * Dio must generate the multipart boundary.
     */
      options.contentType = null;
      options.headers?.remove('Content-Type');
      options.headers?.remove('content-type');

      final FormData formData = FormData();

      // Add normal text fields explicitly.
      formData.fields.addAll([
        MapEntry('StaffId', params.staffId.toString()),
        MapEntry('AccYear', params.accYear),
        MapEntry('StandardId', params.standardId.toString()),
        MapEntry('DivisionId', params.divisionId.toString()),
        MapEntry('SubjectId', params.subjectId.toString()),
        MapEntry('branchId', params.branchId.toString()),
        MapEntry('CreatedUser', params.createdUser),
        MapEntry('documentName', params.documentName),
        MapEntry('notes', params.notes),
        MapEntry('link', params.link),
        MapEntry('favorite', params.favorite ? 'true' : 'false'),
      ]);

      // Add every file separately using the backend field name.
      for (final File file in params.materials) {
        if (!await file.exists()) {
          throw Exception('Selected file does not exist: ${file.path}');
        }

        final int fileSize = await file.length();
        final double fileSizeMb = fileSize / (1024 * 1024);

        final String fileName = file.path.split(Platform.pathSeparator).last;

        debugPrint('📄 File name: $fileName');
        debugPrint('📄 File size: ${fileSizeMb.toStringAsFixed(2)} MB');

        formData.files.add(
          MapEntry(
            'Material[]',
            await MultipartFile.fromFile(file.path, filename: fileName),
          ),
        );
      }

      debugPrint('📘 URL: $url');
      debugPrint('📘 Text fields: ${formData.fields.length}');
      debugPrint('📘 Files: ${formData.files.length}');

      final Response<dynamic> response = await dio.post<dynamic>(
        url,
        data: formData,
        options: options,
        onSendProgress: (int sent, int total) {
          if (total > 0) {
            final double progress = sent / total * 100;

            debugPrint(
              '📤 Upload: ${progress.toStringAsFixed(1)}% '
              '($sent/$total bytes)',
            );
          }
        },
      );

      debugPrint('📘 Status Code: ${response.statusCode}');
      debugPrint('📘 Response: ${response.data}');

      if (response.data is! Map<String, dynamic>) {
        throw Exception('Invalid Save Material API response: ${response.data}');
      }

      return MasterResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (error, stackTrace) {
      final int? statusCode = error.response?.statusCode;
      final dynamic responseData = error.response?.data;

      debugPrint('❌ Save Material DioException');
      debugPrint('❌ Status code: $statusCode');
      debugPrint('❌ Response: $responseData');
      debugPrint('❌ Headers: ${error.response?.headers}');
      debugPrintStack(stackTrace: stackTrace);

      if (statusCode == 413) {
        throw Exception(
          'The server or web server rejected the upload because '
          'the complete request is too large (HTTP 413).',
        );
      }

      if (responseData is Map<String, dynamic>) {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(responseData),
        );
      }

      throw Exception(
        responseData?.toString() ?? error.message ?? 'Unable to save material',
      );
    } catch (error, stackTrace) {
      debugPrint('❌ Exception in saveMaterial: $error');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }
}
