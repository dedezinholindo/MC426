import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/storage/storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class AuthenticationRepositoryMock extends Mock implements AuthenticationRepository {}

class StorageInterfaceMock extends Mock implements StorageInterface {}

void main() {
  late final AuthenticationRepository repository;
  late final StorageInterface storage;
  late final SignInUsecase usecase;

  setUpAll(() {
    repository = AuthenticationRepositoryMock();
    storage = StorageInterfaceMock();
    usecase = SignInUsecase(repository, storage);
    registerFallbackValue(signInMock);
  });

  group("call", () {
    test("should return Auth result success when repository is success", () async {
      when(
        () => repository.signIn(any()),
      ).thenAnswer((invocation) async => AuthenticationResult(
            isSuccess: true,
            message: resultSignInSuccess["message"] ?? "",
            id: "user_uuid",
          ));

      when(
        () => storage.setString(any(), any()),
      ).thenAnswer((invocation) async => true);

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
      when(
        () => storage.setString(any(), any()),
      ).thenAnswer((invocation) async => true);

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
