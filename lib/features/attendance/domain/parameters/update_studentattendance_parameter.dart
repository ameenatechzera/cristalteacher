class UpdateStudentAttendanceParameter {
  final String date;
  final String accYear;
  final String narration;
  final int standardId;
  final int divisionId;
  final int branchId;
  final String modifiedUser;
  final List<StudentAttendanceDetailParameter> studentAttendanceDetails;

  UpdateStudentAttendanceParameter({
    required this.date,
    required this.accYear,
    required this.narration,
    required this.standardId,
    required this.divisionId,
    required this.branchId,
    required this.modifiedUser,
    required this.studentAttendanceDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'AccYear': accYear,
      'narration': narration,
      'StandardId': standardId,
      'DivisionId': divisionId,
      'branchId': branchId,
      'ModifiedUser': modifiedUser,
      'StudentAttendanceDetails': studentAttendanceDetails
          .map((e) => e.toJson())
          .toList(),
    };
  }
}

class StudentAttendanceDetailParameter {
  final String admissionNo;
  final String sessionName;
  final String status;
  final String leaveTypeId;
  final String remarks;

  StudentAttendanceDetailParameter({
    required this.admissionNo,
    required this.sessionName,
    required this.status,
    required this.leaveTypeId,
    required this.remarks,
  });

  Map<String, dynamic> toJson() {
    return {
      'AdmissionNo': admissionNo,
      'SessionName': sessionName,
      'Status': status,
      'leaveTypeId': leaveTypeId,
      'remarks': remarks,
    };
  }
}
