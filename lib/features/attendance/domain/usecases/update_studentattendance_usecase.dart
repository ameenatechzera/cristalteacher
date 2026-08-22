import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/attendance/domain/parameters/update_studentattendance_parameter.dart';
import 'package:cristalteacher/features/attendance/domain/repositories/attendancedetails_repository.dart';

class UpdateStudentAttendanceUseCase {
  final AttendanceRepository _attendanceRepository;

  UpdateStudentAttendanceUseCase(this._attendanceRepository);

  ResultFuture<MasterResponseModel> call(
    UpdateStudentAttendanceParameter params,
    int id,
  ) async {
    return _attendanceRepository.updateStudentAttendance(params, id);
  }
}
