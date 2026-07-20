import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/authentication/domain/entities/fetch_school_entity.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_school_parameter.dart';
import 'package:cristalteacher/features/authentication/domain/repositories/auth_repository.dart';

class FetchSchoolUseCase
    implements UseCaseWithParams<FetchSchoolEntity, FetchSchoolRequest> {
  final AuthRepository _authRepository;

  FetchSchoolUseCase(this._authRepository);

  @override
  ResultFuture<FetchSchoolEntity> call(FetchSchoolRequest request) async {
    return _authRepository.fetchSchools(request);
  }
}
