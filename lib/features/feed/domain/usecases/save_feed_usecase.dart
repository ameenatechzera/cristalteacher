import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/feed/domain/parameters/save_feed_parameter.dart';
import 'package:cristalteacher/features/feed/domain/repository/feed_repository.dart';

class SaveFeedUseCase
    implements UseCaseWithParams<MasterResponseModel, SaveFeedParameter> {
  final FeedRepository _feedRepository;

  SaveFeedUseCase(this._feedRepository);

  @override
  ResultFuture<MasterResponseModel> call(SaveFeedParameter request) async {
    return _feedRepository.saveFeed(request);
  }
}
