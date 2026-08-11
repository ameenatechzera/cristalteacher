import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/diary/domain/repositories/diary_repository.dart';

class DeleteDiaryUseCase
    implements UseCaseWithParams<MasterResponseModel, int> {
  final DiaryRepository _diaryRepository;

  DeleteDiaryUseCase(this._diaryRepository);

  @override
  ResultFuture<MasterResponseModel> call(int id) async {
    return _diaryRepository.deleteDiary(id);
  }
}
