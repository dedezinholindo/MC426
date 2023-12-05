import 'package:mc426_front/notifications/domain/domain.dart';

const notificationMockJson = {
  "id": 1,
  "title": "title",
  "description": "description",
  "isActivated": true,
};

final notificationMock = NotificationEntity(
  id: 1,
  description: "description",
  title: "title",
  isActivated: true,
);
