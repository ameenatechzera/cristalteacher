class StudentAttendanceResponseEntity {
  final int? status;
  final bool? error;
  final StudentAttendanceDataEntity? data;

  const StudentAttendanceResponseEntity({this.status, this.error, this.data});
}

class StudentAttendanceDataEntity {
  final StudentAttendanceMasterEntity? master;
  final List<StudentAttendanceDetailEntity>? details;

  const StudentAttendanceDataEntity({this.master, this.details});
}

class StudentAttendanceMasterEntity {
  final int? studentAttendanceMasterId;
  final String? date;
  final String? accYear;
  final String? narration;
  final int? standardId;
  final int? divisionId;
  final int? branchId;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;

  const StudentAttendanceMasterEntity({
    this.studentAttendanceMasterId,
    this.date,
    this.accYear,
    this.narration,
    this.standardId,
    this.divisionId,
    this.branchId,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
  });
}

class StudentAttendanceDetailEntity {
  final int? studentAttendanceDetailsId;
  final int? studentAttendanceMasterId;
  final String? admissionNo;
  final String? sessionName;
  final bool? status;
  final String? leaveTypeId;
  final String? remarks;
  final int? branchId;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;
  final String? name;

  const StudentAttendanceDetailEntity({
    this.studentAttendanceDetailsId,
    this.studentAttendanceMasterId,
    this.admissionNo,
    this.sessionName,
    this.status,
    this.leaveTypeId,
    this.remarks,
    this.branchId,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
    this.name,
  });
}
