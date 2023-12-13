import 'package:mc426_front/profile/domain/domain.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

void main() {
  group("from_map", () {
    test("should return a user post info object", () async {
      final result = UserPostInfoEntity.fromMap(userPostInfoJson);

      expect(result.id, 1);
      expect(result.description, "description");
      expect(result.local, "Rua Roxo Moreira, 45");
      expect(result.upVotes, 2);
      expect(result.downVotes, 2);
    });
  });
}
