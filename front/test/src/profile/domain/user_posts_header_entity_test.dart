import 'package:mc426_front/profile/domain/domain.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

void main() {
  group("from_map", () {
    test("should return a user post header object", () async {
      final result = UserPostHeaderEntity.fromMap(userHeaderJson);

      expect(result.name, "name");
      expect(result.photo, "photo");
    });

    test("should return a user post header object when photo is not present", () async {
      final result = UserPostHeaderEntity.fromMap(userHeaderNoPhotoJson);

      expect(result.name, "name");
      expect(result.photo, null);
    });
  });
}
