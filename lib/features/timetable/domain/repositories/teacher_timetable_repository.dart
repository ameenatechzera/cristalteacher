import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/timetable/domain/entities/teacher_timetable_entity.dart';
import 'package:cristalteacher/features/timetable/domain/parameters/fetch_teacher_timetable_parameter.dart';

abstract class TeacherTimetableRepository {
  ResultFuture<TeacherTimetableEntity> fetchTeacherTimetable(
    FetchTeacherTimetableParameter params,
  );
}
