class FetchTeacherTimetableParameter {
  final String employeeId;
  final String accYear;
  final int branchId;

  const FetchTeacherTimetableParameter({
    required this.employeeId,
    required this.accYear,
    required this.branchId,
  });

  Map<String, dynamic> toJson() {
    return {'employeeId': employeeId, 'accYear': accYear, 'branchId': branchId};
  }
}
