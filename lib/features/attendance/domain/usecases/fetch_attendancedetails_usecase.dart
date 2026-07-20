import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/attendance/domain/entities/fetch_attendancedetails_entity.dart';
import 'package:cristalteacher/features/attendance/domain/parameters/fetch_attendancedetails_parameter.dart';
import 'package:cristalteacher/features/attendance/domain/repositories/attendancedetails_repository.dart';

class AttendanceDetailsUseCase
    implements
        UseCaseWithParams<AttendanceDetailsEntity, AttendanceDetailsRequest> {
  final AttendanceRepository _attendanceRepository;

  AttendanceDetailsUseCase(this._attendanceRepository);

  @override
  ResultFuture<AttendanceDetailsEntity> call(
    AttendanceDetailsRequest request,
  ) async {
    return _attendanceRepository.fetchAttendanceDetails(request);
  }
}
