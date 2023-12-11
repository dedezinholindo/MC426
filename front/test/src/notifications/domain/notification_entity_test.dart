import 'package:mc426_front/notifications/notifications.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

void main() {
  group("to_map", () {
    test("should return a map json", () async {
      final result = notificationMock.toMap;

      expect(result["id"], 1);
      expect(result["description"], "description");
      expect(result["title"], "title");
      expect(result["isActivated"], true);
    });
  });

  group("from_map", () {
    test("should return a profile object", () async {
      final result = NotificationEntity.fromMap(notificationMockJson);

      expect(result.id, 1);
      expect(result.description, "description");
      expect(result.title, "title");
      expect(result.isActivated, true);
    });
  });
}
