import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/complaint/complaint.dart';
import 'package:mc426_front/home/domain/domain.dart';
import 'package:mc426_front/home/ui/bloc/home_bloc.dart';
import 'package:mc426_front/notifications/notifications.dart';
import 'package:mc426_front/storage/storage_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

class HomeUsecaseMock extends Mock implements GetHomeUsecase {}

class StorageSharedMock extends Mock implements StorageShared {}

class GetNotificationConfigUsecaseMock extends Mock implements GetNotificationConfigUsecase {}

class VoteUseCaseMock extends Mock implements VoteUseCase {}

void main() {
  late final GetHomeUsecase homeUsecase;
  late final StorageShared storageShared;
  late final VoteUseCase voteUseCase;
  late final GetNotificationConfigUsecase getNotificationConfigUsecase;

  setUpAll(() {
    final injection = GetIt.instance;
    homeUsecase = HomeUsecaseMock();
    storageShared = StorageSharedMock();
    voteUseCase = VoteUseCaseMock();
    getNotificationConfigUsecase = GetNotificationConfigUsecaseMock();

    injection.registerFactory<GetHomeUsecase>(() => homeUsecase);
    injection.registerFactory<StorageShared>(() => storageShared);
    injection.registerFactory<VoteUseCase>(() => voteUseCase);
    injection.registerFactory<GetNotificationConfigUsecase>(() => getNotificationConfigUsecase);
    registerFallbackValue(homeMock);
  });

  group("init", () {
    blocTest<HomeBloc, HomeState>(
      'should emit Loaded State when the request is completed',
      build: () {
        when(() => homeUsecase.call()).thenAnswer((_) async => homeMock);
        return HomeBloc();
      },
      act: (bloc) async {
        await bloc.init();
      },
      expect: () => [
        isA<HomeLoadingState>(),
        isA<HomeLoadedState>().having((s) => s.home.user.username, "username", "username"),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'should emit Error State when the request returns error',
      build: () {
        when(() => homeUsecase.call()).thenAnswer((_) async => null);
        return HomeBloc();
      },
      act: (bloc) async {
        await bloc.init();
      },
      expect: () => [
        isA<HomeLoadingState>(),
        isA<HomeErrorState>(),
      ],
    );
  });

  group("logout", () {
    test("should call clear on sharedPreferences", () async {
      when(
        () => storageShared.clearAll(),
      ).thenAnswer((invocation) async => {});

      final bloc = HomeBloc();
      bloc.logout();
      verify(() => storageShared.clearAll()).called(1);
    });
  });

  group("vote", () {
    test("should call vote usecase and return true when vote is true", () async {
      when(
        () => voteUseCase.call(any(), any()),
      ).thenAnswer((invocation) async => true);

      final bloc = HomeBloc();
      bloc.vote(1, true);
      verify(() => voteUseCase.call(any(), any())).called(1);
    });

    test("should call vote usecase and return false when vote is true", () async {
      when(
        () => voteUseCase.call(any(), any()),
      ).thenAnswer((invocation) async => false);

      final bloc = HomeBloc();
      bloc.vote(1, true);
      verify(() => voteUseCase.call(any(), any())).called(1);
    });

    test("should call vote usecase and return true when vote is false", () async {
      when(
        () => voteUseCase.call(any(), any()),
      ).thenAnswer((invocation) async => true);

      final bloc = HomeBloc();
      bloc.vote(1, false);
      verify(() => voteUseCase.call(any(), any())).called(1);
    });

    test("should call vote usecase and return false when vote is false", () async {
      when(
        () => voteUseCase.call(any(), any()),
      ).thenAnswer((invocation) async => false);

      final bloc = HomeBloc();
      bloc.vote(1, false);
      verify(() => voteUseCase.call(any(), any())).called(1);
    });
  });
}
