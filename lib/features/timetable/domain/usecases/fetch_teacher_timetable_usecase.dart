import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/timetable/domain/entities/teacher_timetable_entity.dart';
import 'package:cristalteacher/features/timetable/domain/parameters/fetch_teacher_timetable_parameter.dart';
import 'package:cristalteacher/features/timetable/domain/repositories/teacher_timetable_repository.dart';

class FetchTeacherTimetableUseCase
    implements
        UseCaseWithParams<
          TeacherTimetableEntity,
          FetchTeacherTimetableParameter
        > {
  final TeacherTimetableRepository _teacherTimetableRepository;

  FetchTeacherTimetableUseCase(this._teacherTimetableRepository);

  @override
  ResultFuture<TeacherTimetableEntity> call(
    FetchTeacherTimetableParameter params,
  ) {
    return _teacherTimetableRepository.fetchTeacherTimetable(params);
  }
}
