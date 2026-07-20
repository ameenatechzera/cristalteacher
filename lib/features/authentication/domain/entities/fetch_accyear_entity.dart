class FetchAccYearEntity {
  final int? status;
  final bool? error;
  final List<AccYearEntity>? data;

  const FetchAccYearEntity({this.status, this.error, this.data});
}

class AccYearEntity {
  final int? accYearId;
  final String? accYear;
  final String? fromDate;
  final String? toDate;
  final bool? status;
  final int? branchId;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;

  const AccYearEntity({
    this.accYearId,
    this.accYear,
    this.fromDate,
    this.toDate,
    this.status,
    this.branchId,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
  });
}
