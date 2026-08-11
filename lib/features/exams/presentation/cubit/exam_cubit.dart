import 'package:bloc/bloc.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/features/exams/domain/entities/fetch_gradeplan_entity.dart';
import 'package:cristalteacher/features/exams/domain/entities/fetchexam_entity.dart';
import 'package:cristalteacher/features/exams/domain/entities/get_all_exam_entity.dart';
import 'package:cristalteacher/features/exams/domain/entities/save_exammarks_entiity.dart';
import 'package:cristalteacher/features/exams/domain/parameters/fetch_exam_parameter.dart';
import 'package:cristalteacher/features/exams/domain/parameters/save_exam_parameter.dart';
import 'package:cristalteacher/features/exams/domain/usecases/delete_exam_usecase.dart';
import 'package:cristalteacher/features/exams/domain/usecases/fetch_exam_usecase.dart';
import 'package:cristalteacher/features/exams/domain/usecases/fetch_gradeplans_usecase.dart';
import 'package:cristalteacher/features/exams/domain/usecases/get_all_exams_usecase.dart';
import 'package:cristalteacher/features/exams/domain/usecases/save_exammarks_usecase.dart';
import 'package:equatable/equatable.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  final FetchExamUseCase _fetchExamUseCase;
  final FetchGradePlanUseCase _fetchGradePlanUseCase;
  final GetAllExamUseCase _getAllExamUseCase;
  final SaveExamMarksUseCase _saveExamMarksUseCase;
  final DeleteExamMarkUseCase _deleteExamMarkUseCase;
  ExamCubit({
    required FetchExamUseCase fetchExamUseCase,
    required FetchGradePlanUseCase fetchGradePlanUseCase,
    required GetAllExamUseCase getAllExamUseCase,
    required SaveExamMarksUseCase saveExamMarksUseCase,
    required DeleteExamMarkUseCase deleteExamMarkUseCase,
  }) : _fetchExamUseCase = fetchExamUseCase,
       _fetchGradePlanUseCase = fetchGradePlanUseCase,
       _getAllExamUseCase = getAllExamUseCase,
       _saveExamMarksUseCase = saveExamMarksUseCase,
       _deleteExamMarkUseCase = deleteExamMarkUseCase,
       super(ExamInitial());
  Future<void> fetchMarkEntry(FetchMarkEntryParameter request) async {
    print('📘 FetchMarkEntryRequest: ${request.toJson()}');

    emit(ExamLoading());

    try {
      final result = await _fetchExamUseCase(request);

      result.fold(
        (failure) {
          print('❌ Fetch Mark Entry Failed');
          print(failure.message);

          emit(ExamFailure(failure.message));
        },
        (response) {
          print('✅ Fetch Mark Entry Success');

          emit(ExamSuccess(response));
        },
      );
    } catch (e, stacktrace) {
      print('❌ Exception during fetchMarkEntry: $e');
      print(stacktrace);

      emit(const ExamFailure('An unexpected error occurred'));
    }
  }

  Future<void> fetchGradePlan() async {
    print('📘 Fetch Grade Plan');

    emit(FetchGradePlanLoading());

    try {
      final result = await _fetchGradePlanUseCase();

      result.fold(
        (failure) {
          print('❌ Fetch Grade Plan Failed');
          print(failure.message);

          emit(FetchGradePlanFailure(failure.message));
        },
        (response) {
          print('✅ Fetch Grade Plan Success');

          emit(FetchGradePlanSuccess(response));
        },
      );
    } catch (e, stacktrace) {
      print('❌ Exception during fetchGradePlan: $e');
      print(stacktrace);

      emit(const FetchGradePlanFailure('An unexpected error occurred'));
    }
  }

  Future<void> getAllExams() async {
    print('📘 Get All Exams');

    emit(GetAllExamLoading());

    try {
      final result = await _getAllExamUseCase();

      result.fold(
        (failure) {
          print('❌ Get All Exams Failed');
          print(failure.message);

          emit(GetAllExamFailure(failure.message));
        },
        (response) {
          print('✅ Get All Exams Success');

          emit(GetAllExamSuccess(response));
        },
      );
    } catch (e, stacktrace) {
      print('❌ Exception during getAllExams: $e');
      print(stacktrace);

      emit(const GetAllExamFailure('An unexpected error occurred'));
    }
  }

  Future saveExamMarks(SaveExamMarksParameter request) async {
    print('📘 SaveExamMarksRequest: ${request.toJson()}');

    emit(SaveExamMarksLoading());

    try {
      final result = await _saveExamMarksUseCase(request);

      result.fold(
        (failure) {
          print('❌ Save Exam Marks Failed');
          print(failure.message);

          emit(SaveExamMarksFailure(failure.message));
        },
        (response) {
          print('✅ Save Exam Marks Success');

          emit(SaveExamMarksSuccess(response));
        },
      );
    } catch (e, stacktrace) {
      print('❌ Exception during saveExamMarks: $e');
      print(stacktrace);

      emit(const SaveExamMarksFailure('An unexpected error occurred'));
    }
  } // ============================================================
  // DELETE EXAM MARK
  // ============================================================

  Future<void> deleteExamMark(int id) async {
    print('🗑️ Delete Exam Mark');
    print('Exam Mark ID: $id');

    emit(DeleteExamMarkLoading());

    try {
      final result = await _deleteExamMarkUseCase(id);

      result.fold(
        (failure) {
          print('❌ Delete Exam Mark Failed');
          print(failure.message);

          emit(DeleteExamMarkFailure(failure.message));
        },
        (response) {
          print('✅ Delete Exam Mark Success');

          emit(DeleteExamMarkSuccess(response));
        },
      );
    } catch (e, stacktrace) {
      print('❌ Exception during deleteExamMark: $e');
      print(stacktrace);

      emit(const DeleteExamMarkFailure('An unexpected error occurred'));
    }
  }
}
