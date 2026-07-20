import 'package:cristalteacher/features/attendance/data/datasources/attendancedetails_remote_data_source.dart';
import 'package:cristalteacher/features/attendance/data/repositories/attendance_repository_impl.dart';
import 'package:cristalteacher/features/attendance/domain/repositories/attendancedetails_repository.dart';
import 'package:cristalteacher/features/attendance/domain/usecases/fetch_attendancedetails_usecase.dart';
import 'package:cristalteacher/features/attendance/domain/usecases/save_attendance_usecase.dart';
import 'package:cristalteacher/features/attendance/presentation/cubit/attendance_cubit.dart';
import 'package:cristalteacher/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:cristalteacher/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:cristalteacher/features/authentication/domain/repositories/auth_repository.dart';
import 'package:cristalteacher/features/authentication/domain/usecases/fetch_accyear_usecase.dart';
import 'package:cristalteacher/features/authentication/domain/usecases/fetch_branch_usecase.dart';
import 'package:cristalteacher/features/authentication/domain/usecases/fetch_school_usecase.dart';
import 'package:cristalteacher/features/authentication/domain/usecases/fetch_tutorshipclass_usecase.dart';
import 'package:cristalteacher/features/authentication/domain/usecases/login_usecase.dart';
import 'package:cristalteacher/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:cristalteacher/features/diary/data/datasources/diary_remote_data_source.dart';
import 'package:cristalteacher/features/diary/data/repositories/diary_repository_impl.dart';
import 'package:cristalteacher/features/diary/domain/repositories/diary_repository.dart';
import 'package:cristalteacher/features/diary/domain/usecases/fetch_diary_usecase.dart';
import 'package:cristalteacher/features/diary/presentation/cubit/diary_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Cubit
  sl.registerFactory(
    () => AuthenticationCubit(
      loginUseCase: sl(),
      fetchSchoolUseCase: sl(),
      getBranchUseCase: sl(),
      fetchTutorshipClassUseCase: sl(),
      fetchAccYearUseCase: sl(),
    ),
  );

  /// UseCase
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton<FetchSchoolUseCase>(() => FetchSchoolUseCase(sl()));

  sl.registerLazySingleton<GetBranchUseCase>(() => GetBranchUseCase(sl()));
  sl.registerLazySingleton<FetchTutorshipClassUseCase>(
    () => FetchTutorshipClassUseCase(sl()),
  );
  sl.registerLazySingleton(() => FetchAccYearUseCase(sl()));

  /// Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  /// Remote Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  sl.registerFactory<DiaryCubit>(() => DiaryCubit(fetchDiaryUseCase: sl()));

  sl.registerLazySingleton<FetchDiaryUseCase>(() => FetchDiaryUseCase(sl()));

  sl.registerLazySingleton<DiaryRepository>(() => DiaryRepositoryImpl(sl()));

  sl.registerLazySingleton<DiaryRemoteDataSource>(
    () => DiaryRemoteDataSourceImpl(),
  );

  /// ================= Attendance =================

  sl.registerFactory(
    () => AttendanceCubit(
      attendanceDetailsUseCase: sl(),
      saveAttendanceUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => AttendanceDetailsUseCase(sl()));
  sl.registerLazySingleton(() => SaveAttendanceUseCase(sl()));

  sl.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<AttendanceRemoteDataSource>(
    () => AttendanceRemoteDataSourceImpl(),
  );
}
