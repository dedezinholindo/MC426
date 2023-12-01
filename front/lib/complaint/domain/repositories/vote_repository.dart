abstract class VoteRepository {
  Future<bool> vote(int complaintId, bool upvote);
}