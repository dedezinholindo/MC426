import 'package:mc426_front/complaints_map/complaints_map.dart';
import 'package:mc426_front/storage/storage_interface.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class ComplaintsMapRepositoryMock extends Mock implements ComplaintsMapRepository {}

class StorageInterfaceMock extends Mock implements StorageInterface {}

const userIdMock = "user_id";

void main() {
  late final StorageInterface storage;
  late final ComplaintsMapRepository repository;
  late final GetCoordinatesUsecase usecase;

  setUpAll(() {
    repository = ComplaintsMapRepositoryMock();
    storage = StorageInterfaceMock();
    usecase = GetCoordinatesUsecase(repository, storage);
    registerFallbackValue(listLatLongMock);
  });

  group("call", () {
    test("should return empty list when repository returns empty", () async {
      when(
        () => repository.getCoordinates(any()),
      ).thenAnswer((invocation) async => []);

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      final result = await usecase.call();
      expect(result!.isEmpty, isTrue);
    });

    test("should return list when repository returns a list of latlng", () async {
      when(
        () => repository.getCoordinates(any()),
      ).thenAnswer((invocation) async => listLatLongMock);

      when(
        () => storage.getString(any()),
      ).thenAnswer((invocation) => userIdMock);

      when(
        () => storage.setString(any(), any()),
      ).thenAnswer((invocation) async => true);

      final result = await usecase.call();
      expect(result!.length, 5);
    });

    test("should return null when repository returns null", () async {
      when(
        () => repository.getCoordinates(any()),
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
