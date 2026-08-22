import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/earlygoing/domain/entities/gatepass_entity.dart';
import 'package:cristalteacher/features/earlygoing/domain/parameter/gatepass_parameter.dart';
import 'package:cristalteacher/features/earlygoing/domain/repositories/gatepass_repository.dart';

class FetchGatePassUseCase
    implements UseCaseWithParams<GatePassEntity, FetchGatePassParameter> {
  final GatePassRepository _gatePassRepository;

  FetchGatePassUseCase(this._gatePassRepository);

  @override
  ResultFuture<GatePassEntity> call(FetchGatePassParameter params) {
    return _gatePassRepository.fetchGatePass(params);
  }
}
