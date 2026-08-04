part of 'material_cubit.dart';

sealed class MaterialState extends Equatable {
  const MaterialState();

  @override
  List<Object?> get props => [];
}

final class MaterialInitial extends MaterialState {}

final class FetchMaterialLoading extends MaterialState {}

final class FetchMaterialSuccess extends MaterialState {
  final FetchMaterialEntity response;

  const FetchMaterialSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

final class FetchMaterialFailure extends MaterialState {
  final String message;

  const FetchMaterialFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Save Material
class SaveMaterialLoading extends MaterialState {}

class SaveMaterialSuccess extends MaterialState {
  final MasterResponseModel response;

  const SaveMaterialSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class SaveMaterialFailure extends MaterialState {
  final String message;

  const SaveMaterialFailure(this.message);

  @override
  List<Object?> get props => [message];
}
