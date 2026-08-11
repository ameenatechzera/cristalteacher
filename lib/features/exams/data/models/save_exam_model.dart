import 'package:cristalteacher/features/exams/domain/entities/save_exammarks_entiity.dart';

class SaveExamMarksModel extends SaveExamMarksEntity {
  const SaveExamMarksModel({
    required super.status,
    required super.message,
    required super.markEntryId,
  });

  factory SaveExamMarksModel.fromJson(Map<String, dynamic> json) {
    return SaveExamMarksModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      markEntryId: json['MarkEntryId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'MarkEntryId': markEntryId};
  }
}
