import 'package:mc426_front/complaint/domain/repositories/vote_repository.dart';

class VoteUseCase {
  final VoteRepository repository;

  VoteUseCase(this.repository);

  Future<bool> call(int complaintId, bool upvote) async {
    return repository.vote(complaintId, upvote);
  }
}