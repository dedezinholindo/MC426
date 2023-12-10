import 'package:mc426_front/profile/profile.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

void main() {
  group("to_map", () {
    test("should return a map json", () async {
      final result = profileMock.toMap;

      expect(result["username"], "username_test");
      expect(result["name"], "name_test");
      expect(result["age"], 20);
      expect(result["email"], "email_test@gmail.com");
    });
  });

  group("from_map", () {
    test("should return a profile object", () async {
      final result = ProfileEntity.fromMap(profileMapMock);

      expect(result.username, "username_test");
      expect(result.name, "name_test");
      expect(result.age, 20);
      expect(result.email, "email_test@gmail.com");
    });
  });
}
