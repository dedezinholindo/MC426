import 'package:http/http.dart' as http;
import 'package:mc426_front/home/home.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class ClientMock extends Mock implements http.Client {}

void main() {
  group("fromMap", () {
    test("should return Home Post Entity when from map is success", () async {
      final result = HomePostEntity.fromMap(postJson);

      expect(result.id, 1);
      expect(result.description, "description");
      expect(result.local, "Rua Roxo Moreira, 45");
      expect(result.upVotes, 2);
      expect(result.downVotes, 2);
      expect(result.photo, "photo");
      expect(result.name, "name");
      expect(result.userUpVoted, true);
      expect(result.isAnonymous, true);
      expect(result.canVote, false);
    });
  });
}
