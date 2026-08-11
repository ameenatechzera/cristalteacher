import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/diary/domain/entities/diary_entity.dart';
import 'package:cristalteacher/features/diary/domain/parameters/fetch_diary_parameter.dart';
import 'package:cristalteacher/features/diary/domain/parameters/save_diary_parameter.dart';

abstract class DiaryRepository {
  ResultFuture<DiaryResponseEntity> fetchDiary(FetchDiaryParameter request);
  ResultFuture<MasterResponseModel> saveDiary(SaveDiaryParameter params);
  ResultFuture<MasterResponseModel> deleteDiary(int id);
}
