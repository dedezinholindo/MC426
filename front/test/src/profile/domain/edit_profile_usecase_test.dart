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
  late final EditProfileUsecase usecase;

  setUpAll(() {
    repository = ProfileRepositoryMock();
    storage = StorageInterfaceMock();
    usecase = EditProfileUsecase(repository, storage);
    registerFallbackValue(profileMock);
  });

  group("call", () {
    test("should return true success when repository returns true", () async {
      when(
        () => repository.edit(profile: any(named: "profile"), userId: any(named: "userId")),
      ).thenAnswer((invocation) async => true);

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call(profileMock);
      expect(result, true);
    });

    test("should return false when repository returns false", () async {
      when(
        () => repository.edit(profile: any(named: "profile"), userId: any(named: "userId")),
      ).thenAnswer((invocation) async => false);

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call(profileMock);
      expect(result, false);
    });

    test("should return false when storage returns null", () async {
      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => null);

      final result = await usecase.call(profileMock);
      expect(result, false);
    });
  });
}
