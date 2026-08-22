class MarkEntryDetailsEntity {
  final String? markEntryId;
  final String? employeeId;
  final String? accYear;
  final String? standardId;
  final String? divisionId;
  final String? subjectId;
  final String? gradePlanId;
  final String? maxTE;
  final String? maxCE;
  final String? examDate;
  final bool? status;
  final int? branchId;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;
  final int? examId;
  final String? examName;
  final List<MarkEntryStudentEntity> details;

  const MarkEntryDetailsEntity({
    this.markEntryId,
    this.employeeId,
    this.accYear,
    this.standardId,
    this.divisionId,
    this.subjectId,
    this.gradePlanId,
    this.maxTE,
    this.maxCE,
    this.examDate,
    this.status,
    this.branchId,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
    this.examId,
    this.examName,
    this.details = const [],
  });
}

class MarkEntryStudentEntity {
  final String? ce;
  final String? te;
  final String? name;
  final String? admno;
  final String? grade;
  final String? absent;
  final bool? status;
  final int? branchId;
  final String? narration;
  final bool? isOptional;
  final String? createdDate;
  final String? createdUser;
  final int? markEntryId;
  final String? modifiedDate;
  final String? modifiedUser;
  final int? markEntrySplitId;

  const MarkEntryStudentEntity({
    this.ce,
    this.te,
    this.name,
    this.admno,
    this.grade,
    this.absent,
    this.status,
    this.branchId,
    this.narration,
    this.isOptional,
    this.createdDate,
    this.createdUser,
    this.markEntryId,
    this.modifiedDate,
    this.modifiedUser,
    this.markEntrySplitId,
  });
}
