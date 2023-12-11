import 'package:http/http.dart' as http;
import 'package:mc426_front/home/home.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class ClientMock extends Mock implements http.Client {}

void main() {
  group("fromMap", () {
    test("should return Home Entity when from map is success", () async {
      final result = HomeEntity.fromMap(homeMockJson);

      expect(result.user.safetyNumber, "safetyNumber");
      expect(result.user.username, "username");
      expect(result.user.qtdPosts, 2);
      expect(result.user.coordinates.latitude, -22.8184393);
      expect(result.user.coordinates.longitude, -47.0822301);

      expect(result.posts.length, 2);

      final post = result.posts.first;

      expect(post.id, 1);
      expect(post.description, "description");
      expect(post.time, "2 horas");
      expect(post.local, "Rua Roxo Moreira, 45");
      expect(post.upVotes, 2);
      expect(post.downVotes, 2);

      final secondPost = result.posts[1];

      expect(secondPost.id, 2);
      expect(secondPost.description, "description");
      expect(secondPost.time, "10 dias");
      expect(secondPost.local, "Rua Luverci Pereira, 40");
      expect(secondPost.upVotes, 4);
      expect(secondPost.downVotes, 3);
    });
  });
}
