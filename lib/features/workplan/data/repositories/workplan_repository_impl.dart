import 'package:cristalteacher/core/errors/exceptions.dart';
import 'package:cristalteacher/core/errors/failure.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/workplan/data/datasources/workplan_remote_data_source.dart';
import 'package:cristalteacher/features/workplan/domain/entities/workplan_response_entity.dart';
import 'package:cristalteacher/features/workplan/domain/entities/workplandetails_response_entity.dart';
import 'package:cristalteacher/features/workplan/domain/parameters/fetch_workplan_parameter.dart';
import 'package:cristalteacher/features/workplan/domain/parameters/fetch_workplandetails_parameter.dart';
import 'package:cristalteacher/features/workplan/domain/parameters/save_workplan_parameter.dart';
import 'package:cristalteacher/features/workplan/domain/repositories/workplan_repository.dart';
import 'package:dartz/dartz.dart';

class WorkPlanRepositoryImpl implements WorkPlanRepository {
  final WorkPlanRemoteDataSource _remoteDataSource;

  WorkPlanRepositoryImpl(this._remoteDataSource);

  @override
  ResultFuture<WorkPlanResponseEntity> fetchWorkPlans(
    FetchWorkPlanParameter params,
  ) async {
    try {
      final response = await _remoteDataSource.fetchWorkPlans(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.statusMessage));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  ResultFuture<WorkPlanDetailsResponseEntity> fetchWorkPlanDetails(
    FetchWorkPlanDetailsParameter params,
  ) async {
    try {
      final response = await _remoteDataSource.fetchWorkPlanDetails(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.statusMessage));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  ResultFuture<MasterResponseModel> saveWorkPlan(
    SaveWorkPlanParameter params,
  ) async {
    try {
      final response = await _remoteDataSource.saveWorkPlan(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.statusMessage));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
