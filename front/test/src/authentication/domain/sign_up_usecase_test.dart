import 'package:mc426_front/authentication/authentication.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class AuthenticationRepositoryMock extends Mock implements AuthenticationRepository {}

void main() {
  late final AuthenticationRepository repository;
  late final SignUpUsecase usecase;

  setUpAll(() {
    repository = AuthenticationRepositoryMock();
    usecase = SignUpUsecase(repository);
    registerFallbackValue(signUpMock);
  });

  group("call", () {
    test("should return Auth result success when repository is success", () async {
      when(
        () => repository.signup(any()),
      ).thenAnswer((invocation) async => AuthenticationResult(
            isSuccess: true,
            message: resultSignUpSuccess["message"] ?? "",
          ));

      final result = await usecase.call(signUpMock);
      expect(result.isSuccess, true);
      expect(result.message, "Usuário cadastrado com sucesso");
    });

    test("should return Auth result fails when repository fails", () async {
      when(
        () => repository.signup(any()),
      ).thenAnswer((invocation) async => AuthenticationResult(
            isSuccess: false,
            message: resultError["message"] ?? "",
          ));

      final result = await usecase.call(signUpMock);
      expect(result.isSuccess, false);
      expect(result.message, "Senha inválida");
    });

    test("should throws when request repository throws Exception", () async {
      when(
        () => repository.signup(any()),
      ).thenThrow(Exception());

      expect(
        () => usecase.call(signUpMock),
        throwsA(
          isA<Exception>(),
        ),
      );
    });
  });
}
