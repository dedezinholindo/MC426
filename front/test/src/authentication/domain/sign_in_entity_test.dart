import 'package:test/test.dart';

import '../mocks/mocks.dart';

void main() {
  group("to_map", () {
    test("should return a map json", () async {
      final result = signInMock.toMap;

      expect(result["username"], "username_test");
      expect(result["password"], "password_test");
    });
  });
}
