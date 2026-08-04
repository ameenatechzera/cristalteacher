import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/diary/domain/parameters/save_diary_parameter.dart';
import 'package:cristalteacher/features/diary/domain/repositories/diary_repository.dart';

class SaveDiaryUseCase
    implements UseCaseWithParams<MasterResponseModel, SaveDiaryParameter> {
  final DiaryRepository _diaryRepository;

  SaveDiaryUseCase(this._diaryRepository);

  @override
  ResultFuture<MasterResponseModel> call(SaveDiaryParameter params) {
    return _diaryRepository.saveDiary(params);
  }
}
