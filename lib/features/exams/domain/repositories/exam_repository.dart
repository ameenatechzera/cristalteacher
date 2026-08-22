import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/exams/domain/entities/fetch_gradeplan_entity.dart';
import 'package:cristalteacher/features/exams/domain/entities/fetchexam_entity.dart';
import 'package:cristalteacher/features/exams/domain/entities/get_all_exam_entity.dart';
import 'package:cristalteacher/features/exams/domain/entities/markentry_detailsforupdate_entity.dart';
import 'package:cristalteacher/features/exams/domain/entities/save_exammarks_entiity.dart';
import 'package:cristalteacher/features/exams/domain/parameters/fetch_exam_parameter.dart';
import 'package:cristalteacher/features/exams/domain/parameters/save_exam_parameter.dart';
import 'package:cristalteacher/features/exams/domain/parameters/update_exam_parameter.dart';

abstract class ExamRepository {
  ResultFuture<FetchExamResponseEntity> fetchMarkEntry(
    FetchMarkEntryParameter params,
  );
  ResultFuture<GradePlanResponseEntity> fetchGradePlan();
  ResultFuture<GetAllExamEntity> getAllExams();
  ResultFuture<SaveExamMarksEntity> saveExamMarks(
    SaveExamMarksParameter params,
  );
  ResultFuture<MasterResponseModel> deleteExamMark(int id);
  ResultFuture<MasterResponseModel> updateMarkEntry(
    UpdateMarkEntryParameter params,
  );
  ResultFuture<MarkEntryDetailsEntity> fetchMarkEntryDetails(int markEntryId);
}
