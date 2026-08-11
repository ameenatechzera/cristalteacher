class SaveExamMarksParameter {
  final int employeeId;
  final String accYear;
  final int standardId;
  final int divisionId;
  final int subjectId;
  final int gradePlanId;
  final int maxTE;
  final int maxCE;
  final String examDate;
  final bool status;
  final int branchId;
  final String createdUser;
  final int examId;
  final List<ExamMarkDetailParameter> details;

  const SaveExamMarksParameter({
    required this.employeeId,
    required this.accYear,
    required this.standardId,
    required this.divisionId,
    required this.subjectId,
    required this.gradePlanId,
    required this.maxTE,
    required this.maxCE,
    required this.examDate,
    required this.status,
    required this.branchId,
    required this.createdUser,
    required this.examId,
    required this.details,
  });

  Map<String, dynamic> toJson() {
    return {
      "employeeId": employeeId,
      "AccYear": accYear,
      "StandardId": standardId,
      "DivisionId": divisionId,
      "SubjectId": subjectId,
      "GradePlanId": gradePlanId,
      "MaxTE": maxTE,
      "MaxCE": maxCE,
      "ExamDate": examDate,
      "Status": status,
      "branchId": branchId,
      "CreatedUser": createdUser,
      "examId": examId,
      "details": details.map((e) => e.toJson()).toList(),
    };
  }
}

class ExamMarkDetailParameter {
  final String admno;
  final String te;
  final String ce;
  final String grade;
  final String absent;
  final bool status;
  final String narration;
  final bool? isOptional;

  const ExamMarkDetailParameter({
    required this.admno,
    required this.te,
    required this.ce,
    required this.grade,
    required this.absent,
    required this.status,
    required this.narration,
    this.isOptional,
  });

  Map<String, dynamic> toJson() {
    return {
      "Admno": admno,
      "TE": te,
      "CE": ce,
      "GRADE": grade,
      "Absent": absent,
      "Status": status,
      "Narration": narration,
      if (isOptional != null) "isOptional": isOptional,
    };
  }
}
