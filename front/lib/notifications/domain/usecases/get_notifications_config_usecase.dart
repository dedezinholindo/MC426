import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/notifications/notifications.dart';
import 'package:mc426_front/storage/storage.dart';

class GetNotificationConfigUsecase {
  final NotificationRepository repository;
  final StorageInterface storage;

  const GetNotificationConfigUsecase(this.repository, this.storage);

  Future<List<NotificationEntity>?> call() async {
    final userId = storage.getString(userIdKey);
    if (userId == null) return null;
    final result = await repository.getNotificationConfigs(userId);
    return result;
  }
}
