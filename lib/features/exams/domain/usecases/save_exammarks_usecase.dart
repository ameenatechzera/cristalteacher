import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/exams/domain/entities/save_exammarks_entiity.dart';
import 'package:cristalteacher/features/exams/domain/parameters/save_exam_parameter.dart';
import 'package:cristalteacher/features/exams/domain/repositories/exam_repository.dart';

class SaveExamMarksUseCase
    implements UseCaseWithParams<SaveExamMarksEntity, SaveExamMarksParameter> {
  final ExamRepository _examRepository;

  SaveExamMarksUseCase(this._examRepository);

  @override
  ResultFuture<SaveExamMarksEntity> call(SaveExamMarksParameter params) async {
    return _examRepository.saveExamMarks(params);
  }
}
