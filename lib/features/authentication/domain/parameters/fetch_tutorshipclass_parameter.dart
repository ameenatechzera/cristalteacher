class FetchTutorshipClassRequest {
  final String? accyear;
  final int? employeeId;
  final int? userId;

  FetchTutorshipClassRequest({this.accyear, this.employeeId, this.userId});

  Map<String, dynamic> toJson() {
    return {"accyear": accyear, "employeeId": employeeId, "userId": userId};
  }
}
