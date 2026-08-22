import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/exams/domain/entities/markentry_detailsforupdate_entity.dart';
import 'package:cristalteacher/features/exams/domain/repositories/exam_repository.dart';

class FetchMarkEntryDetailsUseCase {
  final ExamRepository _repository;

  FetchMarkEntryDetailsUseCase(this._repository);

  ResultFuture<MarkEntryDetailsEntity> call(int markEntryId) {
    return _repository.fetchMarkEntryDetails(markEntryId);
  }
}
