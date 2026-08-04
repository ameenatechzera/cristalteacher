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
import 'package:cristalteacher/features/diary/domain/usecases/save_diary_usecase.dart';
import 'package:cristalteacher/features/diary/presentation/cubit/diary_cubit.dart';
import 'package:cristalteacher/features/feed/data/datasources/feed_remote_data_source.dart';
import 'package:cristalteacher/features/feed/data/repositories/feed_repository_impl.dart';
import 'package:cristalteacher/features/feed/domain/repository/feed_repository.dart';
import 'package:cristalteacher/features/feed/domain/usecases/fetch_feed_usecase.dart';
import 'package:cristalteacher/features/feed/domain/usecases/save_feed_usecase.dart';
import 'package:cristalteacher/features/feed/presentation/cubit/feed_cubit.dart';
import 'package:cristalteacher/features/materials/data/datasources/materials_remote_data_source.dart';
import 'package:cristalteacher/features/materials/data/repositories/material_repository_impl.dart.dart';
import 'package:cristalteacher/features/materials/domain/repository/material_repository.dart';
import 'package:cristalteacher/features/materials/domain/usecases/fetch_material_usecase.dart';
import 'package:cristalteacher/features/materials/domain/usecases/save_material_usecase.dart';
import 'package:cristalteacher/features/materials/presentation/cubit/material_cubit.dart';
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

  sl.registerFactory<DiaryCubit>(
    () => DiaryCubit(fetchDiaryUseCase: sl(), saveDiaryUseCase: sl()),
  );

  sl.registerLazySingleton<FetchDiaryUseCase>(() => FetchDiaryUseCase(sl()));
  sl.registerLazySingleton<SaveDiaryUseCase>(() => SaveDiaryUseCase(sl()));

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

  /// ================= Feed =================

  sl.registerFactory(
    () => FeedCubit(fetchFeedUseCase: sl(), saveFeedUseCase: sl()),
  );

  sl.registerLazySingleton(() => FetchFeedUseCase(sl()));
  sl.registerLazySingleton(() => SaveFeedUseCase(sl()));

  sl.registerLazySingleton<FeedRepository>(() => FeedRepositoryImpl(sl()));

  sl.registerLazySingleton<FeedRemoteDataSource>(
    () => FeedRemoteDataSourceImpl(),
  );

  /// Cubit
  sl.registerFactory(
    () => MaterialCubit(fetchMaterialUseCase: sl(), saveMaterialUseCase: sl()),
  );

  /// UseCase
  sl.registerLazySingleton(() => FetchMaterialUseCase(sl()));
  sl.registerLazySingleton(() => SaveMaterialUseCase(sl()));

  /// Repository
  sl.registerLazySingleton<MaterialRepository>(
    () => MaterialRepositoryImpl(remoteDataSource: sl()),
  );

  /// Remote Data Source
  sl.registerLazySingleton<MaterialRemoteDataSource>(
    () => MaterialRemoteDataSourceImpl(),
  );
}
