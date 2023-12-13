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
  late final ChangeNotificationConfigUsecase usecase;

  setUpAll(() {
    repository = NotificationRepositoryMock();
    storage = StorageInterfaceMock();
    usecase = ChangeNotificationConfigUsecase(repository, storage);
    registerFallbackValue(notificationMock);
  });

  group("call", () {
    test("should return true success when repository returns true", () async {
      when(
        () => repository.changeNotificationConfig(notification: any(named: "notification")),
      ).thenAnswer((invocation) async => true);

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call(notificationMock);
      expect(result, true);
    });

    test("should return false when repository returns false", () async {
      when(
        () => repository.changeNotificationConfig(notification: any(named: "notification")),
      ).thenAnswer((invocation) async => false);

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call(notificationMock);
      expect(result, false);
    });

    test("should return false when storage returns null", () async {
      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => null);

      final result = await usecase.call(notificationMock);
      expect(result, false);
    });
  });
}
