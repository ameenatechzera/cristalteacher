class FetchGatePassParameter {
  final String accYear;
  final int branchId;
  final String? employeeId;
  final String fromDate;
  final String status;
  final String toDate;

  const FetchGatePassParameter({
    required this.accYear,
    required this.branchId,
    this.employeeId,
    required this.fromDate,
    required this.status,
    required this.toDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'accYear': accYear,
      'branchId': branchId,
      'employeeId': employeeId,
      'fromDate': fromDate,
      'status': status,
      'toDate': toDate,
    };
  }
}
