import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/exams/domain/entities/get_all_exam_entity.dart';
import 'package:cristalteacher/features/exams/domain/repositories/exam_repository.dart';

class GetAllExamUseCase implements UseCaseWithoutParams<GetAllExamEntity> {
  final ExamRepository _examRepository;

  GetAllExamUseCase(this._examRepository);

  @override
  ResultFuture<GetAllExamEntity> call() async {
    return _examRepository.getAllExams();
  }
}
