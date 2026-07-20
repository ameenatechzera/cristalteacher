import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/authentication/domain/entities/class_details_entity.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_tutorshipclass_parameter.dart';
import 'package:cristalteacher/features/authentication/domain/repositories/auth_repository.dart';

class FetchTutorshipClassUseCase
    implements
        UseCaseWithParams<
          FetchTutorshipClassEntity,
          FetchTutorshipClassRequest
        > {
  final AuthRepository _authRepository;

  FetchTutorshipClassUseCase(this._authRepository);

  @override
  ResultFuture<FetchTutorshipClassEntity> call(
    FetchTutorshipClassRequest request,
  ) async {
    return _authRepository.fetchTutorshipClass(request);
  }
}
