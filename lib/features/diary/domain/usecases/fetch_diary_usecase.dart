import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/diary/domain/entities/diary_entity.dart';
import 'package:cristalteacher/features/diary/domain/parameters/fetch_diary_parameter.dart';
import 'package:cristalteacher/features/diary/domain/repositories/diary_repository.dart';

class FetchDiaryUseCase
    implements UseCaseWithParams<DiaryResponseEntity, FetchDiaryParameter> {
  final DiaryRepository _diaryRepository;

  FetchDiaryUseCase(this._diaryRepository);

  @override
  ResultFuture<DiaryResponseEntity> call(FetchDiaryParameter params) {
    return _diaryRepository.fetchDiary(params);
  }
}
