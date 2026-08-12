import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/feed/domain/repository/feed_repository.dart';

class DeleteFeedUseCase implements UseCaseWithParams<MasterResponseModel, int> {
  final FeedRepository _feedRepository;

  DeleteFeedUseCase(this._feedRepository);

  @override
  ResultFuture<MasterResponseModel> call(int id) async {
    return _feedRepository.deleteFeed(id);
  }
}
