import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/complaints_map/complaints_map.dart';
import 'package:mc426_front/complaints_map/ui/bloc/complaint_map_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

class GetCoordinatesUsecaseMock extends Mock implements GetCoordinatesUsecase {}

void main() {
  late final GetCoordinatesUsecase getCoordinatesUsecase;

  setUpAll(() {
    final injection = GetIt.instance;
    getCoordinatesUsecase = GetCoordinatesUsecaseMock();

    injection.registerFactory<GetCoordinatesUsecase>(() => getCoordinatesUsecase);
    registerFallbackValue(listLatLongMock);
  });

  group("init", () {
    blocTest<ComplaintsMapBloc, ComplaintMapState>(
      'should emit Loaded State when the request is completed',
      build: () {
        when(() => getCoordinatesUsecase.call()).thenAnswer((_) async => listLatLongMock);
        return ComplaintsMapBloc();
      },
      act: (bloc) async {
        await bloc.init();
      },
      expect: () => [
        isA<ComplaintMapLoadingState>(),
        isA<ComplaintMapLoadedState>().having((s) => s.coordinates.length, "coordinates length", 5),
      ],
    );

    blocTest<ComplaintsMapBloc, ComplaintMapState>(
      'should emit Error State when the request returns error',
      build: () {
        when(() => getCoordinatesUsecase.call()).thenAnswer((_) async => null);
        return ComplaintsMapBloc();
      },
      act: (bloc) async {
        await bloc.init();
      },
      expect: () => [
        isA<ComplaintMapLoadingState>(),
        isA<ComplaintMapErrorState>(),
      ],
    );
  });
}
