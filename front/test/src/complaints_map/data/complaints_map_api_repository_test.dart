import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mc426_front/complaints_map/complaints_map.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class ClientMock extends Mock implements http.Client {}

const userIdMock = "user_id";

void main() {
  late final http.Client client;
  late final ComplaintsMapRepository repository;

  setUpAll(() {
    client = ClientMock();
    repository = ComplaintsMapApiRepository(client);
    registerFallbackValue(Uri());
  });

  group("get coordinates", () {
    test("should return list of coordinates when request is success", () async {
      when(
        () => client.get(
          any(),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (invocation) async => http.Response(
          jsonEncode(listLatLongJsonMock),
          200,
        ),
      );

      final result = await repository.getCoordinates(userIdMock);
      expect(result!.length, 5);

      final first = result.first;

      expect(first.latitude, -22.815043);
      expect(first.longitude, -47.085752);
    });

    test("should return empty list when request is success and body is empty", () async {
      when(
        () => client.get(
          any(),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (invocation) async => http.Response(
          jsonEncode([]),
          200,
        ),
      );

      final result = await repository.getCoordinates(userIdMock);
      expect(result!.isEmpty, isTrue);
    });

    test("should return null when request is fails", () async {
      when(
        () => client.get(
          any(),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (invocation) async => http.Response(
          jsonEncode("{'error': 'BadRequest'}"),
          400,
        ),
      );

      final result = await repository.getCoordinates(userIdMock);
      expect(result, null);
    });

    test("should return null when request throws exception", () async {
      when(
        () => client.get(
          any(),
          headers: any(named: "headers"),
        ),
      ).thenThrow(Exception());

      final result = await repository.getCoordinates(userIdMock);
      expect(result, null);
    });
  });
}
