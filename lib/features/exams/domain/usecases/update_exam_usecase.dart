import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/exams/domain/parameters/update_exam_parameter.dart';
import 'package:cristalteacher/features/exams/domain/repositories/exam_repository.dart';

class UpdateMarkEntryUseCase
    implements
        UseCaseWithParams<MasterResponseModel, UpdateMarkEntryParameter> {
  final ExamRepository _examRepository;

  UpdateMarkEntryUseCase(this._examRepository);

  @override
  ResultFuture<MasterResponseModel> call(
    UpdateMarkEntryParameter params,
  ) async {
    return _examRepository.updateMarkEntry(params);
  }
}
