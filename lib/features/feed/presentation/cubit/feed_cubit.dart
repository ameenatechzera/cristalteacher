import 'package:bloc/bloc.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/features/feed/domain/parameters/save_feed_parameter.dart';
import 'package:cristalteacher/features/feed/domain/usecases/delete_feed_usecase.dart';
import 'package:cristalteacher/features/feed/domain/usecases/save_feed_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:cristalteacher/features/feed/domain/entities/fetch_feed_entity.dart';
import 'package:cristalteacher/features/feed/domain/parameters/fetch_feed_parameter.dart';
import 'package:cristalteacher/features/feed/domain/usecases/fetch_feed_usecase.dart';

part 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  final FetchFeedUseCase _fetchFeedUseCase;
  final SaveFeedUseCase _saveFeedUseCase;
  final DeleteFeedUseCase _deleteFeedUseCase;

  FeedCubit({
    required FetchFeedUseCase fetchFeedUseCase,
    required SaveFeedUseCase saveFeedUseCase,
    required DeleteFeedUseCase deleteFeedUseCase,
  }) : _fetchFeedUseCase = fetchFeedUseCase,
       _saveFeedUseCase = saveFeedUseCase,
       _deleteFeedUseCase = deleteFeedUseCase,
       super(FeedInitial());

  Future<void> fetchFeed(FetchFeedParams request) async {
    print('📘 Fetch Feed Request: ${request.toJson()}');

    emit(FetchFeedLoading());

    try {
      final result = await _fetchFeedUseCase(request);

      result.fold(
        (failure) {
          print('❌ Fetch Feed Failed');
          print(failure.message);

          emit(FetchFeedFailure(failure.message));
        },
        (response) {
          emit(FetchFeedSuccess(response));
        },
      );
    } catch (e, stackTrace) {
      print('❌ Exception during fetchFeed');
      print(e);
      print(stackTrace);

      emit(const FetchFeedFailure('An unexpected error occurred'));
    }
  }

  Future<void> saveFeed(SaveFeedParameter request) async {
    print('📘 Save Feed Request: ${request.toJson()}');

    emit(SaveFeedLoading());

    try {
      final result = await _saveFeedUseCase(request);

      result.fold(
        (failure) {
          print('❌ Save Feed Failed');
          print(failure.message);

          emit(SaveFeedFailure(failure.message));
        },
        (response) {
          emit(SaveFeedSuccess(response));
        },
      );
    } catch (e, stackTrace) {
      print('❌ Exception during saveFeed');
      print(e);
      print(stackTrace);

      emit(const SaveFeedFailure('An unexpected error occurred'));
    }
  }

  Future<void> deleteFeed(int id) async {
    print('📘 Delete Feed Called');
    print('📘 Feed ID: $id');

    emit(DeleteFeedLoading());

    try {
      final result = await _deleteFeedUseCase(id);

      result.fold(
        (failure) {
          print('❌ Delete Feed Failed');
          print(failure.message);

          emit(DeleteFeedFailure(failure.message));
        },
        (response) {
          print('✅ Delete Feed Success');
          print('Response: ${response.toJson()}');

          emit(DeleteFeedSuccess(response));
        },
      );
    } catch (e, stackTrace) {
      print('❌ Exception during deleteFeed');
      print(e);
      print(stackTrace);

      emit(const DeleteFeedFailure('An unexpected error occurred'));
    }
  }
}
