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

  group("is_available", () {
    test("should return true", () async {
      final result = signUpMock.isAvailable;

      expect(result, true);
    });

    test("should return false when name is empty", () async {
      final result = signUpMock.copyWith(name: "").isAvailable;

      expect(result, false);
    });

    test("should return false when username is empty", () async {
      final result = signUpMock.copyWith(username: "").isAvailable;

      expect(result, false);
    });

    test("should return false when email is empty", () async {
      final result = signUpMock.copyWith(email: "").isAvailable;

      expect(result, false);
    });

    test("should return false when age is empty", () async {
      final result = signUpMock.copyWith(age: "").isAvailable;

      expect(result, false);
    });

    test("should return false when phone is empty", () async {
      final result = signUpMock.copyWith(phone: "").isAvailable;

      expect(result, false);
    });

    test("should return false when password is empty", () async {
      final result = signUpMock.copyWith(password: "").isAvailable;

      expect(result, false);
    });

    test("should return false when address is empty", () async {
      final result = signUpMock.copyWith(address: "").isAvailable;

      expect(result, false);
    });
  });
}
