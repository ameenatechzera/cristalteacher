import 'package:cristalteacher/core/errors/exceptions.dart';
import 'package:cristalteacher/core/errors/failure.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/diary/data/datasources/diary_remote_data_source.dart';
import 'package:cristalteacher/features/diary/domain/entities/diary_entity.dart';
import 'package:cristalteacher/features/diary/domain/parameters/fetch_diary_parameter.dart';
import 'package:cristalteacher/features/diary/domain/repositories/diary_repository.dart';
import 'package:dartz/dartz.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  final DiaryRemoteDataSource _remoteDataSource;

  DiaryRepositoryImpl(this._remoteDataSource);

  @override
  ResultFuture<DiaryResponseEntity> fetchDiary(
    FetchDiaryParameter request,
  ) async {
    try {
      final response = await _remoteDataSource.fetchDiary(request);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
