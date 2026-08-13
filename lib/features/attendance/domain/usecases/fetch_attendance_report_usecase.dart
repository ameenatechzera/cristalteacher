import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/attendance/domain/entities/attendance_report_entity.dart';
import 'package:cristalteacher/features/attendance/domain/parameters/attendance_report_parameter.dart';
import 'package:cristalteacher/features/attendance/domain/repositories/attendancedetails_repository.dart';

class FetchAttendanceReportUseCase
    implements
        UseCaseWithParams<AttendanceReportEntity, AttendanceReportParameter> {
  final AttendanceRepository _attendanceRepository;

  FetchAttendanceReportUseCase(this._attendanceRepository);

  @override
  ResultFuture<AttendanceReportEntity> call(
    AttendanceReportParameter params,
  ) async {
    return _attendanceRepository.fetchAttendanceReport(params);
  }
}
