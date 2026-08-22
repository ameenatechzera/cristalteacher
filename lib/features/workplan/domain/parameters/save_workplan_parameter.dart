import 'dart:io';

class SaveWorkPlanParameter {
  final int masterId;
  final int employeeId;
  final int standardId;
  final int divisionId;
  final int subjectId;
  final String duration;
  final String periods;
  final String topic;
  final String activity;
  final String tools;
  final String remarks;
  final int branchId;
  final String createdUser;
  final File? attachment;

  const SaveWorkPlanParameter({
    required this.masterId,
    required this.employeeId,
    required this.standardId,
    required this.divisionId,
    required this.subjectId,
    required this.duration,
    required this.periods,
    required this.topic,
    required this.activity,
    required this.tools,
    required this.remarks,
    required this.branchId,
    required this.createdUser,
    this.attachment,
  });

  Map<String, dynamic> toJson() {
    return {
      'MasterId': masterId,
      'employeeId': employeeId,
      'StandardId': standardId,
      'DivisionId': divisionId,
      'subjectId': subjectId,
      'duration': duration,
      'periods': periods,
      'topic': topic,
      'activity': activity,
      'tools': tools,
      'remarks': remarks,
      'branchId': branchId,
      'CreatedUser': createdUser,
    };
  }

  @override
  String toString() {
    return {...toJson(), 'Attachments': attachment?.path}.toString();
  }
}
