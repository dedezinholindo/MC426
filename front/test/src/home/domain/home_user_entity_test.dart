import 'package:http/http.dart' as http;
import 'package:mc426_front/home/home.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class ClientMock extends Mock implements http.Client {}

void main() {
  group("fromMap", () {
    test("should return Home User Entity when from map is success", () async {
      final result = HomeUserEntity.fromMap(userJson);

      expect(result.safetyNumber, "safetyNumber");
      expect(result.username, "username");
      expect(result.qtdPosts, 2);
      expect(result.coordinates.latitude, -22.8184393);
      expect(result.coordinates.longitude, -47.0822301);
      expect(result.photo, "photo");
    });
  });
}
