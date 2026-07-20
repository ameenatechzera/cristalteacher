import 'package:cristalteacher/core/errors/failure.dart';
import 'package:cristalteacher/features/authentication/domain/entities/fetch_accyear_entity.dart';
import 'package:cristalteacher/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class FetchAccYearUseCase {
  final AuthRepository repository;

  FetchAccYearUseCase(this.repository);

  Future<Either<Failure, FetchAccYearEntity>> call() async {
    return await repository.fetchAccYear();
  }
}
