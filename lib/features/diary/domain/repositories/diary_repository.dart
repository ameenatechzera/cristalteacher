import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/diary/domain/entities/diary_entity.dart';
import 'package:cristalteacher/features/diary/domain/parameters/fetch_diary_parameter.dart';

abstract class DiaryRepository {
  ResultFuture<DiaryResponseEntity> fetchDiary(FetchDiaryParameter request);
}
