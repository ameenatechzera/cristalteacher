import 'package:cristalteacher/features/authentication/domain/entities/fetch_school_entity.dart';

class FetchSchoolResponseModel extends FetchSchoolEntity {
  FetchSchoolResponseModel({
    super.status,
    super.error,
    super.message,
    List<SchoolDetailsModel>? super.schoolDetails,
  });

  factory FetchSchoolResponseModel.fromJson(Map<String, dynamic> json) {
    return FetchSchoolResponseModel(
      status: json['status'] as int?,
      error: json['error'] as bool?,
      message: json['messages']?.toString(), // ⚠️ key is "messages"
      schoolDetails: json['school_details'] == null
          ? []
          : (json['school_details'] as List)
                .map(
                  (x) => SchoolDetailsModel.fromJson(x as Map<String, dynamic>),
                )
                .toList(),
    );
  }
}

class SchoolDetailsModel extends SchoolDetails {
  SchoolDetailsModel({
    super.schoolId,
    super.schoolName,
    super.serialNo,
    super.baseUrl,
    super.dbName,
    super.createdDate,
    super.createdUser,
    super.dbNameDecrypt,
    super.appStoreVersion,
    super.playStoreVersion,
  });

  factory SchoolDetailsModel.fromJson(Map<String, dynamic> json) {
    return SchoolDetailsModel(
      // ⚠️ IMPORTANT: key has space "schoolid "
      schoolId: json['schoolid '] as int?,

      schoolName: json['schoolName']?.toString(),
      serialNo: json['serialNo']?.toString(),
      baseUrl: json['baseUrl']?.toString(),
      dbName: json['dbName']?.toString(),

      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),

      dbNameDecrypt: json['dbNameDecrypt']?.toString(),
      appStoreVersion: json['AppStoreVersion']?.toString(),
      playStoreVersion: json['PlayStoreVersion']?.toString(),
    );
  }
}
