import 'package:test/test.dart';

import '../mocks/mocks.dart';

void main() {
  group("to_map", () {
    test("should return a map json", () async {
      final result = signUpMock.toMap;

      expect(result["username"], "username_test");
      expect(result["password"], "password_test");
      expect(result["name"], "name_test");
      expect(result["age"], "20");
      expect(result["email"], "email_test@gmail.com");
    });
  });
}
