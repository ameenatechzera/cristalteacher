import 'package:cristalteacher/features/workplan/domain/entities/workplan_response_entity.dart';

class WorkPlanResponseModel extends WorkPlanResponseEntity {
  WorkPlanResponseModel({
    super.status,
    super.error,
    super.message,
    List<WorkPlanModel>? super.data,
  });

  factory WorkPlanResponseModel.fromJson(Map<String, dynamic> json) {
    return WorkPlanResponseModel(
      status: int.tryParse(json['status']?.toString() ?? ''),
      error: json['error'] == true,
      message: json['message']?.toString(),
      data: json['data'] is List
          ? (json['data'] as List)
                .whereType<Map>()
                .map(
                  (item) =>
                      WorkPlanModel.fromJson(Map<String, dynamic>.from(item)),
                )
                .toList()
          : [],
    );
  }
}

class WorkPlanModel extends WorkPlanData {
  WorkPlanModel({
    super.id,
    super.accYear,
    super.weekName,
    super.fromDate,
    super.toDate,
    super.cutoffFromDate,
    super.cutoffToDate,
    super.status,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
    super.branchId,
  });

  factory WorkPlanModel.fromJson(Map<String, dynamic> json) {
    return WorkPlanModel(
      id: int.tryParse(json['Id']?.toString() ?? ''),
      accYear: json['AccYear']?.toString(),
      weekName: json['WeekName']?.toString(),
      fromDate: json['fromDate']?.toString(),
      toDate: json['toDate']?.toString(),
      cutoffFromDate: json['cutoffFromDate']?.toString(),
      cutoffToDate: json['cutoffToDate']?.toString(),
      status: json['Status']?.toString(),
      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
      modifiedDate: json['ModifiedDate']?.toString(),
      modifiedUser: json['ModifiedUser']?.toString(),
      branchId: int.tryParse(json['branchId']?.toString() ?? ''),
    );
  }
}
