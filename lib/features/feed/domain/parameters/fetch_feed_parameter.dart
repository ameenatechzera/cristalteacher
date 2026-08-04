class FetchFeedParams {
  final String? accYear;
  final String? standardId;
  final String? divisionId;
  final String? fromDate;
  final String? toDate;

  const FetchFeedParams({
    this.accYear,
    this.standardId,
    this.divisionId,
    this.fromDate,
    this.toDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "AccYear": accYear,
      "StandardId": standardId,
      "DivisionId": divisionId,
      "FromDate": fromDate,
      "ToDate": toDate,
    };
  }
}
