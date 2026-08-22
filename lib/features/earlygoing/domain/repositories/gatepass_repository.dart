import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/earlygoing/domain/entities/gatepass_entity.dart';
import 'package:cristalteacher/features/earlygoing/domain/parameter/gatepass_parameter.dart';
import 'package:cristalteacher/features/earlygoing/domain/parameter/update_gatepass_parameter.dart';

abstract class GatePassRepository {
  ResultFuture<GatePassEntity> fetchGatePass(FetchGatePassParameter params);
  ResultFuture<MasterResponseModel> updateGatePass(
    UpdateGatePassParameter params,
    int id,
  );
}
