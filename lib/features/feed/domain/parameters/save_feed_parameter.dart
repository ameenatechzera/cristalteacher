class SaveFeedParameter {
  final String feedText;
  final String feedTarget;
  final List<FeedStandardParameter> standardId;
  final String userId;
  final int branchId;
  final String createdUser;
  final String accYear;
  final List<FeedMasterFileParameter> feedMasterFiles;

  SaveFeedParameter({
    required this.feedText,
    required this.feedTarget,
    required this.standardId,
    required this.userId,
    required this.branchId,
    required this.createdUser,
    required this.accYear,
    required this.feedMasterFiles,
  });

  Map<String, dynamic> toJson() {
    return {
      "feedText": feedText,
      "feedTarget": feedTarget,
      "StandardId": standardId.map((e) => e.toJson()).toList(),
      "userId": userId,
      "branchId": branchId,
      "CreatedUser": createdUser,
      "AccYear": accYear,
      "FeedMasterFiles": feedMasterFiles.map((e) => e.toJson()).toList(),
    };
  }
}

class FeedStandardParameter {
  final int standardId;
  final int divisionId;

  FeedStandardParameter({required this.standardId, required this.divisionId});

  Map<String, dynamic> toJson() {
    return {"StandardId": standardId, "DivisionId": divisionId};
  }
}

class FeedMasterFileParameter {
  final String file;

  FeedMasterFileParameter({required this.file});

  Map<String, dynamic> toJson() {
    return {"File": file};
  }
}
