import 'package:bloc/bloc.dart';
import 'package:cristalteacher/features/timetable/domain/entities/teacher_timetable_entity.dart';
import 'package:cristalteacher/features/timetable/domain/parameters/fetch_teacher_timetable_parameter.dart';
import 'package:cristalteacher/features/timetable/domain/usecases/fetch_teacher_timetable_usecase.dart';
import 'package:equatable/equatable.dart';

part 'timetable_state.dart';

class TimetableCubit extends Cubit<TimetableState> {
  final FetchTeacherTimetableUseCase _fetchTeacherTimetableUseCase;

  TimetableCubit({
    required FetchTeacherTimetableUseCase fetchTeacherTimetableUseCase,
  }) : _fetchTeacherTimetableUseCase = fetchTeacherTimetableUseCase,
       super(TimetableInitial());

  Future<void> fetchTeacherTimetable(
    FetchTeacherTimetableParameter request,
  ) async {
    print('📅 Fetch Teacher Timetable Called');
    print('📦 Request: ${request.toJson()}');

    emit(FetchTeacherTimetableLoading());

    try {
      final result = await _fetchTeacherTimetableUseCase(request);

      result.fold(
        (failure) {
          print('❌ Fetch Teacher Timetable Failed');
          print(failure.message);

          emit(FetchTeacherTimetableFailure(failure.message));
        },
        (response) {
          print('✅ Fetch Teacher Timetable Success');
          print('📅 Timetable Count: ${response.data?.length ?? 0}');

          emit(FetchTeacherTimetableSuccess(response));
        },
      );
    } catch (e, stacktrace) {
      print('❌ Exception during fetchTeacherTimetable: $e');
      print(stacktrace);

      emit(const FetchTeacherTimetableFailure('An unexpected error occurred'));
    }
  }
}
