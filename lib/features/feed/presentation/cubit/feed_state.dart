part of 'feed_cubit.dart';

sealed class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

final class FeedInitial extends FeedState {}

class FetchFeedLoading extends FeedState {}

class FetchFeedSuccess extends FeedState {
  final FetchFeedEntity response;

  const FetchFeedSuccess(this.response);
}

class FetchFeedFailure extends FeedState {
  final String message;

  const FetchFeedFailure(this.message);
}

class SaveFeedLoading extends FeedState {}

class SaveFeedSuccess extends FeedState {
  final MasterResponseModel response;

  const SaveFeedSuccess(this.response);
}

class SaveFeedFailure extends FeedState {
  final String message;

  const SaveFeedFailure(this.message);
}
