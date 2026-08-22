import 'package:cristalteacher/core/errors/exceptions.dart';
import 'package:cristalteacher/core/errors/failure.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/timetable/data/datasources/timetable_remote_datasource.dart';
import 'package:cristalteacher/features/timetable/domain/entities/teacher_timetable_entity.dart';
import 'package:cristalteacher/features/timetable/domain/parameters/fetch_teacher_timetable_parameter.dart';
import 'package:cristalteacher/features/timetable/domain/repositories/teacher_timetable_repository.dart';
import 'package:dartz/dartz.dart';

class TeacherTimetableRepositoryImpl implements TeacherTimetableRepository {
  final TeacherTimetableRemoteDataSource remoteDataSource;

  TeacherTimetableRepositoryImpl(this.remoteDataSource);

  @override
  ResultFuture<TeacherTimetableEntity> fetchTeacherTimetable(
    FetchTeacherTimetableParameter params,
  ) async {
    try {
      final response = await remoteDataSource.fetchTeacherTimetable(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.statusMessage));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
