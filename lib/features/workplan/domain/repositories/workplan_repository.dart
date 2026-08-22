import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/workplan/domain/entities/workplan_response_entity.dart';
import 'package:cristalteacher/features/workplan/domain/entities/workplandetails_response_entity.dart';
import 'package:cristalteacher/features/workplan/domain/parameters/fetch_workplan_parameter.dart';
import 'package:cristalteacher/features/workplan/domain/parameters/fetch_workplandetails_parameter.dart';
import 'package:cristalteacher/features/workplan/domain/parameters/save_workplan_parameter.dart';

abstract class WorkPlanRepository {
  ResultFuture<WorkPlanResponseEntity> fetchWorkPlans(
    FetchWorkPlanParameter params,
  );
  ResultFuture<WorkPlanDetailsResponseEntity> fetchWorkPlanDetails(
    FetchWorkPlanDetailsParameter params,
  );
  ResultFuture<MasterResponseModel> saveWorkPlan(SaveWorkPlanParameter params);
}
