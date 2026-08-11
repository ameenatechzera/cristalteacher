class AttendanceReportEntity {
  final int? status;
  final bool? error;
  final String? message;
  final List<AttendanceReportData>? data;

  const AttendanceReportEntity({
    this.status,
    this.error,
    this.message,
    this.data,
  });
}

class AttendanceReportData {
  final int? studentattendanceMasterId;
  final String? date;
  final String? accYear;
  final String? narration;
  final String? standardId;
  final String? standard;
  final String? divisionId;
  final String? division;
  final int? branchId;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;

  const AttendanceReportData({
    this.studentattendanceMasterId,
    this.date,
    this.accYear,
    this.narration,
    this.standardId,
    this.standard,
    this.divisionId,
    this.division,
    this.branchId,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
  });
}
