import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/exams/domain/entities/fetchexam_entity.dart';
import 'package:cristalteacher/features/exams/domain/parameters/fetch_exam_parameter.dart';
import 'package:cristalteacher/features/exams/domain/repositories/exam_repository.dart';

class FetchExamUseCase
    implements
        UseCaseWithParams<FetchExamResponseEntity, FetchMarkEntryParameter> {
  final ExamRepository _examRepository;

  FetchExamUseCase(this._examRepository);

  @override
  ResultFuture<FetchExamResponseEntity> call(
    FetchMarkEntryParameter params,
  ) async {
    return _examRepository.fetchMarkEntry(params);
  }
}
