class FetchSchoolEntity {
  final int? status;
  final bool? error;
  final String? message;
  final List<SchoolDetails>? schoolDetails;

  FetchSchoolEntity({
    this.status,
    this.error,
    this.message,
    this.schoolDetails,
  });
}

class SchoolDetails {
  final int? schoolId;
  final String? schoolName;
  final String? serialNo;
  final String? baseUrl;
  final String? dbName;
  final String? createdDate;
  final String? createdUser;
  final String? dbNameDecrypt;
  final String? appStoreVersion;
  final String? playStoreVersion;

  SchoolDetails({
    this.schoolId,
    this.schoolName,
    this.serialNo,
    this.baseUrl,
    this.dbName,
    this.createdDate,
    this.createdUser,
    this.dbNameDecrypt,
    this.appStoreVersion,
    this.playStoreVersion,
  });
}
