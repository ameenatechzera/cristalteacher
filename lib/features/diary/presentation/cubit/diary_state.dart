part of 'diary_cubit.dart';

sealed class DiaryState extends Equatable {
  const DiaryState();

  @override
  List<Object> get props => [];
}

final class DiaryInitial extends DiaryState {}

final class DiaryLoading extends DiaryState {}

final class DiarySuccess extends DiaryState {
  final DiaryResponseEntity response;

  const DiarySuccess(this.response);
}

final class DiaryFailure extends DiaryState {
  final String message;

  const DiaryFailure(this.message);
}

class SaveDiaryLoading extends DiaryState {}

class SaveDiarySuccess extends DiaryState {
  final MasterResponseModel response;

  const SaveDiarySuccess(this.response);
}

class SaveDiaryFailure extends DiaryState {
  final String message;

  const SaveDiaryFailure(this.message);
}

class DeleteDiaryLoading extends DiaryState {}

class DeleteDiarySuccess extends DiaryState {
  final MasterResponseModel response;

  const DeleteDiarySuccess(this.response);
}

class DeleteDiaryFailure extends DiaryState {
  final String message;

  const DeleteDiaryFailure(this.message);
}
