part of 'exam_cubit.dart';

sealed class ExamState extends Equatable {
  const ExamState();

  @override
  List<Object> get props => [];
}

final class ExamInitial extends ExamState {}

class ExamLoading extends ExamState {}

class ExamSuccess extends ExamState {
  final FetchExamResponseEntity response;

  const ExamSuccess(this.response);
}

class ExamFailure extends ExamState {
  final String message;

  const ExamFailure(this.message);
}

class FetchGradePlanLoading extends ExamState {}

class FetchGradePlanSuccess extends ExamState {
  final GradePlanResponseEntity response;

  const FetchGradePlanSuccess(this.response);
}

class FetchGradePlanFailure extends ExamState {
  final String message;

  const FetchGradePlanFailure(this.message);
}

class GetAllExamLoading extends ExamState {}

class GetAllExamSuccess extends ExamState {
  final GetAllExamEntity response;

  const GetAllExamSuccess(this.response);
}

class GetAllExamFailure extends ExamState {
  final String message;

  const GetAllExamFailure(this.message);
}

class SaveExamMarksLoading extends ExamState {}

class SaveExamMarksSuccess extends ExamState {
  final SaveExamMarksEntity response;

  const SaveExamMarksSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class SaveExamMarksFailure extends ExamState {
  final String message;

  const SaveExamMarksFailure(this.message);

  @override
  List<Object> get props => [message];
}
// ============================================================
// DELETE EXAM MARK
// ============================================================

class DeleteExamMarkLoading extends ExamState {}

class DeleteExamMarkSuccess extends ExamState {
  final MasterResponseModel response;

  const DeleteExamMarkSuccess(this.response);
}

class DeleteExamMarkFailure extends ExamState {
  final String message;

  const DeleteExamMarkFailure(this.message);
}

class UpdateMarkEntryLoading extends ExamState {
  const UpdateMarkEntryLoading();
}

class UpdateMarkEntrySuccess extends ExamState {
  final MasterResponseModel response;

  const UpdateMarkEntrySuccess(this.response);
}

class UpdateMarkEntryFailure extends ExamState {
  final String message;

  const UpdateMarkEntryFailure(this.message);
}
