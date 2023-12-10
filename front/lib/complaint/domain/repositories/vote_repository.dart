abstract class VoteRepository {
  Future<bool> vote({
    required String userId,
    required int complaintId,
    required bool upvote,
  });
}
