import 'package:mc426_front/notifications/notifications.dart';

abstract class NotificationRepository {
  Future<List<NotificationEntity>?> getNotificationConfigs(String userId);
  Future<bool> changeNotificationConfig({required ChangeNotificationEntity notification});
}
