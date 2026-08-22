import 'package:cristalteacher/features/attendance/domain/entities/studentattendance_response_enttiy.dart';

class StudentAttendanceResponseModel extends StudentAttendanceResponseEntity {
  const StudentAttendanceResponseModel({
    super.status,
    super.error,
    StudentAttendanceDataModel? super.data,
  });

  factory StudentAttendanceResponseModel.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceResponseModel(
      status: _toInt(json['status']),
      error: _toBool(json['error']),
      data: json['data'] is Map
          ? StudentAttendanceDataModel.fromJson(
              Map<String, dynamic>.from(json['data'] as Map),
            )
          : null,
    );
  }
}

class StudentAttendanceDataModel extends StudentAttendanceDataEntity {
  const StudentAttendanceDataModel({
    StudentAttendanceMasterModel? super.master,
    List<StudentAttendanceDetailModel>? super.details,
  });

  factory StudentAttendanceDataModel.fromJson(Map<String, dynamic> json) {
    final rawDetails = json['details'];

    return StudentAttendanceDataModel(
      master: json['master'] is Map
          ? StudentAttendanceMasterModel.fromJson(
              Map<String, dynamic>.from(json['master'] as Map),
            )
          : null,
      details: rawDetails is List
          ? rawDetails
                .whereType<Map>()
                .map(
                  (item) => StudentAttendanceDetailModel.fromJson(
                    Map<String, dynamic>.from(item),
                  ),
                )
                .toList()
          : <StudentAttendanceDetailModel>[],
    );
  }
}

class StudentAttendanceMasterModel extends StudentAttendanceMasterEntity {
  const StudentAttendanceMasterModel({
    super.studentAttendanceMasterId,
    super.date,
    super.accYear,
    super.narration,
    super.standardId,
    super.divisionId,
    super.branchId,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
  });

  factory StudentAttendanceMasterModel.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceMasterModel(
      studentAttendanceMasterId: _toInt(json['StudentattendanceMasterId']),
      date: json['date']?.toString(),
      accYear: json['AccYear']?.toString(),
      narration: json['narration']?.toString(),
      standardId: _toInt(json['StandardId']),
      divisionId: _toInt(json['DivisionId']),
      branchId: _toInt(json['branchId']),
      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
      modifiedDate: json['ModifiedDate']?.toString(),
      modifiedUser: json['ModifiedUser']?.toString(),
    );
  }
}

class StudentAttendanceDetailModel extends StudentAttendanceDetailEntity {
  const StudentAttendanceDetailModel({
    super.studentAttendanceDetailsId,
    super.studentAttendanceMasterId,
    super.admissionNo,
    super.sessionName,
    super.status,
    super.leaveTypeId,
    super.remarks,
    super.branchId,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
    super.name,
  });

  factory StudentAttendanceDetailModel.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceDetailModel(
      studentAttendanceDetailsId: _toInt(json['StudentattendanceDetailsId']),
      studentAttendanceMasterId: _toInt(json['StudentattendanceMasterId']),
      admissionNo: json['AdmissionNo']?.toString(),
      sessionName: json['SessionName']?.toString(),
      status: _toBool(json['Status']),
      leaveTypeId: json['leaveTypeId']?.toString(),
      remarks: json['remarks']?.toString(),
      branchId: _toInt(json['branchId']),
      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
      modifiedDate: json['ModifiedDate']?.toString(),
      modifiedUser: json['ModifiedUser']?.toString(),
      name: json['Name']?.toString(),
    );
  }
}

int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString());
}

bool? _toBool(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is num) return value != 0;

  switch (value.toString().trim().toLowerCase()) {
    case 'true':
    case '1':
      return true;
    case 'false':
    case '0':
      return false;
    default:
      return null;
  }
}
