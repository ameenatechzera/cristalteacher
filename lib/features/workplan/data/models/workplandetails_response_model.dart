import 'package:cristalteacher/features/workplan/domain/entities/workplandetails_response_entity.dart';

class WorkPlanDetailsResponseModel extends WorkPlanDetailsResponseEntity {
  WorkPlanDetailsResponseModel({
    super.status,
    super.error,
    super.message,
    List<WorkPlanDetailsModel>? super.data,
  });

  factory WorkPlanDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];

    return WorkPlanDetailsResponseModel(
      status: int.tryParse(json['status']?.toString() ?? ''),
      error: json['error'] == true,
      message: json['message']?.toString(),
      data: rawData is List
          ? rawData.map((item) {
              return WorkPlanDetailsModel.fromJson(
                Map<String, dynamic>.from(item as Map),
              );
            }).toList()
          : [],
    );
  }
}

class WorkPlanDetailsModel extends WorkPlanDetailsData {
  WorkPlanDetailsModel({
    super.id,
    super.masterId,
    super.weekName,
    super.employeeId,
    super.employeeName,
    super.standardId,
    super.standard,
    super.divisionId,
    super.division,
    super.subjectId,
    super.subjectName,
    super.duration,
    super.periods,
    super.topic,
    super.activity,
    super.tools,
    super.remarks,
    super.attachments,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
    super.branchId,
  });

  factory WorkPlanDetailsModel.fromJson(Map<String, dynamic> json) {
    return WorkPlanDetailsModel(
      id: int.tryParse(json['Id']?.toString() ?? ''),
      masterId: int.tryParse(json['MasterId']?.toString() ?? ''),
      weekName: json['WeekName']?.toString(),
      employeeId: int.tryParse(json['employeeId']?.toString() ?? ''),
      employeeName: json['employeeName']?.toString(),
      standardId: int.tryParse(json['StandardId']?.toString() ?? ''),
      standard: json['Standard']?.toString(),
      divisionId: int.tryParse(json['DivisionId']?.toString() ?? ''),
      division: json['Division']?.toString(),
      subjectId: int.tryParse(json['subjectId']?.toString() ?? ''),
      subjectName: json['SubjectName']?.toString(),
      duration: json['duration']?.toString(),
      periods: json['periods']?.toString(),
      topic: json['topic']?.toString(),
      activity: json['activity']?.toString(),
      tools: json['tools']?.toString(),
      remarks: json['remarks']?.toString(),
      attachments: json['Attachments']?.toString(),
      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
      modifiedDate: json['ModifiedDate']?.toString(),
      modifiedUser: json['ModifiedUser']?.toString(),
      branchId: int.tryParse(json['branchId']?.toString() ?? ''),
    );
  }
}
