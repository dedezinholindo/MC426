import 'package:mc426_front/complaints_map/complaints_map.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

class ComplaintsMapRepositoryMock extends Mock implements ComplaintsMapRepository {}

void main() {
  late final ComplaintsMapRepository repository;
  late final GetCoordinatesUsecase usecase;

  setUpAll(() {
    repository = ComplaintsMapRepositoryMock();
    usecase = GetCoordinatesUsecase(repository);
    registerFallbackValue(listLatLongMock);
  });

  group("call", () {
    test("should return empty list when repository returns empty", () async {
      when(
        () => repository.getCoordinates(),
      ).thenAnswer((invocation) async => []);

      final result = await usecase.call();
      expect(result!.isEmpty, isTrue);
    });

    test("should return list when repository returns a list of latlng", () async {
      when(
        () => repository.getCoordinates(),
      ).thenAnswer((invocation) async => listLatLongMock);

      final result = await usecase.call();
      expect(result!.length, 5);
    });

    test("should return null when repository returns null", () async {
      when(
        () => repository.getCoordinates(),
      ).thenAnswer((invocation) async => null);

      final result = await usecase.call();
      expect(result, null);
    });
  });
}
