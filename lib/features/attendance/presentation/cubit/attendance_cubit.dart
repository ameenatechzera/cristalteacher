import 'package:bloc/bloc.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/features/attendance/domain/entities/fetch_attendancedetails_entity.dart';
import 'package:cristalteacher/features/attendance/domain/parameters/fetch_attendancedetails_parameter.dart';
import 'package:cristalteacher/features/attendance/domain/parameters/save_attendance_parameter.dart';
import 'package:cristalteacher/features/attendance/domain/usecases/fetch_attendancedetails_usecase.dart';
import 'package:cristalteacher/features/attendance/domain/usecases/save_attendance_usecase.dart';
import 'package:equatable/equatable.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final AttendanceDetailsUseCase _attendanceDetailsUseCase;
  final SaveAttendanceUseCase _saveAttendanceUseCase;

  AttendanceCubit({
    required AttendanceDetailsUseCase attendanceDetailsUseCase,
    required SaveAttendanceUseCase saveAttendanceUseCase,
  }) : _attendanceDetailsUseCase = attendanceDetailsUseCase,
       _saveAttendanceUseCase = saveAttendanceUseCase,
       super(AttendanceInitial());

  Future<void> fetchAttendanceDetails(AttendanceDetailsRequest request) async {
    print('📘 AttendanceDetailsRequest: ${request.toJson()}');

    emit(AttendanceLoading());

    try {
      final result = await _attendanceDetailsUseCase(request);

      result.fold(
        (failure) {
          print('❌ Attendance Details Failed');
          print(failure.message);

          emit(AttendanceFailure(failure.message));
        },
        (response) {
          print('✅ Attendance Details Success');

          emit(AttendanceSuccess(response));
        },
      );
    } catch (e, stacktrace) {
      print('❌ Exception during fetchAttendanceDetails: $e');
      print('Stacktrace: $stacktrace');

      emit(const AttendanceFailure('An unexpected error occurred'));
    }
  }

  Future<void> saveAttendance(SaveAttendanceRequest request) async {
    print('📘 SaveAttendanceRequest: ${request.toJson()}');

    emit(SaveAttendanceLoading());

    try {
      final result = await _saveAttendanceUseCase(request);

      result.fold(
        (failure) {
          print('❌ Save Attendance Failed');
          print(failure.message);

          emit(SaveAttendanceFailure(failure.message));
        },
        (response) {
          print('✅ Save Attendance Success');

          emit(SaveAttendanceSuccess(response));
        },
      );
    } catch (e, stacktrace) {
      print('❌ Exception during saveAttendance: $e');
      print(stacktrace);

      emit(const SaveAttendanceFailure('An unexpected error occurred'));
    }
  }
}
