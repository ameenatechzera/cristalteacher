import 'package:bloc/bloc.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/features/workplan/domain/entities/workplan_response_entity.dart';
import 'package:cristalteacher/features/workplan/domain/entities/workplandetails_response_entity.dart';
import 'package:cristalteacher/features/workplan/domain/parameters/fetch_workplan_parameter.dart';
import 'package:cristalteacher/features/workplan/domain/parameters/fetch_workplandetails_parameter.dart';
import 'package:cristalteacher/features/workplan/domain/parameters/save_workplan_parameter.dart';
import 'package:cristalteacher/features/workplan/domain/usecases/fetch_workplan_usecase.dart';
import 'package:cristalteacher/features/workplan/domain/usecases/fetch_workplandetails_usecase.dart';
import 'package:cristalteacher/features/workplan/domain/usecases/save_workplan_usecase.dart';
import 'package:equatable/equatable.dart';

part 'workplan_state.dart';

class WorkplanCubit extends Cubit<WorkplanState> {
  final FetchWorkPlanUseCase _fetchWorkPlanUseCase;
  final FetchWorkPlanDetailsUseCase _fetchWorkPlanDetailsUseCase;
  final SaveWorkPlanUseCase _saveWorkPlanUseCase;

  WorkplanCubit({
    required FetchWorkPlanUseCase fetchWorkPlanUseCase,
    required FetchWorkPlanDetailsUseCase fetchWorkPlanDetailsUseCase,
    required SaveWorkPlanUseCase saveWorkPlanUseCase,
  }) : _fetchWorkPlanUseCase = fetchWorkPlanUseCase,
       _fetchWorkPlanDetailsUseCase = fetchWorkPlanDetailsUseCase,
       _saveWorkPlanUseCase = saveWorkPlanUseCase,
       super(WorkplanInitial());

  Future<void> fetchWorkPlans(FetchWorkPlanParameter request) async {
    emit(FetchWorkPlanLoading());

    try {
      final result = await _fetchWorkPlanUseCase(request);

      result.fold(
        (failure) {
          emit(FetchWorkPlanFailure(failure.message));
        },
        (response) {
          emit(FetchWorkPlanSuccess(response));
        },
      );
    } catch (error, stackTrace) {
      print('Exception during fetchWorkPlans: $error');
      print(stackTrace);

      emit(const FetchWorkPlanFailure('An unexpected error occurred'));
    }
  }

  Future<void> fetchWorkPlanDetails(
    FetchWorkPlanDetailsParameter request,
  ) async {
    emit(FetchWorkPlanDetailsLoading());

    try {
      final result = await _fetchWorkPlanDetailsUseCase(request);

      result.fold(
        (failure) {
          emit(FetchWorkPlanDetailsFailure(failure.message));
        },
        (response) {
          emit(FetchWorkPlanDetailsSuccess(response));
        },
      );
    } catch (error, stackTrace) {
      print(
        'Exception during fetchWorkPlanDetails: '
        '$error',
      );
      print(stackTrace);

      emit(const FetchWorkPlanDetailsFailure('An unexpected error occurred'));
    }
  }

  Future<void> saveWorkPlan(SaveWorkPlanParameter request) async {
    emit(SaveWorkPlanLoading());

    try {
      final result = await _saveWorkPlanUseCase(request);

      result.fold(
        (failure) {
          emit(SaveWorkPlanFailure(failure.message));
        },
        (response) {
          emit(SaveWorkPlanSuccess(response));
        },
      );
    } catch (_) {
      emit(const SaveWorkPlanFailure('An unexpected error occurred'));
    }
  }
}
