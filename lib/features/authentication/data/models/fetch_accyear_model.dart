import 'package:cristalteacher/features/authentication/domain/entities/fetch_accyear_entity.dart';

class FetchAccYearModel extends FetchAccYearEntity {
  const FetchAccYearModel({super.status, super.error, super.data});

  factory FetchAccYearModel.fromJson(Map<String, dynamic> json) {
    return FetchAccYearModel(
      status: json['status'],
      error: json['error'],
      data: (json['data'] as List?)
          ?.map((e) => AccYearModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'error': error,
      'data': data?.map((e) => (e as AccYearModel).toJson()).toList(),
    };
  }
}

class AccYearModel extends AccYearEntity {
  const AccYearModel({
    super.accYearId,
    super.accYear,
    super.fromDate,
    super.toDate,
    super.status,
    super.branchId,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
  });

  factory AccYearModel.fromJson(Map<String, dynamic> json) {
    return AccYearModel(
      accYearId: int.tryParse(json['AccYearId'].toString()),
      accYear: json['AccYear']?.toString(),
      fromDate: json['fromDate']?.toString(),
      toDate: json['toDate']?.toString(),
      status: json['status'] as bool?,
      branchId: int.tryParse(json['branchId'].toString()),
      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
      modifiedDate: json['ModifiedDate']?.toString(),
      modifiedUser: json['ModifiedUser']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AccYearId': accYearId,
      'AccYear': accYear,
      'fromDate': fromDate,
      'toDate': toDate,
      'status': status,
      'branchId': branchId,
      'CreatedDate': createdDate,
      'CreatedUser': createdUser,
      'ModifiedDate': modifiedDate,
      'ModifiedUser': modifiedUser,
    };
  }
}
