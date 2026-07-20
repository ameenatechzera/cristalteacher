import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/authentication/domain/entities/fetch_branch_entity.dart';
import 'package:cristalteacher/features/authentication/domain/repositories/auth_repository.dart';

class GetBranchUseCase implements UseCaseWithoutParams<GetBranchEntity> {
  final AuthRepository _authRepository;

  GetBranchUseCase(this._authRepository);

  @override
  ResultFuture<GetBranchEntity> call() async {
    return _authRepository.getBranchDetails();
  }
}
