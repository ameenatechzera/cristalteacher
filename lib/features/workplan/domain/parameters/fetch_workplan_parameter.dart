class FetchWorkPlanParameter {
  final int branchId;
  final String? accYear;
  final String? fromDate;
  final String? toDate;
  final String status;
  final String currentDateTime;

  const FetchWorkPlanParameter({
    required this.branchId,
    this.accYear,
    this.fromDate,
    this.toDate,
    required this.status,
    required this.currentDateTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'branchId': branchId,
      'accYear': accYear,
      'fromDate': fromDate,
      'toDate': toDate,
      'status': status,
      'currentdatetime': currentDateTime,
    };
  }
}
