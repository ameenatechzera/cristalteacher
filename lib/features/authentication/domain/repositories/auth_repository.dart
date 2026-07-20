import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/authentication/domain/entities/class_details_entity.dart';
import 'package:cristalteacher/features/authentication/domain/entities/fetch_accyear_entity.dart';
import 'package:cristalteacher/features/authentication/domain/entities/fetch_branch_entity.dart';
import 'package:cristalteacher/features/authentication/domain/entities/fetch_school_entity.dart';
import 'package:cristalteacher/features/authentication/domain/entities/login_entity.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_school_parameter.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/fetch_tutorshipclass_parameter.dart';
import 'package:cristalteacher/features/authentication/domain/parameters/login_parameter.dart';

abstract class AuthRepository {
  ResultFuture<LoginEntity> login(LoginRequest request);
  ResultFuture<FetchSchoolEntity> fetchSchools(FetchSchoolRequest request);
  ResultFuture<GetBranchEntity> getBranchDetails();
  ResultFuture<FetchTutorshipClassEntity> fetchTutorshipClass(
    FetchTutorshipClassRequest request,
  );
  ResultFuture<FetchAccYearEntity> fetchAccYear();
}
