import 'package:cristalteacher/features/exams/domain/entities/markentry_detailsforupdate_entity.dart';

class MarkEntryDetailsModel extends MarkEntryDetailsEntity {
  const MarkEntryDetailsModel({
    super.markEntryId,
    super.employeeId,
    super.accYear,
    super.standardId,
    super.divisionId,
    super.subjectId,
    super.gradePlanId,
    super.maxTE,
    super.maxCE,
    super.examDate,
    super.status,
    super.branchId,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
    super.examId,
    super.examName,
    super.details,
  });

  factory MarkEntryDetailsModel.fromJson(Map<String, dynamic> json) {
    return MarkEntryDetailsModel(
      markEntryId: json['MarkEntryId']?.toString(),
      employeeId: json['employeeId']?.toString(),
      accYear: json['AccYear']?.toString(),
      standardId: json['StandardId']?.toString(),
      divisionId: json['DivisionId']?.toString(),
      subjectId: json['SubjectId']?.toString(),
      gradePlanId: json['GradePlanId']?.toString(),
      maxTE: json['MaxTE']?.toString(),
      maxCE: json['MaxCE']?.toString(),
      examDate: json['ExamDate']?.toString(),
      status: json['Status'] as bool?,
      branchId: json['branchId'] as int?,
      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
      modifiedDate: json['ModifiedDate']?.toString(),
      modifiedUser: json['ModifiedUser']?.toString(),
      examId: json['examId'] as int?,
      examName: json['examName']?.toString(),
      details:
          (json['Details'] as List<dynamic>?)
              ?.map(
                (e) =>
                    MarkEntryStudentModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MarkEntryId': markEntryId,
      'employeeId': employeeId,
      'AccYear': accYear,
      'StandardId': standardId,
      'DivisionId': divisionId,
      'SubjectId': subjectId,
      'GradePlanId': gradePlanId,
      'MaxTE': maxTE,
      'MaxCE': maxCE,
      'ExamDate': examDate,
      'Status': status,
      'branchId': branchId,
      'CreatedDate': createdDate,
      'CreatedUser': createdUser,
      'ModifiedDate': modifiedDate,
      'ModifiedUser': modifiedUser,
      'examId': examId,
      'examName': examName,
      'Details': details
          .map((e) => (e as MarkEntryStudentModel).toJson())
          .toList(),
    };
  }
}

class MarkEntryStudentModel extends MarkEntryStudentEntity {
  const MarkEntryStudentModel({
    super.ce,
    super.te,
    super.name,
    super.admno,
    super.grade,
    super.absent,
    super.status,
    super.branchId,
    super.narration,
    super.isOptional,
    super.createdDate,
    super.createdUser,
    super.markEntryId,
    super.modifiedDate,
    super.modifiedUser,
    super.markEntrySplitId,
  });

  factory MarkEntryStudentModel.fromJson(Map<String, dynamic> json) {
    return MarkEntryStudentModel(
      ce: json['CE']?.toString(),
      te: json['TE']?.toString(),
      name: json['Name']?.toString(),
      admno: json['Admno']?.toString(),
      grade: json['GRADE']?.toString(),
      absent: json['Absent']?.toString(),
      status: json['Status'] as bool?,
      branchId: json['branchId'] as int?,
      narration: json['Narration']?.toString(),
      isOptional: json['isOptional'] as bool?,
      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
      markEntryId: json['MarkEntryId'] is int
          ? json['MarkEntryId']
          : int.tryParse(json['MarkEntryId']?.toString() ?? ''),
      modifiedDate: json['ModifiedDate']?.toString(),
      modifiedUser: json['ModifiedUser']?.toString(),
      markEntrySplitId: json['MarkEntrySplitId'] is int
          ? json['MarkEntrySplitId']
          : int.tryParse(json['MarkEntrySplitId']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CE': ce,
      'TE': te,
      'Name': name,
      'Admno': admno,
      'GRADE': grade,
      'Absent': absent,
      'Status': status,
      'branchId': branchId,
      'Narration': narration,
      'isOptional': isOptional,
      'CreatedDate': createdDate,
      'CreatedUser': createdUser,
      'MarkEntryId': markEntryId,
      'ModifiedDate': modifiedDate,
      'ModifiedUser': modifiedUser,
      'MarkEntrySplitId': markEntrySplitId,
    };
  }
}
