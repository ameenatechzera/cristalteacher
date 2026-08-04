import 'package:bloc/bloc.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/features/diary/domain/entities/diary_entity.dart';
import 'package:cristalteacher/features/diary/domain/parameters/fetch_diary_parameter.dart';
import 'package:cristalteacher/features/diary/domain/parameters/save_diary_parameter.dart';
import 'package:cristalteacher/features/diary/domain/usecases/fetch_diary_usecase.dart';
import 'package:cristalteacher/features/diary/domain/usecases/save_diary_usecase.dart';
import 'package:equatable/equatable.dart';

part 'diary_state.dart';

class DiaryCubit extends Cubit<DiaryState> {
  final FetchDiaryUseCase _fetchDiaryUseCase;
  final SaveDiaryUseCase _saveDiaryUseCase;

  DiaryCubit({
    required FetchDiaryUseCase fetchDiaryUseCase,
    required SaveDiaryUseCase saveDiaryUseCase,
  }) : _fetchDiaryUseCase = fetchDiaryUseCase,
       _saveDiaryUseCase = saveDiaryUseCase,
       super(DiaryInitial());

  //   Future<void> fetchDiary(FetchDiaryParameter request) async {
  //     print('📘 Fetch Diary Request: ${request.toJson()}');

  //     emit(DiaryLoading());

  //     try {
  //       final result = await _fetchDiaryUseCase(request);

  //       result.fold(
  //         (failure) {
  //           print('❌ Fetch Diary Failed');
  //           print(failure.message);

  //           emit(DiaryFailure(failure.message));
  //         },
  //         (response) {
  //           emit(DiarySuccess(response));
  //         },
  //       );
  //     } catch (e, stackTrace) {
  //       print('❌ Exception during Fetch Diary');
  //       print(e);
  //       print(stackTrace);

  //       emit(const DiaryFailure('An unexpected error occurred'));
  //     }
  //   }
  // }
  Future<void> fetchDiary(FetchDiaryParameter request) async {
    print('📘 Fetch Diary Request: ${request.toJson()}');

    emit(DiaryLoading());

    try {
      final result = await _fetchDiaryUseCase(request);

      result.fold(
        (failure) {
          print('❌ Fetch Diary Failed');
          print(failure.message);

          emit(DiaryFailure(failure.message));
        },
        (response) {
          print('✅ Diary count: ${response.data?.length ?? 0}');

          emit(DiarySuccess(response));
        },
      );
    } catch (e, stackTrace) {
      print('❌ Exception during Fetch Diary');
      print(e);
      print(stackTrace);

      emit(const DiaryFailure('An unexpected error occurred'));
    }
  }

  Future<void> saveDiary(SaveDiaryParameter request) async {
    print('📘 Save Diary Request: ${request.toJson()}');

    emit(SaveDiaryLoading());

    try {
      final result = await _saveDiaryUseCase(request);

      result.fold(
        (failure) {
          print('❌ Save Diary Failed');
          print(failure.message);

          emit(DiaryFailure(failure.message));
        },
        (response) {
          print('✅ Save Diary Success');
          print('Status: ${response.status}');
          print('Message: ${response.error}');

          emit(SaveDiarySuccess(response));
        },
      );
    } catch (e, stackTrace) {
      print('❌ Exception during Save Diary');
      print(e);
      print(stackTrace);

      emit(const DiaryFailure('An unexpected error occurred'));
    }
  }
}
