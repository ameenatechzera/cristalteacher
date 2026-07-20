import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/attendance/domain/entities/fetch_attendancedetails_entity.dart';
import 'package:cristalteacher/features/attendance/domain/parameters/fetch_attendancedetails_parameter.dart';
import 'package:cristalteacher/features/attendance/domain/parameters/save_attendance_parameter.dart';

abstract class AttendanceRepository {
  ResultFuture<AttendanceDetailsEntity> fetchAttendanceDetails(
    AttendanceDetailsRequest request,
  );
  ResultFuture<MasterResponseModel> saveAttendance(
    SaveAttendanceRequest request,
  );
}
