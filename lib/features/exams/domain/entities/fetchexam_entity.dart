import 'package:equatable/equatable.dart';

class FetchExamResponseEntity extends Equatable {
  final bool? status;
  final int? count;
  final List<MarkEntryEntity>? data;

  const FetchExamResponseEntity({this.status, this.count, this.data});

  @override
  List<Object?> get props => [status, count, data];
}

class MarkEntryEntity extends Equatable {
  final int markEntryId;
  final int? employeeId;
  final String? accYear;
  final int? standardId;
  final String? standard;
  final int? divisionId;
  final String? division;
  final int? subjectId;
  final String? subjectName;
  final int? gradePlanId;
  final String? gradePlanName;
  final int? maxTE;
  final int? maxCE;
  final String? examDate;
  final bool? status;
  final int? branchId;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;
  final int? examId;
  final String? examName;
  final List<MarkEntryDetailEntity>? details;

  const MarkEntryEntity({
    required this.markEntryId,
    this.employeeId,
    this.accYear,
    this.standardId,
    this.standard,
    this.divisionId,
    this.division,
    this.subjectId,
    this.subjectName,
    this.gradePlanId,
    this.gradePlanName,
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
    this.details,
  });

  @override
  List<Object?> get props => [
    markEntryId,
    employeeId,
    accYear,
    standardId,
    standard,
    divisionId,
    division,
    subjectId,
    subjectName,
    gradePlanId,
    gradePlanName,
    maxTE,
    maxCE,
    examDate,
    status,
    branchId,
    createdDate,
    createdUser,
    modifiedDate,
    modifiedUser,
    examId,
    examName,
    details,
  ];
}

class MarkEntryDetailEntity extends Equatable {
  final int markEntrySplitId;
  final int markEntryId;
  final String? admissionNumber;
  final String? te;
  final String? ce;
  final String? grade;
  final String? absent;
  final bool? status;
  final String? narration;
  final int? branchId;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;
  final bool? isOptional;

  const MarkEntryDetailEntity({
    required this.markEntrySplitId,
    required this.markEntryId,
    this.admissionNumber,
    this.te,
    this.ce,
    this.grade,
    this.absent,
    this.status,
    this.narration,
    this.branchId,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
    this.isOptional,
  });

  @override
  List<Object?> get props => [
    markEntrySplitId,
    markEntryId,
    admissionNumber,
    te,
    ce,
    grade,
    absent,
    status,
    narration,
    branchId,
    createdDate,
    createdUser,
    modifiedDate,
    modifiedUser,
    isOptional,
  ];
}
