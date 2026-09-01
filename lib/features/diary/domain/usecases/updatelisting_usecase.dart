import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/diary/domain/entities/update_listing_entity.dart';
import 'package:cristalteacher/features/diary/domain/repositories/diary_repository.dart';

class FetchDiaryUpdateListingUseCase
    implements UseCaseWithParams<DiaryUpdateListingEntity, int> {
  final DiaryRepository _diaryRepository;

  FetchDiaryUpdateListingUseCase(this._diaryRepository);

  @override
  ResultFuture<DiaryUpdateListingEntity> call(int diaryId) async {
    return _diaryRepository.fetchDiaryUpdateListing(diaryId);
  }
}
