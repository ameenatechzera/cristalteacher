import 'package:cristalteacher/features/exams/domain/entities/get_all_exam_entity.dart';

class GetAllExamResponseModel extends GetAllExamEntity {
  GetAllExamResponseModel({
    super.status,
    super.error,
    super.message,
    List<GetAllExamModel>? super.data,
  });

  factory GetAllExamResponseModel.fromJson(Map<String, dynamic> json) {
    return GetAllExamResponseModel(
      status: json['status'] as int?,
      error: json['error'] as bool?,
      message: json['message']?.toString(),
      data: (json['data'] as List?)
          ?.map((e) => GetAllExamModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GetAllExamModel extends GetAllExamData {
  GetAllExamModel({
    super.examId,
    super.examName,
    super.examTermId,
    super.examTermName,
    super.examTypeId,
    super.examTypeName,
    super.isOpen,
    super.isPublish,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
    super.branchId,
  });

  factory GetAllExamModel.fromJson(Map<String, dynamic> json) {
    return GetAllExamModel(
      examId: json['examId'] as int?,
      examName: json['examName']?.toString(),
      examTermId: json['examTermId'] as int?,
      examTermName: json['ExamTermName']?.toString(),
      examTypeId: json['examTypeId'] as int?,
      examTypeName: json['ExamTypeName']?.toString(),
      isOpen: json['isOpen'] as bool?,
      isPublish: json['isPublish'] as bool?,
      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
      modifiedDate: json['ModifiedDate']?.toString(),
      modifiedUser: json['ModifiedUser']?.toString(),
      branchId: json['branchId'] as int?,
    );
  }
}
