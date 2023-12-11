import 'package:flutter_test/flutter_test.dart';
import 'package:mc426_front/home/home.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late final http.Client client;
  late final SendLocationApiRepository repository;

  setUpAll(() {
    client = MockClient();
    repository = SendLocationApiRepository(client);
    registerFallbackValue(latLngMock);
    registerFallbackValue(Uri());
  });

  group('sendPanicLocation', () {
    test('sends panic location successfully', () async {
      when(() => client.post(
            any(),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('{"success": true}', 200));

      final result = await repository.sendPanicLocation(latLngMock);

      expect(result, isTrue);
    });

    test('returns false when server responds with an error', () async {
      when(() => client.post(
                any(),
                body: any(named: 'body'),
              ))
          .thenAnswer(
              (_) async => http.Response('{"error": "some_error"}', 400));

      final result = await repository.sendPanicLocation(latLngMock);

      expect(result, isFalse);
    });

    test('returns false on exception', () async {
      when(() => client.post(
            any(),
            body: any(named: 'body'),
          )).thenThrow(Exception('Failed to send data'));

      final result = await repository.sendPanicLocation(latLngMock);

      expect(result, isFalse);
    });
  });
}
