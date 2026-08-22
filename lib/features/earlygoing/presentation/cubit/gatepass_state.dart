part of 'gatepass_cubit.dart';

abstract class GatepassState extends Equatable {
  const GatepassState();

  @override
  List<Object?> get props => [];
}

class GatepassInitial extends GatepassState {}

class GatepassLoading extends GatepassState {}

class GatepassSuccess extends GatepassState {
  final GatePassEntity response;

  const GatepassSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class GatepassFailure extends GatepassState {
  final String message;

  const GatepassFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateGatePassLoading extends GatepassState {}

class UpdateGatePassSuccess extends GatepassState {
  final MasterResponseModel response;

  const UpdateGatePassSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class UpdateGatePassFailure extends GatepassState {
  final String message;

  const UpdateGatePassFailure(this.message);

  @override
  List<Object?> get props => [message];
}
