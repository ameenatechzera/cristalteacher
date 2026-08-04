class FetchMaterialParameter {
  final int branchId;
  final String fromDate;
  final String toDate;

  FetchMaterialParameter({
    required this.branchId,
    required this.fromDate,
    required this.toDate,
  });

  Map<String, dynamic> toJson() {
    return {"branchId": branchId, "fromDate": fromDate, "toDate": toDate};
  }
}
