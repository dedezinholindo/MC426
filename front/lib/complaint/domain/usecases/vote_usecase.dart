import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/complaint/domain/repositories/vote_repository.dart';
import 'package:mc426_front/storage/storage.dart';

class VoteUseCase {
  final VoteRepository repository;
  final StorageInterface storage;

  VoteUseCase(this.repository, this.storage);

  Future<bool> call(int complaintId, bool upvote) async {
    final userId = storage.getString(userIdKey);
    if (userId == null) return false;

    return repository.vote(userId: userId, complaintId: complaintId, upvote: upvote);
  }
}
