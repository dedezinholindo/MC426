import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/complaint/domain/repositories/vote_repository.dart';

class VoteApiRepository implements VoteRepository {
  final http.Client client;

  VoteApiRepository(this.client);

  @override
  Future<bool> vote(int complaintId, bool upvote) async {
    try {
      final uri = Uri.parse('${baseUrl}complaints/$complaintId/${upvote ? 'like' : 'unlike'}');
      final response = await client.post(uri, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        log('Failed to vote: ${response.body}');
        return false;
      }
    } catch (e) {
      log('Exception occurred while voting: $e');
      return false;
    }
  }
}