class WorkPlanDetailsResponseEntity {
  final int? status;
  final bool? error;
  final String? message;
  final List<WorkPlanDetailsData>? data;

  const WorkPlanDetailsResponseEntity({
    this.status,
    this.error,
    this.message,
    this.data,
  });
}

class WorkPlanDetailsData {
  final int? id;
  final int? masterId;
  final String? weekName;
  final int? employeeId;
  final String? employeeName;
  final int? standardId;
  final String? standard;
  final int? divisionId;
  final String? division;
  final int? subjectId;
  final String? subjectName;
  final String? duration;
  final String? periods;
  final String? topic;
  final String? activity;
  final String? tools;
  final String? remarks;
  final String? attachments;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;
  final int? branchId;

  const WorkPlanDetailsData({
    this.id,
    this.masterId,
    this.weekName,
    this.employeeId,
    this.employeeName,
    this.standardId,
    this.standard,
    this.divisionId,
    this.division,
    this.subjectId,
    this.subjectName,
    this.duration,
    this.periods,
    this.topic,
    this.activity,
    this.tools,
    this.remarks,
    this.attachments,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
    this.branchId,
  });
}
