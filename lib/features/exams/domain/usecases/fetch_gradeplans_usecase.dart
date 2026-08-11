import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/exams/domain/entities/fetch_gradeplan_entity.dart';
import 'package:cristalteacher/features/exams/domain/repositories/exam_repository.dart';

class FetchGradePlanUseCase
    implements UseCaseWithoutParams<GradePlanResponseEntity> {
  final ExamRepository _examRepository;

  FetchGradePlanUseCase(this._examRepository);

  @override
  ResultFuture<GradePlanResponseEntity> call() async {
    return _examRepository.fetchGradePlan();
  }
}
