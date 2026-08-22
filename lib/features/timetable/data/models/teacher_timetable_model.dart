import 'package:cristalteacher/features/timetable/domain/entities/teacher_timetable_entity.dart';

class TeacherTimetableResponseModel extends TeacherTimetableEntity {
  TeacherTimetableResponseModel({
    super.status,
    super.error,
    super.message,
    List<TeacherTimetableModel>? super.data,
  });

  factory TeacherTimetableResponseModel.fromJson(Map<String, dynamic> json) {
    return TeacherTimetableResponseModel(
      status: json['status'],
      error: json['error'],
      message: json['message']?.toString(),
      data: (json['data'] as List?)
          ?.map(
            (item) =>
                TeacherTimetableModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class TeacherTimetableModel extends TeacherTimetableData {
  TeacherTimetableModel({
    super.dayName,
    super.periodNo,
    super.standardId,
    super.standardName,
    super.divisionId,
    super.divisionName,
    super.subjectId,
    super.subjectName,
    super.employeeId,
    super.employeeName,
  });

  factory TeacherTimetableModel.fromJson(Map<String, dynamic> json) {
    return TeacherTimetableModel(
      dayName: json['dayname']?.toString(),
      periodNo: json['periodno']?.toString(),
      standardId: int.tryParse(json['standardid']?.toString() ?? ''),
      standardName: json['standardname']?.toString(),
      divisionId: int.tryParse(json['divisionid']?.toString() ?? ''),
      divisionName: json['divisionname']?.toString(),
      subjectId: json['subjectid']?.toString(),
      subjectName: json['subjectname']?.toString(),
      employeeId: json['employeeid']?.toString(),
      employeeName: json['employeename']?.toString(),
    );
  }
}
