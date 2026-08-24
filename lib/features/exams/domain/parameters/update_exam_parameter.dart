// class UpdateMarkEntryParameter {
//   final int markEntryId;
//   final int employeeId;
//   final String accYear;
//   final int examTermId;
//   final int examTypeId;
//   final int standardId;
//   final int divisionId;
//   final int subjectId;
//   final int gradePlanId;
//   final int maxTE;
//   final int maxCE;
//   final String examDate;
//   final bool status;
//   final int branchId;
//   final String modifiedUser;
//   final List<MarkEntryDetailParameter> details;

//   UpdateMarkEntryParameter({
//     required this.markEntryId,
//     required this.employeeId,
//     required this.accYear,
//     required this.examTermId,
//     required this.examTypeId,
//     required this.standardId,
//     required this.divisionId,
//     required this.subjectId,
//     required this.gradePlanId,
//     required this.maxTE,
//     required this.maxCE,
//     required this.examDate,
//     required this.status,
//     required this.branchId,
//     required this.modifiedUser,
//     required this.details,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       "MarkEntryId": markEntryId,
//       "employeeId": employeeId,
//       "AccYear": accYear,
//       "ExamTermId": examTermId,
//       "ExamTypeId": examTypeId,
//       "StandardId": standardId,
//       "DivisionId": divisionId,
//       "SubjectId": subjectId,
//       "GradePlanId": gradePlanId,
//       "MaxTE": maxTE,
//       "MaxCE": maxCE,
//       "ExamDate": examDate,
//       "Status": status,
//       "branchId": branchId,
//       "ModifiedUser": modifiedUser,
//       "details": details.map((e) => e.toJson()).toList(),
//     };
//   }
// }

// class MarkEntryDetailParameter {
//   final String admno;
//   final String te;
//   final String ce;
//   final String grade;
//   final String absent;
//   final bool status;
//   final String narration;

//   MarkEntryDetailParameter({
//     required this.admno,
//     required this.te,
//     required this.ce,
//     required this.grade,
//     required this.absent,
//     required this.status,
//     required this.narration,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       "Admno": admno,
//       "TE": te,
//       "CE": ce,
//       "GRADE": grade,
//       "Absent": absent,
//       "Status": status,
//       "Narration": narration,
//     };
//   }
// }
class UpdateMarkEntryParameter {
  final int employeeId;
  final String accYear;
  final int examId;
  final int standardId;
  final int divisionId;
  final int subjectId;
  final int gradePlanId;
  final int maxTE;
  final int maxCE;
  final String examDate;
  final bool status;
  final int branchId;
  final int modifiedUser;
  final List<MarkEntryDetailParameter> details;

  UpdateMarkEntryParameter({
    required this.employeeId,
    required this.accYear,
    required this.examId,
    required this.standardId,
    required this.divisionId,
    required this.subjectId,
    required this.gradePlanId,
    required this.maxTE,
    required this.maxCE,
    required this.examDate,
    required this.status,
    required this.branchId,
    required this.modifiedUser,
    required this.details,
  });

  Map<String, dynamic> toJson() {
    return {
      "employeeId": employeeId,
      "AccYear": accYear,
      "examId": examId,
      "StandardId": standardId.toString(),
      "DivisionId": divisionId.toString(),
      "SubjectId": subjectId.toString(),
      "GradePlanId": gradePlanId.toString(),
      "MaxTE": maxTE.toString(),
      "MaxCE": maxCE.toString(),
      "ExamDate": examDate,
      "Status": status,
      "branchId": branchId,
      "ModifiedUser": modifiedUser,
      "details": details.map((e) => e.toJson()).toList(),
    };
  }
}

class MarkEntryDetailParameter {
  final String admno;
  final String te;
  final String ce;
  final String grade;
  final String absent;
  final bool isOptional;
  final bool status;
  final String narration;

  MarkEntryDetailParameter({
    required this.admno,
    required this.te,
    required this.ce,
    required this.grade,
    required this.absent,
    required this.isOptional,
    required this.status,
    required this.narration,
  });

  Map<String, dynamic> toJson() {
    return {
      "Admno": admno,
      "TE": te,
      "CE": ce,
      "GRADE": grade,
      "Absent": absent,
      "isOptional": isOptional,
      "Status": status,
      "Narration": narration,
    };
  }
}
