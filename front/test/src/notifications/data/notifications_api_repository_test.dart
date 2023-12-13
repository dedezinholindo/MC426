import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mc426_front/notifications/notifications.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class ClientMock extends Mock implements http.Client {}

const userIdMock = "user_id";

void main() {
  late final http.Client client;
  late final NotificationRepository repository;

  setUpAll(() {
    client = ClientMock();
    repository = NotificationApiRepository(client);
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

      final result = await repository.changeNotificationConfig(
        notification: notificationMock,
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

      final result = await repository.changeNotificationConfig(
        notification: notificationMock,
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

      final result = await repository.changeNotificationConfig(
        notification: notificationMock,
      );
      expect(result, false);
    });
  });

  group("get", () {
    test("should return list of notifications entity when request is success", () async {
      when(
        () => client.get(
          any(),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (invocation) async => http.Response(
          jsonEncode({
            "notifications": [notificationMockJson]
          }),
          200,
        ),
      );

      final result = await repository.getNotificationConfigs(userIdMock);
      expect(result!.length, 1);

      final post = result.first;

      expect(post.isActivated, true);
      expect(post.id, 1);
      expect(post.title, "title");
      expect(post.description, "description");
    });

    test("should return empty list when request body is empty", () async {
      when(
        () => client.get(
          any(),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (invocation) async => http.Response(
          jsonEncode({"notifications": []}),
          200,
        ),
      );

      final result = await repository.getNotificationConfigs(userIdMock);
      expect(result!.isEmpty, true);
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

      final result = await repository.getNotificationConfigs(userIdMock);
      expect(result, null);
    });

    test("should return null when request throws Exception", () async {
      when(
        () => client.get(
          any(),
          headers: any(named: "headers"),
        ),
      ).thenThrow(Exception());

      final result = await repository.getNotificationConfigs(userIdMock);
      expect(result, null);
    });
  });
}
