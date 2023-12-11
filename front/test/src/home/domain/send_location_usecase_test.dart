import 'package:flutter_test/flutter_test.dart';
import 'package:mc426_front/home/home.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

class MockSendLocationRepository extends Mock
    implements SendLocationRepository {}
void main() {
  late final SendLocationRepository repository;
  late final SendPanicLocationUsecase usecase;

  setUpAll(() {
    repository = MockSendLocationRepository();
    usecase = SendPanicLocationUsecase(repository);
    registerFallbackValue(latLngMock);
  });
  group('call', () {
    test('should send panic location successfully', () async {
      when(() => repository.sendPanicLocation(any()))
          .thenAnswer((_) async => true);

      final result = await usecase.call(latLngMock);

      expect(result, isTrue);
      verify(() => repository.sendPanicLocation(latLngMock)).called(1);
    });

    test('should return false if sending panic location fails', () async {
      when(() => repository.sendPanicLocation(any()))
          .thenAnswer((_) async => false);

      final result = await usecase.call(latLngMock);

      expect(result, isFalse);
      verify(() => repository.sendPanicLocation(latLngMock)).called(1);
    });

    test('should throw an exception if repository throws', () async {
      when(() => repository.sendPanicLocation(any())).thenThrow(Exception());

      expect(() async => await usecase.call(latLngMock),
          throwsA(isA<Exception>()));
    });
  });
}
