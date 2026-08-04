import 'package:cristalteacher/features/feed/domain/entities/fetch_feed_entity.dart';

class FetchFeedModel extends FetchFeedEntity {
  const FetchFeedModel({super.status, super.error, super.data, super.message});

  factory FetchFeedModel.fromJson(Map<String, dynamic> json) {
    return FetchFeedModel(
      status: json['status'],
      error: json['error'],
      message: json['message']?.toString(),
      data: (json['data'] as List?)?.map((e) => FeedModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'error': error,
      'message': message,
      'data': data?.map((e) => (e as FeedModel).toJson()).toList(),
    };
  }
}

class FeedModel extends FeedEntity {
  const FeedModel({
    super.feedId,
    super.feedText,
    super.feedTarget,
    super.standardId,
    super.userId,
    super.branchId,
    super.accYear,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
    super.files,
    super.createdDateFormatted,
    super.createdTime,
    super.modifiedDateFormatted,
    super.modifiedTime,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      feedId: int.tryParse(json['feedId'].toString()),
      feedText: json['feedText']?.toString(),
      feedTarget: json['feedTarget']?.toString(),
      standardId: (json['StandardId'] as List?)
          ?.map((e) => FeedStandardModel.fromJson(e))
          .toList(),
      userId: json['userId']?.toString(),
      branchId: int.tryParse(json['branchId'].toString()),
      accYear: json['AccYear']?.toString(),
      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
      modifiedDate: json['ModifiedDate']?.toString(),
      modifiedUser: json['ModifiedUser']?.toString(),
      files: (json['Files'] as List?)
          ?.map((e) => FeedFileModel.fromJson(e))
          .toList(),
      createdDateFormatted: json['CreatedDateFormatted']?.toString(),
      createdTime: json['CreatedTime']?.toString(),
      modifiedDateFormatted: json['ModifiedDateFormatted']?.toString(),
      modifiedTime: json['ModifiedTime']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'feedId': feedId,
      'feedText': feedText,
      'feedTarget': feedTarget,
      'StandardId': standardId
          ?.map((e) => (e as FeedStandardModel).toJson())
          .toList(),
      'userId': userId,
      'branchId': branchId,
      'AccYear': accYear,
      'CreatedDate': createdDate,
      'CreatedUser': createdUser,
      'ModifiedDate': modifiedDate,
      'ModifiedUser': modifiedUser,
      'Files': files?.map((e) => (e as FeedFileModel).toJson()).toList(),
      'CreatedDateFormatted': createdDateFormatted,
      'CreatedTime': createdTime,
      'ModifiedDateFormatted': modifiedDateFormatted,
      'ModifiedTime': modifiedTime,
    };
  }
}

class FeedStandardModel extends FeedStandardEntity {
  const FeedStandardModel({super.standardId, super.divisionId});

  factory FeedStandardModel.fromJson(Map<String, dynamic> json) {
    return FeedStandardModel(
      standardId: int.tryParse(json['StandardId'].toString()),
      divisionId: int.tryParse(json['DivisionId'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {'StandardId': standardId, 'DivisionId': divisionId};
  }
}

class FeedFileModel extends FeedFileEntity {
  const FeedFileModel({
    super.fileId,
    super.image,
    super.createdDate,
    super.createdUser,
  });

  factory FeedFileModel.fromJson(Map<String, dynamic> json) {
    return FeedFileModel(
      fileId: int.tryParse(json['FileId'].toString()),
      image: json['Image']?.toString(),
      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FileId': fileId,
      'Image': image,
      'CreatedDate': createdDate,
      'CreatedUser': createdUser,
    };
  }
}
