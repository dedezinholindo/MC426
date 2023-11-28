import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mc426_front/profile/profile.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class ClientMock extends Mock implements http.Client {}

const userIdMock = "user_id";

void main() {
  late final http.Client client;
  late final ProfileRepository repository;

  setUpAll(() {
    client = ClientMock();
    repository = ProfileApiRepository(client);
    registerFallbackValue(Uri());
  });

  group("edit", () {
    test("should return true when request is success", () async {
      when(
        () => client.post(
          any(),
          body: any(named: "body"),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (invocation) async => http.Response(
          "",
          200,
        ),
      );

      final result = await repository.edit(
        profile: profileMock,
        userId: userIdMock,
      );
      expect(result, true);
    });

    test("should return false when request fails", () async {
      when(
        () => client.post(
          any(),
          body: any(named: "body"),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (invocation) async => http.Response(
          "",
          401,
        ),
      );

      final result = await repository.edit(
        profile: profileMock,
        userId: userIdMock,
      );
      expect(result, false);
    });

    test("should return false when request throws Exception", () async {
      when(
        () => client.post(
          any(),
          body: any(named: "body"),
          headers: any(named: "headers"),
        ),
      ).thenThrow(Exception());

      final result = await repository.edit(
        profile: profileMock,
        userId: userIdMock,
      );
      expect(result, false);
    });
  });

  group("get", () {
    test("should return Profile when request is success", () async {
      when(
        () => client.get(
          any(),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (invocation) async => http.Response(
          jsonEncode(profileMock.toMap),
          200,
        ),
      );

      final result = await repository.getProfile(userIdMock);

      expect(result!.name, "name_test");
      expect(result.username, "username_test");
      expect(result.email, "email_test@gmail.com");
      expect(result.age, "20");
      expect(result.phone, "phone_test");
      expect(result.password, "password_test");
      expect(result.address, "address_test");
      expect(result.photo, "photo_test");
      expect(result.safetyNumber, "190");
    });

    test("should return null when request fails", () async {
      when(
        () => client.get(
          any(),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (invocation) async => http.Response(
          "",
          401,
        ),
      );

      final result = await repository.getProfile(userIdMock);
      expect(result, null);
    });

    test("should return null when request throws Exception", () async {
      when(
        () => client.get(
          any(),
          headers: any(named: "headers"),
        ),
      ).thenThrow(Exception());

      final result = await repository.getProfile(userIdMock);
      expect(result, null);
    });
  });
}
