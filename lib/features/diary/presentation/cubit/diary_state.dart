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
