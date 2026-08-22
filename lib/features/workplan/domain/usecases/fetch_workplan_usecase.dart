import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/workplan/domain/entities/workplan_response_entity.dart';
import 'package:cristalteacher/features/workplan/domain/parameters/fetch_workplan_parameter.dart';
import 'package:cristalteacher/features/workplan/domain/repositories/workplan_repository.dart';

class FetchWorkPlanUseCase
    implements
        UseCaseWithParams<WorkPlanResponseEntity, FetchWorkPlanParameter> {
  final WorkPlanRepository _workPlanRepository;

  FetchWorkPlanUseCase(this._workPlanRepository);

  @override
  ResultFuture<WorkPlanResponseEntity> call(FetchWorkPlanParameter params) {
    return _workPlanRepository.fetchWorkPlans(params);
  }
}
