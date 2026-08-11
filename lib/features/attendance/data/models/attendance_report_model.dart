import 'package:cristalteacher/features/attendance/domain/entities/attendance_report_entity.dart';

class AttendanceReportResponseModel extends AttendanceReportEntity {
  AttendanceReportResponseModel({
    super.status,
    super.error,
    super.message,
    List<AttendanceReportModel>? super.data,
  });

  factory AttendanceReportResponseModel.fromJson(Map<String, dynamic> json) {
    return AttendanceReportResponseModel(
      status: json['status'] as int?,
      error: json['error'] as bool?,
      message: json['message']?.toString(),
      data: (json['data'] as List?)
          ?.map(
            (e) => AttendanceReportModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class AttendanceReportModel extends AttendanceReportData {
  AttendanceReportModel({
    super.studentattendanceMasterId,
    super.date,
    super.accYear,
    super.narration,
    super.standardId,
    super.standard,
    super.divisionId,
    super.division,
    super.branchId,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
  });

  factory AttendanceReportModel.fromJson(Map<String, dynamic> json) {
    return AttendanceReportModel(
      studentattendanceMasterId: json['StudentattendanceMasterId'] as int?,
      date: json['date']?.toString(),
      accYear: json['AccYear']?.toString(),
      narration: json['narration']?.toString(),
      standardId: json['StandardId']?.toString(),
      standard: json['Standard']?.toString(),
      divisionId: json['DivisionId']?.toString(),
      division: json['Division']?.toString(),
      branchId: json['branchId'] as int?,
      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
      modifiedDate: json['ModifiedDate']?.toString(),
      modifiedUser: json['ModifiedUser']?.toString(),
    );
  }
}
