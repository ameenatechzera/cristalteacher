part of 'timetable_cubit.dart';

abstract class TimetableState extends Equatable {
  const TimetableState();

  @override
  List<Object?> get props => [];
}

class TimetableInitial extends TimetableState {}

class FetchTeacherTimetableLoading extends TimetableState {}

class FetchTeacherTimetableSuccess extends TimetableState {
  final TeacherTimetableEntity response;

  const FetchTeacherTimetableSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class FetchTeacherTimetableFailure extends TimetableState {
  final String message;

  const FetchTeacherTimetableFailure(this.message);

  @override
  List<Object?> get props => [message];
}
