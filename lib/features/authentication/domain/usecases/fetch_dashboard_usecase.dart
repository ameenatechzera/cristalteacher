import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/authentication/domain/entities/fetch_school_entity.dart';
import 'package:cristalteacher/features/authentication/domain/entities/teacher_dashboard_result.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_school_parameter.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_teacherdashboard_request.dart';
import 'package:cristalteacher/features/authentication/domain/repositories/auth_repository.dart';

class FetchDashboardUseCase
    implements UseCaseWithParams<TeacherDashboardResult, TeacherDashboardRequest> {
  final AuthRepository _authRepository;

  FetchDashboardUseCase(this._authRepository);

  @override
  ResultFuture<TeacherDashboardResult> call(TeacherDashboardRequest request) async {
    return _authRepository.fetchDashboardDetails(request);
  }
}
