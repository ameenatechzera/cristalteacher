import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/attendance/domain/entities/studentattendance_response_enttiy.dart';
import 'package:cristalteacher/features/attendance/domain/repositories/attendancedetails_repository.dart';

class FetchStudentAttendanceUseCase {
  final AttendanceRepository _repository;

  FetchStudentAttendanceUseCase(this._repository);

  ResultFuture<StudentAttendanceResponseEntity> call(int studentId) {
    return _repository.fetchStudentAttendance(studentId);
  }
}
