import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/features/exams/domain/repositories/exam_repository.dart';

class DeleteExamMarkUseCase
    implements UseCaseWithParams<MasterResponseModel, int> {
  final ExamRepository _examRepository;

  DeleteExamMarkUseCase(this._examRepository);

  @override
  ResultFuture<MasterResponseModel> call(int id) async {
    return _examRepository.deleteExamMark(id);
  }
}
