part of 'attendance_cubit.dart';

sealed class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

final class AttendanceInitial extends AttendanceState {}

final class AttendanceLoading extends AttendanceState {}

final class AttendanceSuccess extends AttendanceState {
  final AttendanceDetailsEntity response;

  const AttendanceSuccess(this.response);
}

final class AttendanceFailure extends AttendanceState {
  final String message;

  const AttendanceFailure(this.message);
}

class SaveAttendanceLoading extends AttendanceState {}

class SaveAttendanceSuccess extends AttendanceState {
  final MasterResponseModel response;

  const SaveAttendanceSuccess(this.response);
}

class SaveAttendanceFailure extends AttendanceState {
  final String message;

  const SaveAttendanceFailure(this.message);
}
