import 'package:mc426_front/profile/domain/domain.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

void main() {
  group("from_map", () {
    test("should return a user posts entity object", () async {
      final result = UserPostEntity.fromMap(userPostJson);

      final header = result.header;

      expect(header.name, "name");
      expect(header.photo, "photo");

      final posts = result.posts;

      expect(posts.length, 2);

      final first = posts.first;

      expect(first.id, 1);
      expect(first.description, "description");
      expect(first.local, "Rua Roxo Moreira, 45");
      expect(first.upVotes, 2);
      expect(first.downVotes, 2);

      final second = posts[1];

      expect(second.id, 3);
      expect(second.description, "description");
      expect(second.local, "Rua Roxo Moreira, 45");
      expect(second.upVotes, 2);
      expect(second.downVotes, 2);
    });
  });
}
