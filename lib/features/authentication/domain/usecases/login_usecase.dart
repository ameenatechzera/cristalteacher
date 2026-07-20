import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/authentication/domain/entities/login_entity.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/login_parameter.dart';
import 'package:cristalteacher/features/authentication/domain/repositories/auth_repository.dart';

class LoginUseCase implements UseCaseWithParams<LoginEntity, LoginRequest> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  ResultFuture<LoginEntity> call(LoginRequest request) async {
    return _authRepository.login(request);
  }
}
