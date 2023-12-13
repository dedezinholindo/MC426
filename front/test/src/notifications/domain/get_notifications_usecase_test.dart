import 'package:mc426_front/notifications/notifications.dart';
import 'package:mc426_front/storage/storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class NotificationRepositoryMock extends Mock implements NotificationRepository {}

class StorageInterfaceMock extends Mock implements StorageInterface {}

const userIdMock = "user_id";

void main() {
  late final NotificationRepository repository;
  late final StorageInterface storage;
  late final GetNotificationConfigUsecase usecase;

  setUpAll(() {
    repository = NotificationRepositoryMock();
    storage = StorageInterfaceMock();
    usecase = GetNotificationConfigUsecase(repository, storage);
    registerFallbackValue(notificationMock);
  });

  group("call", () {
    test("should return list of notifications success when repository returns profile", () async {
      when(
        () => repository.getNotificationConfigs(any()),
      ).thenAnswer((invocation) async => [notificationMock]);

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call();
      expect(result!.length, 1);
    });

    test("should return empty list success when repository returns empty list", () async {
      when(
        () => repository.getNotificationConfigs(any()),
      ).thenAnswer((invocation) async => []);

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call();
      expect(result!.isEmpty, true);
    });

    test("should return null when repository returns null", () async {
      when(
        () => repository.getNotificationConfigs(any()),
      ).thenAnswer((invocation) async => null);

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call();
      expect(result, null);
    });

    test("should return null when storage returns null", () async {
      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => null);

      final result = await usecase.call();
      expect(result, null);
    });
  });
}
