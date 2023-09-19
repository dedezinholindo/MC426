import 'package:mc426_front/authentication/authentication.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class AuthenticationRepositoryMock extends Mock implements AuthenticationRepository {}

void main() {
  late final AuthenticationRepository repository;
  late final SignInUsecase usecase;

  setUpAll(() {
    repository = AuthenticationRepositoryMock();
    usecase = SignInUsecase(repository);
    registerFallbackValue(signInMock);
  });

  group("call", () {
    test("should return Auth result success when repository is success", () async {
      when(
        () => repository.signIn(any()),
      ).thenAnswer((invocation) async => AuthenticationResult(
            isSuccess: true,
            message: resultSignInSuccess["message"] ?? "",
          ));

      final result = await usecase.call(signInMock);
      expect(result.isSuccess, true);
      expect(result.message, "Autenticação bem-sucedida");
    });

    test("should return Auth result fails when repository fails", () async {
      when(
        () => repository.signIn(any()),
      ).thenAnswer((invocation) async => AuthenticationResult(
            isSuccess: false,
            message: resultError["message"] ?? "",
          ));

      final result = await usecase.call(signInMock);
      expect(result.isSuccess, false);
      expect(result.message, "Senha inválida");
    });

    test("should throws when repository throws Exception", () async {
      when(
        () => repository.signIn(any()),
      ).thenThrow(Exception());

      expect(
        () => usecase.call(signInMock),
        throwsA(
          isA<Exception>(),
        ),
      );
    });
  });
}
