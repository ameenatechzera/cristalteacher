class WorkPlanResponseEntity {
  final int? status;
  final bool? error;
  final String? message;
  final List<WorkPlanData>? data;

  const WorkPlanResponseEntity({
    this.status,
    this.error,
    this.message,
    this.data,
  });
}

class WorkPlanData {
  final int? id;
  final String? accYear;
  final String? weekName;
  final String? fromDate;
  final String? toDate;
  final String? cutoffFromDate;
  final String? cutoffToDate;
  final String? status;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;
  final int? branchId;

  const WorkPlanData({
    this.id,
    this.accYear,
    this.weekName,
    this.fromDate,
    this.toDate,
    this.cutoffFromDate,
    this.cutoffToDate,
    this.status,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
    this.branchId,
  });
}
