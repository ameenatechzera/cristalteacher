class FetchFeedEntity {
  final int? status;
  final bool? error;
  final List<FeedEntity>? data;
  final String? message;

  const FetchFeedEntity({this.status, this.error, this.data, this.message});
}

class FeedEntity {
  final int? feedId;
  final String? feedText;
  final String? feedTarget;
  final List<FeedStandardEntity>? standardId;
  final String? userId;
  final int? branchId;
  final String? accYear;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;
  final List<FeedFileEntity>? files;
  final String? createdDateFormatted;
  final String? createdTime;
  final String? modifiedDateFormatted;
  final String? modifiedTime;

  const FeedEntity({
    this.feedId,
    this.feedText,
    this.feedTarget,
    this.standardId,
    this.userId,
    this.branchId,
    this.accYear,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
    this.files,
    this.createdDateFormatted,
    this.createdTime,
    this.modifiedDateFormatted,
    this.modifiedTime,
  });
}

class FeedStandardEntity {
  final int? standardId;
  final int? divisionId;

  const FeedStandardEntity({this.standardId, this.divisionId});
}

class FeedFileEntity {
  final int? fileId;
  final String? image;
  final String? createdDate;
  final String? createdUser;

  const FeedFileEntity({
    this.fileId,
    this.image,
    this.createdDate,
    this.createdUser,
  });
}
