import 'package:cristalteacher/core/errors/failure.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/features/exams/data/datasources/exam_remote_data_source.dart';
import 'package:cristalteacher/features/exams/domain/entities/fetch_gradeplan_entity.dart';
import 'package:cristalteacher/features/exams/domain/entities/fetchexam_entity.dart';
import 'package:cristalteacher/features/exams/domain/entities/get_all_exam_entity.dart';
import 'package:cristalteacher/features/exams/domain/entities/save_exammarks_entiity.dart';
import 'package:cristalteacher/features/exams/domain/parameters/fetch_exam_parameter.dart';
import 'package:cristalteacher/features/exams/domain/parameters/save_exam_parameter.dart';
import 'package:cristalteacher/features/exams/domain/parameters/update_exam_parameter.dart';
import 'package:dartz/dartz.dart';
import 'package:cristalteacher/core/errors/exceptions.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/exams/domain/repositories/exam_repository.dart';

class ExamRepositoryImpl implements ExamRepository {
  final ExamRemoteDataSource _remoteDataSource;

  ExamRepositoryImpl(this._remoteDataSource);

  @override
  ResultFuture<FetchExamResponseEntity> fetchMarkEntry(
    FetchMarkEntryParameter params,
  ) async {
    try {
      final result = await _remoteDataSource.fetchMarkEntry(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<GradePlanResponseEntity> fetchGradePlan() async {
    try {
      final result = await _remoteDataSource.fetchGradePlan();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<GetAllExamEntity> getAllExams() async {
    try {
      final result = await _remoteDataSource.getAllExams();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<SaveExamMarksEntity> saveExamMarks(
    SaveExamMarksParameter params,
  ) async {
    try {
      final result = await _remoteDataSource.saveExamMarks(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<MasterResponseModel> deleteExamMark(int id) async {
    try {
      final result = await _remoteDataSource.deleteExams(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<MasterResponseModel> updateMarkEntry(
    UpdateMarkEntryParameter params,
  ) async {
    try {
      final result = await _remoteDataSource.updateExamMarks(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
