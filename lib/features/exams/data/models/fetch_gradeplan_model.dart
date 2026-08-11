import 'package:cristalteacher/features/exams/domain/entities/fetch_gradeplan_entity.dart';

class GradePlanResponseModel extends GradePlanResponseEntity {
  GradePlanResponseModel({
    super.status,
    super.error,
    List<GradePlanModel>? super.data,
  });

  factory GradePlanResponseModel.fromJson(Map<String, dynamic> json) {
    return GradePlanResponseModel(
      status: json['status'] as int?,
      error: json['error'] as bool?,
      data: (json['data'] as List?)
          ?.map((e) => GradePlanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GradePlanModel extends GradePlanEntity {
  GradePlanModel({
    super.gradePlanId,
    super.gradePlanName,
    super.planStatus,
    super.planCreatedDate,
    super.planCreatedUser,
    super.planModifiedDate,
    super.planModifiedUser,
    List<GradeSettingModel>? super.settings,
  });

  factory GradePlanModel.fromJson(Map<String, dynamic> json) {
    return GradePlanModel(
      gradePlanId: int.tryParse(json['GradePlanId'].toString()),
      gradePlanName: json['GradePlanName']?.toString(),
      planStatus: json['PlanStatus'] as bool?,
      planCreatedDate: json['PlanCreatedDate']?.toString(),
      planCreatedUser: json['PlanCreatedUser']?.toString(),
      planModifiedDate: json['PlanModifiedDate']?.toString(),
      planModifiedUser: json['PlanModifiedUser']?.toString(),
      settings: (json['Settings'] as List?)
          ?.map((e) => GradeSettingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GradeSettingModel extends GradeSettingEntity {
  GradeSettingModel({
    super.gradeSettingId,
    super.gradeSettingName,
    super.description,
    super.gradePoint,
    super.percentageMin,
    super.percentageMax,
    super.result,
    super.settingStatus,
    super.settingCreatedDate,
    super.settingCreatedUser,
    super.settingModifiedDate,
    super.settingModifiedUser,
  });

  factory GradeSettingModel.fromJson(Map<String, dynamic> json) {
    return GradeSettingModel(
      gradeSettingId: json['GradeSettingId'] as int?,
      gradeSettingName: json['GradeSettingName']?.toString(),
      description: json['Description']?.toString(),
      gradePoint: json['GradePoint'] as int?,
      percentageMin: json['PercentageMin'] as int?,
      percentageMax: json['PercentageMax'] as int?,
      result: json['Result']?.toString(),
      settingStatus: json['SettingStatus'] as bool?,
      settingCreatedDate: json['SettingCreatedDate']?.toString(),
      settingCreatedUser: json['SettingCreatedUser']?.toString(),
      settingModifiedDate: json['SettingModifiedDate']?.toString(),
      settingModifiedUser: json['SettingModifiedUser']?.toString(),
    );
  }
}
