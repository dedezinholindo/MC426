import 'package:mc426_front/home/home.dart';
import 'package:mc426_front/storage/storage_interface.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class HomeRepositoryMock extends Mock implements HomeRepository {}

class StorageInterfaceMock extends Mock implements StorageInterface {}

const userIdMock = "user_id";

void main() {
  late final StorageInterface storage;
  late final HomeRepository repository;
  late final HomeUsecase usecase;

  setUpAll(() {
    repository = HomeRepositoryMock();
    storage = StorageInterfaceMock();
    usecase = HomeUsecase(repository, storage);
    registerFallbackValue(homeMock);
  });

  group("call", () {
    test("should return home success when repository returns home", () async {
      when(
        () => repository.getHome(any()),
      ).thenAnswer((invocation) async => homeMock);

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call();
      expect(result!.user.username, "username");
    });

    test("should return null when repository returns null", () async {
      when(
        () => repository.getHome(any()),
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
