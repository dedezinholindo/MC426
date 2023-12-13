import 'package:mc426_front/notifications/domain/domain.dart';

const notificationMockJson = {
  "notification_id": 1,
  "title": "title",
  "description": "description",
  "is_active": true,
  "topic_name": "topic_name",
};

final notificationMock = NotificationEntity(
  id: 1,
  description: "description",
  title: "title",
  isActivated: true,
  userId: "userId",
  topicName: "topic_name",
);
