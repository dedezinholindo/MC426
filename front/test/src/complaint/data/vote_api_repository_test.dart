import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:mc426_front/complaint/data/repositories/vote_api_repository.dart';
import 'package:mc426_front/common/common.dart';

class ClientMock extends Mock implements http.Client {}

void main() {
  group('VoteApiRepository', () {
    test('upvote should complete successfully', () async {
      final client = ClientMock();
      final repository = VoteApiRepository(client);
      final testUri = Uri.parse('${baseUrl}complaints/1/like');

      when(() => client.post(testUri, headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('{"status": "success"}', 200));

      final result = await repository.vote(1, true);
      expect(result, isTrue);
    });

    test('upvote should fail with HTTP error', () async {
      final client = ClientMock();
      final repository = VoteApiRepository(client);
      final testUri = Uri.parse('${baseUrl}complaints/1/like');

      when(() => client.post(testUri, headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('{"error": "some error"}', 400));

      final result = await repository.vote(1, true);
      expect(result, isFalse);
});
    test('downvote should complete successfully', () async {
      final client = ClientMock();
      final repository = VoteApiRepository(client);
      final testUri = Uri.parse('${baseUrl}complaints/1/unlike');

      when(() => client.post(testUri, headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('{"status": "success"}', 200));

      final result = await repository.vote(1, false);
      expect(result, isTrue);
    });

    test('downvote should fail with exception', () async {
      final client = ClientMock();
      final repository = VoteApiRepository(client);
      final testUri = Uri.parse('${baseUrl}complaints/1/unlike');

      when(() => client.post(testUri, headers: any(named: 'headers')))
          .thenThrow(Exception("network failure"));

      final result = await repository.vote(1, false);
      expect(result, isFalse);
    });
  });
}