part of 'workplan_cubit.dart';

abstract class WorkplanState extends Equatable {
  const WorkplanState();

  @override
  List<Object?> get props => [];
}

class WorkplanInitial extends WorkplanState {}

class FetchWorkPlanLoading extends WorkplanState {}

class FetchWorkPlanSuccess extends WorkplanState {
  final WorkPlanResponseEntity response;

  const FetchWorkPlanSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class FetchWorkPlanFailure extends WorkplanState {
  final String message;

  const FetchWorkPlanFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class FetchWorkPlanDetailsLoading extends WorkplanState {}

class FetchWorkPlanDetailsSuccess extends WorkplanState {
  final WorkPlanDetailsResponseEntity response;

  const FetchWorkPlanDetailsSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class FetchWorkPlanDetailsFailure extends WorkplanState {
  final String message;

  const FetchWorkPlanDetailsFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class SaveWorkPlanLoading extends WorkplanState {}

class SaveWorkPlanSuccess extends WorkplanState {
  final MasterResponseModel response;

  const SaveWorkPlanSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class SaveWorkPlanFailure extends WorkplanState {
  final String message;

  const SaveWorkPlanFailure(this.message);

  @override
  List<Object?> get props => [message];
}
