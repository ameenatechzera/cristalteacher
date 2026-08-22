import 'package:cristalteacher/core/errors/exceptions.dart';
import 'package:cristalteacher/core/errors/failure.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/earlygoing/data/datasources/gatepass_remote_data_source.dart';
import 'package:cristalteacher/features/earlygoing/domain/entities/gatepass_entity.dart';
import 'package:cristalteacher/features/earlygoing/domain/parameter/gatepass_parameter.dart';
import 'package:cristalteacher/features/earlygoing/domain/parameter/update_gatepass_parameter.dart';
import 'package:cristalteacher/features/earlygoing/domain/repositories/gatepass_repository.dart';
import 'package:dartz/dartz.dart';

class GatePassRepositoryImpl implements GatePassRepository {
  final GatePassRemoteDataSource remoteDataSource;

  GatePassRepositoryImpl(this.remoteDataSource);

  @override
  ResultFuture<GatePassEntity> fetchGatePass(
    FetchGatePassParameter params,
  ) async {
    try {
      final response = await remoteDataSource.fetchGatePass(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.statusMessage));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  ResultFuture<MasterResponseModel> updateGatePass(
    UpdateGatePassParameter params,
    int id,
  ) async {
    try {
      final response = await remoteDataSource.updateGatePass(params, id);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.statusMessage));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
