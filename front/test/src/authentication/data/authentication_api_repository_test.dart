import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mc426_front/authentication/authentication.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import '../mocks/mocks.dart';

class ClientMock extends Mock implements http.Client {}

void main() {
  late final http.Client client;
  late final AuthenticationRepository repository;

  setUpAll(() {
    client = ClientMock();
    repository = AuthenticationApiRepository(client);
    registerFallbackValue(Uri());
  });

  group("sign_in", () {
    test("should return Auth result success when request is success", () async {
      when(
        () => client.post(
          any(),
          body: any(named: "body"),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (invocation) async => http.Response(
          jsonEncode(resultSignInSuccess),
          200,
        ),
      );

      final result = await repository.signIn(signInMock);
      expect(result.isSuccess, true);
      expect(result.message, "Autenticação bem-sucedida");
    });

    test("should return Auth result fails when request fails", () async {
      when(
        () => client.post(
          any(),
          body: any(named: "body"),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (invocation) async => http.Response(
          jsonEncode(resultError),
          401,
        ),
      );

      final result = await repository.signIn(signInMock);
      expect(result.isSuccess, false);
      expect(result.message, "Senha inválida");
    });

    test("should return Auth result fails when request throws Exception",
        () async {
      when(
        () => client.post(
          any(),
          body: any(named: "body"),
          headers: any(named: "headers"),
        ),
      ).thenThrow(Exception());

      final result = await repository.signIn(signInMock);
      expect(result.isSuccess, false);
      expect(result.message, "Não foi possível concluir a solicitação");
    });
  });

  group("sign_up", () {
    test("should return Auth result success when request is success", () async {
      when(
        () => client.post(
          any(),
          body: any(named: "body"),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (invocation) async => http.Response(
          jsonEncode(resultSignUpSuccess),
          201,
        ),
      );

      final result = await repository.signup(signUpMock);
      expect(result.isSuccess, true);
      expect(result.message, "Usuário cadastrado com sucesso");
    });

    test("should return Auth result fails when request fails", () async {
      when(
        () => client.post(
          any(),
          body: any(named: "body"),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (invocation) async => http.Response(
          jsonEncode(resultError),
          401,
        ),
      );

      final result = await repository.signup(signUpMock);
      expect(result.isSuccess, false);
      expect(result.message, "Senha inválida");
    });

    test("should return Auth result fails when request throws Exception",
        () async {
      when(
        () => client.post(
          any(),
          body: any(named: "body"),
          headers: any(named: "headers"),
        ),
      ).thenThrow(Exception());

      final result = await repository.signup(signUpMock);
      expect(result.isSuccess, false);
      expect(result.message, "Não foi possível concluir a solicitação");
    });
  });

  group("sendPasswordReset", () {
    test("should return true when request is success", () async {
      when(
        () => client.post(
          any(),
          body: any(named: "body"),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (_) async => http.Response(jsonEncode({}), 200),
      );

      final result = await repository.sendPasswordReset("test@example.com");
      expect(result, true);
    });

    test("should return false when request fails", () async {
      when(
        () => client.post(
          any(),
          body: any(named: "body"),
          headers: any(named: "headers"),
        ),
      ).thenAnswer(
        (_) async => http.Response(jsonEncode({}), 400),
      );

      final result = await repository.sendPasswordReset("test@example.com");
      expect(result, false);
    });

    test("should return false when request throws Exception", () async {
      when(
        () => client.post(
          any(),
          body: any(named: "body"),
          headers: any(named: "headers"),
        ),
      ).thenThrow(Exception());

      final result = await repository.sendPasswordReset("test@example.com");
      expect(result, false);
    });
  });
}