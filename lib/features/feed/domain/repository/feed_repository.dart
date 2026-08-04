import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/feed/domain/parameters/fetch_feed_parameter.dart';
import 'package:cristalteacher/features/feed/domain/parameters/save_feed_parameter.dart';
import 'package:cristalteacher/features/feed/domain/entities/fetch_feed_entity.dart';

abstract class FeedRepository {
  ResultFuture<FetchFeedEntity> fetchFeed(FetchFeedParams params);

  ResultFuture<MasterResponseModel> saveFeed(SaveFeedParameter request);
}
