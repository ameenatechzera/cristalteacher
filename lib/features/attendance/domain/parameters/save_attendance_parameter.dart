class SaveAttendanceRequest {
  final String date;
  final String accYear;
  final String narration;
  final int standardId;
  final int divisionId;
  final int branchId;
  final String createdUser;
  final List<StudentAttendanceDetailRequest> studentAttendanceDetails;

  SaveAttendanceRequest({
    required this.date,
    required this.accYear,
    required this.narration,
    required this.standardId,
    required this.divisionId,
    required this.branchId,
    required this.createdUser,
    required this.studentAttendanceDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "AccYear": accYear,
      "narration": narration,
      "StandardId": standardId,
      "DivisionId": divisionId,
      "branchId": branchId,
      "CreatedUser": createdUser,
      "StudentAttendanceDetails": studentAttendanceDetails
          .map((e) => e.toJson())
          .toList(),
    };
  }
}

class StudentAttendanceDetailRequest {
  final String admissionNo;
  final String sessionName;
  final dynamic status;
  final dynamic leaveTypeId;
  final dynamic remarks;

  StudentAttendanceDetailRequest({
    required this.admissionNo,
    required this.sessionName,
    required this.status,
    this.leaveTypeId,
    this.remarks,
  });

  Map<String, dynamic> toJson() {
    return {
      "AdmissionNo": admissionNo,
      "SessionName": sessionName,
      "Status": status,
      "leaveTypeId": leaveTypeId,
      "remarks": remarks,
    };
  }
}
