class FetchSchoolRequest {
  final String? slno;

  FetchSchoolRequest({this.slno});

  Map<String, dynamic> toJson() {
    return {"slno": slno};
  }
}
