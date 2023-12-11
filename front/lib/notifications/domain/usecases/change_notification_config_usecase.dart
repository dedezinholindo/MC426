import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/notifications/notifications.dart';
import 'package:mc426_front/storage/storage.dart';

class ChangeNotificationConfigUsecase {
  final NotificationRepository repository;
  final StorageInterface storage;

  const ChangeNotificationConfigUsecase(this.repository, this.storage);

  Future<bool> call(NotificationEntity notificationEntity) async {
    final userId = storage.getString(userIdKey);
    if (userId == null) return false;
    final changeNotification = ChangeNotificationEntity(
      id: notificationEntity.id,
      userId: userId,
      isActivated: !notificationEntity.isActivated,
    );
    final result = await repository.changeNotificationConfig(notification: changeNotification);
    return result;
  }
}
