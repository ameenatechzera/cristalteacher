import 'package:cristalteacher/features/exams/domain/entities/fetchexam_entity.dart';

class FetchExamResponseModel extends FetchExamResponseEntity {
  const FetchExamResponseModel({
    super.status,
    super.count,
    List<ExamModel>? super.data,
  });

  factory FetchExamResponseModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];

    return FetchExamResponseModel(
      status: _parseBool(json['status']),
      count: _parseInt(json['count']),
      data: rawData is List
          ? rawData
                .whereType<Map>()
                .map(
                  (item) => ExamModel.fromJson(Map<String, dynamic>.from(item)),
                )
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'count': count,
      'data':
          data
              ?.map(
                (item) => item is ExamModel
                    ? item.toJson()
                    : ExamModel.fromEntity(item).toJson(),
              )
              .toList() ??
          [],
    };
  }
}

class ExamModel extends MarkEntryEntity {
  const ExamModel({
    required super.markEntryId,
    super.employeeId,
    super.accYear,
    super.standardId,
    super.standard,
    super.divisionId,
    super.division,
    super.subjectId,
    super.subjectName,
    super.gradePlanId,
    super.gradePlanName,
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
    List<MarkEntryDetailModel>? super.details,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    final rawDetails = json['Details'];

    return ExamModel(
      markEntryId: _parseInt(json['MarkEntryId']) ?? 0,
      employeeId: _parseInt(json['employeeId']),
      accYear: json['AccYear']?.toString(),
      standardId: _parseInt(json['StandardId']),
      standard: json['Standard']?.toString(),
      divisionId: _parseInt(json['DivisionId']),
      division: json['Division']?.toString(),
      subjectId: _parseInt(json['SubjectId']),
      subjectName: json['SubjectName']?.toString(),
      gradePlanId: _parseInt(json['GradePlanId']),
      gradePlanName: json['GradePlanName']?.toString(),
      maxTE: _parseInt(json['MaxTE']),
      maxCE: _parseInt(json['MaxCE']),
      examDate: json['ExamDate']?.toString(),
      status: _parseBool(json['Status']),
      branchId: _parseInt(json['branchId']),
      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
      modifiedDate: json['ModifiedDate']?.toString(),
      modifiedUser: json['ModifiedUser']?.toString(),
      examId: _parseInt(json['examId']),
      examName: json['examName']?.toString(),
      details: rawDetails is List
          ? rawDetails
                .whereType<Map>()
                .map(
                  (item) => MarkEntryDetailModel.fromJson(
                    Map<String, dynamic>.from(item),
                  ),
                )
                .toList()
          : [],
    );
  }

  factory ExamModel.fromEntity(MarkEntryEntity entity) {
    return ExamModel(
      markEntryId: entity.markEntryId,
      employeeId: entity.employeeId,
      accYear: entity.accYear,
      standardId: entity.standardId,
      standard: entity.standard,
      divisionId: entity.divisionId,
      division: entity.division,
      subjectId: entity.subjectId,
      subjectName: entity.subjectName,
      gradePlanId: entity.gradePlanId,
      gradePlanName: entity.gradePlanName,
      maxTE: entity.maxTE,
      maxCE: entity.maxCE,
      examDate: entity.examDate,
      status: entity.status,
      branchId: entity.branchId,
      createdDate: entity.createdDate,
      createdUser: entity.createdUser,
      modifiedDate: entity.modifiedDate,
      modifiedUser: entity.modifiedUser,
      examId: entity.examId,
      examName: entity.examName,
      details: entity.details?.map(MarkEntryDetailModel.fromEntity).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MarkEntryId': markEntryId,
      'employeeId': employeeId,
      'AccYear': accYear,
      'StandardId': standardId,
      'Standard': standard,
      'DivisionId': divisionId,
      'Division': division,
      'SubjectId': subjectId,
      'SubjectName': subjectName,
      'GradePlanId': gradePlanId,
      'GradePlanName': gradePlanName,
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
      'Details':
          details
              ?.map(
                (item) => item is MarkEntryDetailModel
                    ? item.toJson()
                    : MarkEntryDetailModel.fromEntity(item).toJson(),
              )
              .toList() ??
          [],
    };
  }
}

class MarkEntryDetailModel extends MarkEntryDetailEntity {
  const MarkEntryDetailModel({
    required super.markEntrySplitId,
    required super.markEntryId,
    super.admissionNumber,
    super.te,
    super.ce,
    super.grade,
    super.absent,
    super.status,
    super.narration,
    super.branchId,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
    super.isOptional,
  });

  factory MarkEntryDetailModel.fromJson(Map<String, dynamic> json) {
    return MarkEntryDetailModel(
      markEntrySplitId: _parseInt(json['MarkEntrySplitId']) ?? 0,
      markEntryId: _parseInt(json['MarkEntryId']) ?? 0,
      admissionNumber: json['Admno']?.toString(),
      te: json['TE']?.toString(),
      ce: json['CE']?.toString(),
      grade: json['GRADE']?.toString(),
      absent: json['Absent']?.toString(),
      status: _parseBool(json['Status']),
      narration: json['Narration']?.toString(),
      branchId: _parseInt(json['branchId']),
      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
      modifiedDate: json['ModifiedDate']?.toString(),
      modifiedUser: json['ModifiedUser']?.toString(),
      isOptional: _parseBool(json['isOptional']),
    );
  }

  factory MarkEntryDetailModel.fromEntity(MarkEntryDetailEntity entity) {
    return MarkEntryDetailModel(
      markEntrySplitId: entity.markEntrySplitId,
      markEntryId: entity.markEntryId,
      admissionNumber: entity.admissionNumber,
      te: entity.te,
      ce: entity.ce,
      grade: entity.grade,
      absent: entity.absent,
      status: entity.status,
      narration: entity.narration,
      branchId: entity.branchId,
      createdDate: entity.createdDate,
      createdUser: entity.createdUser,
      modifiedDate: entity.modifiedDate,
      modifiedUser: entity.modifiedUser,
      isOptional: entity.isOptional,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MarkEntrySplitId': markEntrySplitId,
      'MarkEntryId': markEntryId,
      'Admno': admissionNumber,
      'TE': te,
      'CE': ce,
      'GRADE': grade,
      'Absent': absent,
      'Status': status,
      'Narration': narration,
      'branchId': branchId,
      'CreatedDate': createdDate,
      'CreatedUser': createdUser,
      'ModifiedDate': modifiedDate,
      'ModifiedUser': modifiedUser,
      'isOptional': isOptional,
    };
  }
}

int? _parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();

  return int.tryParse(value.toString());
}

bool? _parseBool(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;

  final normalizedValue = value.toString().toLowerCase();

  if (normalizedValue == 'true' || normalizedValue == '1') {
    return true;
  }

  if (normalizedValue == 'false' || normalizedValue == '0') {
    return false;
  }

  return null;
}
