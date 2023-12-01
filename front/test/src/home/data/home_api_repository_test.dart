import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mc426_front/home/data/repositories/home_api_repository.dart';
import 'package:mc426_front/home/home.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class ClientMock extends Mock implements http.Client {}

void main() {
  late final http.Client client;
  late final HomeRepository repository;

  setUpAll(() {
    client = ClientMock();
    repository = HomeApiRepository(client);
    registerFallbackValue(Uri());
  });

  group("get home", () {
    test("should return Home Entity when request is success", () async {
      when(
        () => client.get(
          any(),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (invocation) async => http.Response(
          jsonEncode(homeMockJson),
          200,
        ),
      );

      final result = await repository.getHome("user_id");
      expect(result!.user.safetyNumber, "safetyNumber");
      expect(result.user.username, "username");
      expect(result.user.qtdPosts, 2);
      expect(result.user.coordinates.latitude, -22.8184393);
      expect(result.user.coordinates.longitude, -47.0822301);

      expect(result.posts.length, 2);

      final post = result.posts.first;

      expect(post.id, 1);
      expect(post.description, "description");
      expect(post.time, "2 horas");
      expect(post.local, "Rua Roxo Moreira, 45");
      expect(post.upVotes, 2);
      expect(post.downVotes, 2);
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

      final result = await repository.getHome("user_id");
      expect(result, null);
    });

    test("should return null when request throws exception", () async {
      when(
        () => client.get(
          any(),
          headers: any(named: "headers"),
        ),
      ).thenThrow(Exception());

      final result = await repository.getHome("user_id");
      expect(result, null);
    });
  });
}
