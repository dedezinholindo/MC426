import 'package:mc426_front/profile/profile.dart';
import 'package:mc426_front/storage/storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class ProfileRepositoryMock extends Mock implements ProfileRepository {}

class StorageInterfaceMock extends Mock implements StorageInterface {}

const userIdMock = "user_id";

void main() {
  late final ProfileRepository repository;
  late final StorageInterface storage;
  late final GetProfileUsecase usecase;

  setUpAll(() {
    repository = ProfileRepositoryMock();
    storage = StorageInterfaceMock();
    usecase = GetProfileUsecase(repository, storage);
    registerFallbackValue(profileMock);
  });

  group("call", () {
    test("should return profile success when repository returns profile", () async {
      when(
        () => repository.getProfile(any()),
      ).thenAnswer((invocation) async => profileMock);

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call();
      expect(result!.email, "email_test@gmail.com");
    });

    test("should return null when repository returns null", () async {
      when(
        () => repository.getProfile(any()),
      ).thenAnswer((invocation) async => null);

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call();
      expect(result, null);
    });

    test("should return null when storage returns null", () async {
      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => null);

      final result = await usecase.call();
      expect(result, null);
    });
  });
}
