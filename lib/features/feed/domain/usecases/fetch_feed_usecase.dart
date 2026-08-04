import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/feed/domain/entities/fetch_feed_entity.dart';
import 'package:cristalteacher/features/feed/domain/parameters/fetch_feed_parameter.dart';
import 'package:cristalteacher/features/feed/domain/repository/feed_repository.dart';

class FetchFeedUseCase
    implements UseCaseWithParams<FetchFeedEntity, FetchFeedParams> {
  final FeedRepository _feedRepository;

  FetchFeedUseCase(this._feedRepository);

  @override
  ResultFuture<FetchFeedEntity> call(FetchFeedParams request) async {
    return _feedRepository.fetchFeed(request);
  }
}
