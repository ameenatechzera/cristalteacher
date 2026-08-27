import 'package:cristalteacher/core/errors/exceptions.dart';
import 'package:cristalteacher/core/errors/failure.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:cristalteacher/features/authentication/domain/entities/class_details_entity.dart';
import 'package:cristalteacher/features/authentication/domain/entities/fetch_accyear_entity.dart';
import 'package:cristalteacher/features/authentication/domain/entities/fetch_branch_entity.dart';
import 'package:cristalteacher/features/authentication/domain/entities/fetch_school_entity.dart';
import 'package:cristalteacher/features/authentication/domain/entities/login_entity.dart';
import 'package:cristalteacher/features/authentication/domain/entities/teacher_dashboard_result.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_school_parameter.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_teacherdashboard_request.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_tutorshipclass_parameter.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/login_parameter.dart';
import 'package:cristalteacher/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  ResultFuture<LoginEntity> login(LoginRequest params) async {
    try {
      final result = await _remoteDataSource.login(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<FetchSchoolEntity> fetchSchools(
    FetchSchoolRequest request,
  ) async {
    try {
      final result = await _remoteDataSource.fetchSchools(request);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<GetBranchEntity> getBranchDetails() async {
    try {
      final result = await _remoteDataSource.getBranchDetails();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<FetchTutorshipClassEntity> fetchTutorshipClass(
    FetchTutorshipClassRequest request,
  ) async {
    try {
      final result = await _remoteDataSource.fetchTutorshipClass(request);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<FetchAccYearEntity> fetchAccYear() async {
    try {
      final result = await _remoteDataSource.fetchAccYear();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<TeacherDashboardResult> fetchDashboardDetails(TeacherDashboardRequest request) async {
    try {
      final result = await _remoteDataSource.fetchTeacherDashboard(request);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
