class FetchWorkPlanDetailsParameter {
  final int branchId;
  final String? accYear;
  final int? workPlanId;
  final int? standardId;
  final int? divisionId;
  final String? fromDate;
  final String? toDate;

  const FetchWorkPlanDetailsParameter({
    required this.branchId,
    this.accYear,
    this.workPlanId,
    this.standardId,
    this.divisionId,
    this.fromDate,
    this.toDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'branchId': branchId,
      'accYear': accYear,
      'workPlanId': workPlanId,
      'standardId': standardId,
      'divisionId': divisionId,
      'fromDate': fromDate,
      'toDate': toDate,
    };
  }
}
