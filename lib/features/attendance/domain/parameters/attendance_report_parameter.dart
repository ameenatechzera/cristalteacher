class AttendanceReportParameter {
  final int branchId;
  final String fromDate;
  final String toDate;
  final int userId;
  final String accYear;

  AttendanceReportParameter({
    required this.branchId,
    required this.fromDate,
    required this.toDate,
    required this.userId,
    required this.accYear,
  });

  Map<String, dynamic> toJson() {
    return {
      'branchId': branchId,
      'fromDate': fromDate,
      'toDate': toDate,
      'userId': userId,
      'accYear': accYear,
    };
  }
}
