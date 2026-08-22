import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/workplan/domain/parameters/save_workplan_parameter.dart';
import 'package:cristalteacher/features/workplan/domain/repositories/workplan_repository.dart';

class SaveWorkPlanUseCase
    implements UseCaseWithParams<MasterResponseModel, SaveWorkPlanParameter> {
  final WorkPlanRepository _workPlanRepository;

  SaveWorkPlanUseCase(this._workPlanRepository);

  @override
  ResultFuture<MasterResponseModel> call(SaveWorkPlanParameter params) {
    return _workPlanRepository.saveWorkPlan(params);
  }
}
