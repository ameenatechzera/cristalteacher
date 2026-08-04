import 'dart:convert';

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
    print('📘 Params: ${params.toJson()}');

    try {
      /// Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// API URL
      final url = ApiConstants.getAllMaterialsPath(baseUrl);

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

  @override
  Future<MasterResponseModel> saveMaterial(SaveMaterialParameter params) async {
    print('📘 Save Material Called');

    try {
      /// Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// API URL
      final url = ApiConstants.saveMaterialPath(baseUrl);

      print("📘 URL => $url");

      /// Headers
      final options = await ApiHelper.getAuthOptions(withToken: true);

      /// FormData
      final formData = FormData.fromMap({
        "StaffId": params.staffId,
        "AccYear": params.accYear,
        "StandardId": params.standardId,
        "DivisionId": params.divisionId,
        "SubjectId": params.subjectId,
        "branchId": params.branchId,
        "CreatedUser": params.createdUser,
        "documentName": params.documentName,
        "notes": params.notes,
        "link": params.link,
        "favorite": params.favorite,

        "Material[]": await Future.wait(
          params.materials.map(
            (file) => MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        ),
      });

      final response = await dio.post(url, data: formData, options: options);

      print('📘 Status Code: ${response.statusCode}');
      print('📘 Response: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return MasterResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stackTrace) {
      print('❌ Exception in saveMaterial: $e');
      print(stackTrace);
      rethrow;
    }
  }
}
