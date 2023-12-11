import 'package:http/http.dart' as http;
import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/complaint/complaint.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class ClientMock extends Mock implements http.Client {}

const userIdMock = "user_id";

void main() {
  late final http.Client client;
  late final VoteRepository repository;

  setUpAll(() {
    client = ClientMock();
    repository = VoteApiRepository(client);
  });

  group('vote', () {
    test('upvote should complete successfully', () async {
      final testUri = Uri.parse('${baseUrl}complaints/1/like/user_id');

      when(() => client.post(testUri, headers: any(named: 'headers'))).thenAnswer((_) async => http.Response('{"status": "success"}', 200));

      final result = await repository.vote(userId: userIdMock, complaintId: 1, upvote: true);
      expect(result, isTrue);
    });

    test('upvote should fail with HTTP error', () async {
      final testUri = Uri.parse('${baseUrl}complaints/1/like/user_id');

      when(() => client.post(testUri, headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('{"error": "some error"}', 400));

      final result = await repository.vote(userId: userIdMock, complaintId: 1, upvote: true);
      expect(result, isFalse);
    });

    test('downvote should complete successfully', () async {
      final testUri = Uri.parse('${baseUrl}complaints/1/unlike/user_id');

      when(() => client.post(testUri, headers: any(named: 'headers'))).thenAnswer(
        (_) async => http.Response('{"status": "success"}', 200),
      );

      final result = await repository.vote(userId: userIdMock, complaintId: 1, upvote: false);
      expect(result, isTrue);
    });

    test('downvote should fail with exception', () async {
      final testUri = Uri.parse('${baseUrl}complaints/1/unlike/user_id');

      when(() => client.post(testUri, headers: any(named: 'headers'))).thenThrow(Exception("network failure"));

      final result = await repository.vote(userId: userIdMock, complaintId: 1, upvote: false);
      expect(result, isFalse);
    });
  });
}
