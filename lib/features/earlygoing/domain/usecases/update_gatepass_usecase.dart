import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/earlygoing/domain/parameter/update_gatepass_parameter.dart';
import 'package:cristalteacher/features/earlygoing/domain/repositories/gatepass_repository.dart';

class UpdateGatePassUseCase {
  final GatePassRepository _gatePassRepository;

  UpdateGatePassUseCase(this._gatePassRepository);

  ResultFuture<MasterResponseModel> call(
    UpdateGatePassParameter params,
    int id,
  ) {
    return _gatePassRepository.updateGatePass(params, id);
  }
}
