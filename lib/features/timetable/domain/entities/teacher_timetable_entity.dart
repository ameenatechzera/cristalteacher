class TeacherTimetableEntity {
  final int? status;
  final bool? error;
  final String? message;
  final List<TeacherTimetableData>? data;

  const TeacherTimetableEntity({
    this.status,
    this.error,
    this.message,
    this.data,
  });
}

class TeacherTimetableData {
  final String? dayName;
  final String? periodNo;
  final int? standardId;
  final String? standardName;
  final int? divisionId;
  final String? divisionName;
  final String? subjectId;
  final String? subjectName;
  final String? employeeId;
  final String? employeeName;

  const TeacherTimetableData({
    this.dayName,
    this.periodNo,
    this.standardId,
    this.standardName,
    this.divisionId,
    this.divisionName,
    this.subjectId,
    this.subjectName,
    this.employeeId,
    this.employeeName,
  });
}
