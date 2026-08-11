class GradePlanResponseEntity {
  final int? status;
  final bool? error;
  final List<GradePlanEntity>? data;

  const GradePlanResponseEntity({this.status, this.error, this.data});
}

class GradePlanEntity {
  final int? gradePlanId;
  final String? gradePlanName;
  final bool? planStatus;
  final String? planCreatedDate;
  final String? planCreatedUser;
  final String? planModifiedDate;
  final String? planModifiedUser;
  final List<GradeSettingEntity>? settings;

  const GradePlanEntity({
    this.gradePlanId,
    this.gradePlanName,
    this.planStatus,
    this.planCreatedDate,
    this.planCreatedUser,
    this.planModifiedDate,
    this.planModifiedUser,
    this.settings,
  });
}

class GradeSettingEntity {
  final int? gradeSettingId;
  final String? gradeSettingName;
  final String? description;
  final int? gradePoint;
  final int? percentageMin;
  final int? percentageMax;
  final String? result;
  final bool? settingStatus;
  final String? settingCreatedDate;
  final String? settingCreatedUser;
  final String? settingModifiedDate;
  final String? settingModifiedUser;

  const GradeSettingEntity({
    this.gradeSettingId,
    this.gradeSettingName,
    this.description,
    this.gradePoint,
    this.percentageMin,
    this.percentageMax,
    this.result,
    this.settingStatus,
    this.settingCreatedDate,
    this.settingCreatedUser,
    this.settingModifiedDate,
    this.settingModifiedUser,
  });
}
