import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/notifications/notifications.dart';

class NotificationApiRepository extends NotificationRepository {
  final http.Client client;

  NotificationApiRepository(this.client);

  @override
  Future<bool> changeNotificationConfig({required NotificationEntity notification}) async {
    try {
      final result = await client.post(
        Uri.parse("${baseUrl}notifications/"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(notification.toMap),
      );

      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<NotificationEntity>?> getNotificationConfigs(String userId) async {
    try {
      final result = await client.get(
        Uri.parse("${baseUrl}notifications/$userId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (result.statusCode != 200) return null;

      final body = jsonDecode(result.body);

      final notifications = body != null
          ? List<NotificationEntity>.from(body["notifications"].map((e) => NotificationEntity.fromMap(Map<String, dynamic>.from(e))))
              .toList()
          : <NotificationEntity>[];

      return notifications;
    } catch (e) {
      return null;
    }
  }
}
