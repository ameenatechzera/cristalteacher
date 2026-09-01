import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/diary/domain/parameters/update_diary_parameter.dart';
import 'package:cristalteacher/features/diary/domain/repositories/diary_repository.dart';

class UpdateDiaryUseCase {
  final DiaryRepository _diaryRepository;

  UpdateDiaryUseCase(this._diaryRepository);

  ResultFuture<MasterResponseModel> call(
    UpdateDiaryParameter params,
    int diaryId,
  ) async {
    return _diaryRepository.updateDiary(params, diaryId);
  }
}
