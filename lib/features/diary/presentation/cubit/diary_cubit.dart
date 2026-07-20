import 'package:bloc/bloc.dart';
import 'package:cristalteacher/features/diary/domain/entities/diary_entity.dart';
import 'package:cristalteacher/features/diary/domain/parameters/fetch_diary_parameter.dart';
import 'package:cristalteacher/features/diary/domain/usecases/fetch_diary_usecase.dart';
import 'package:equatable/equatable.dart';

part 'diary_state.dart';

class DiaryCubit extends Cubit<DiaryState> {
  final FetchDiaryUseCase _fetchDiaryUseCase;

  DiaryCubit({required FetchDiaryUseCase fetchDiaryUseCase})
    : _fetchDiaryUseCase = fetchDiaryUseCase,
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
}
