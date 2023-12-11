import 'package:mc426_front/authentication/authentication.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class AuthenticationRepositoryMock extends Mock
    implements AuthenticationRepository {}

void main() {
  late AuthenticationRepository repository;
  late ForgotPasswordUsecase usecase;

  setUp(() {
    repository = AuthenticationRepositoryMock();
    usecase = ForgotPasswordUsecase(repository);
  });

  group("ForgotPasswordUsecase", () {
    test("should return true when repository returns success", () async {
      when(() => repository.sendPasswordReset(any()))
          .thenAnswer((_) async => true);

      final result = await usecase.call("test@example.com");
      expect(result, isTrue);
    });

    test("should return false when repository returns failure", () async {
      when(() => repository.sendPasswordReset(any()))
          .thenAnswer((_) async => false);

      final result = await usecase.call("test@example.com");
      expect(result, isFalse);
    });

    test("should throw Exception when repository throws Exception", () {
      when(() => repository.sendPasswordReset(any())).thenThrow(Exception());

      expect(() => usecase.call("test@example.com"), throwsA(isA<Exception>()));
    });
  });
}