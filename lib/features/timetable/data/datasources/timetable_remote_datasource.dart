import 'package:cristalteacher/core/errors/error_messege_model.dart';
import 'package:cristalteacher/core/errors/exceptions.dart';
import 'package:cristalteacher/core/network/api_endpoints.dart';
import 'package:cristalteacher/core/network/api_helper.dart';
import 'package:cristalteacher/features/timetable/data/models/teacher_timetable_model.dart';
import 'package:cristalteacher/features/timetable/domain/parameters/fetch_teacher_timetable_parameter.dart';
import 'package:cristalteacher/services/shared_preference_helper.dart';
import 'package:dio/dio.dart';

abstract class TeacherTimetableRemoteDataSource {
  Future<TeacherTimetableResponseModel> fetchTeacherTimetable(
    FetchTeacherTimetableParameter request,
  );
}

class TeacherTimetableRemoteDataSourceImpl
    implements TeacherTimetableRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<TeacherTimetableResponseModel> fetchTeacherTimetable(
    FetchTeacherTimetableParameter request,
  ) async {
    print('');
    print('==============================================');
    print('📅 FETCH TEACHER TIMETABLE API START');
    print('==============================================');

    try {
      final pref = SharedPreferenceHelper();

      final baseUrl = await pref.getBaseUrl();
      final token = await pref.getToken();
      final dbName = await pref.getDatabaseName();

      print('📌 Shared Preference Values');
      print('----------------------------------------------');
      print('Base URL      : $baseUrl');
      print('Token         : $token');
      print('Database Name : $dbName');
      print('----------------------------------------------');

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception('Base URL not set');
      }

      if (token == null || token.isEmpty) {
        throw Exception('Token missing! Please login again.');
      }

      final url = ApiConstants.getTeacherTimetablePath(baseUrl);

      print('📌 API URL');
      print('----------------------------------------------');
      print(url);
      print('----------------------------------------------');

      final options = await ApiHelper.getAuthOptions(withToken: true);

      print('📌 Request Headers');
      print('----------------------------------------------');
      options.headers?.forEach((key, value) {
        print('$key : $value');
      });
      print('----------------------------------------------');

      print('📌 Request Body');
      print('----------------------------------------------');
      print(request.toJson());
      print('----------------------------------------------');

      final response = await dio.post(
        url,
        data: request.toJson(),
        options: options,
      );

      print('📌 Response');
      print('----------------------------------------------');
      print('HTTP Status : ${response.statusCode}');
      print('Response    : ${response.data}');
      print('----------------------------------------------');

      if (response.data is Map<String, dynamic>) {
        final json = response.data as Map<String, dynamic>;

        print('📌 Parsed Response');
        print('----------------------------------------------');
        print('status  : ${json['status']}');
        print('error   : ${json['error']}');
        print('message : ${json['message']}');

        if (json['data'] is List) {
          final data = json['data'] as List;

          print('Data Count : ${data.length}');

          if (data.isNotEmpty) {
            print('First Timetable Item');
            print(data.first);
          }
        }

        print('----------------------------------------------');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is! Map<String, dynamic>) {
          throw Exception('Invalid timetable response format');
        }

        final model = TeacherTimetableResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );

        print('📅 Timetable Count: ${model.data?.length ?? 0}');
        print('==============================================');
        print('📅 FETCH TEACHER TIMETABLE API END');
        print('==============================================');

        return model;
      }

      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(
          response.data as Map<String, dynamic>,
        ),
      );
    } on DioException catch (e, stackTrace) {
      print('');
      print('==============================================');
      print('❌ FETCH TEACHER TIMETABLE DIO EXCEPTION');
      print('==============================================');
      print('Message  : ${e.message}');
      print('Status   : ${e.response?.statusCode}');
      print('Response : ${e.response?.data}');
      print('URL      : ${e.requestOptions.uri}');
      print('Method   : ${e.requestOptions.method}');
      print('Headers  : ${e.requestOptions.headers}');
      print('Body     : ${e.requestOptions.data}');
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
      print('❌ FETCH TEACHER TIMETABLE GENERAL EXCEPTION');
      print('==============================================');
      print(e);
      print(stackTrace);
      print('==============================================');

      rethrow;
    }
  }
}
