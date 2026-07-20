import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/attendance/domain/parameters/save_attendance_parameter.dart';
import 'package:cristalteacher/features/attendance/domain/repositories/attendancedetails_repository.dart';

class SaveAttendanceUseCase
    implements UseCaseWithParams<MasterResponseModel, SaveAttendanceRequest> {
  final AttendanceRepository _attendanceRepository;

  SaveAttendanceUseCase(this._attendanceRepository);

  @override
  ResultFuture<MasterResponseModel> call(SaveAttendanceRequest request) async {
    return _attendanceRepository.saveAttendance(request);
  }
}
