import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/workplan/domain/entities/workplandetails_response_entity.dart';
import 'package:cristalteacher/features/workplan/domain/parameters/fetch_workplandetails_parameter.dart';
import 'package:cristalteacher/features/workplan/domain/repositories/workplan_repository.dart';

class FetchWorkPlanDetailsUseCase
    implements
        UseCaseWithParams<
          WorkPlanDetailsResponseEntity,
          FetchWorkPlanDetailsParameter
        > {
  final WorkPlanRepository _workPlanRepository;

  FetchWorkPlanDetailsUseCase(this._workPlanRepository);

  @override
  ResultFuture<WorkPlanDetailsResponseEntity> call(
    FetchWorkPlanDetailsParameter params,
  ) {
    return _workPlanRepository.fetchWorkPlanDetails(params);
  }
}
