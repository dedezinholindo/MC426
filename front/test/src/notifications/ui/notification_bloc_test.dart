import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/notifications/notifications.dart';
import 'package:mc426_front/notifications/ui/bloc/notification_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

class GetNotificationConfigUsecaseMock extends Mock implements GetNotificationConfigUsecase {}

class ChangeNotificationConfigUsecaseMock extends Mock implements ChangeNotificationConfigUsecase {}

void main() {
  late final GetNotificationConfigUsecase getNotificationConfigUsecase;
  late final ChangeNotificationConfigUsecase changeNotificationConfigUsecase;

  setUpAll(() {
    final injection = GetIt.instance;
    getNotificationConfigUsecase = GetNotificationConfigUsecaseMock();
    changeNotificationConfigUsecase = ChangeNotificationConfigUsecaseMock();

    injection.registerFactory<GetNotificationConfigUsecase>(() => getNotificationConfigUsecase);
    injection.registerFactory<ChangeNotificationConfigUsecase>(() => changeNotificationConfigUsecase);
    registerFallbackValue(notificationMock);
  });

  group("getNotifications", () {
    blocTest<NotificationBloc, NotificationState>(
      'should emit Loaded State when the request is completed',
      build: () {
        when(() => getNotificationConfigUsecase.call()).thenAnswer((_) async => [notificationMock]);
        return NotificationBloc();
      },
      act: (bloc) async {
        await bloc.getNotifications();
      },
      expect: () => [
        isA<NotificationLoadingState>(),
        isA<NotificationLoadedState>().having((s) => s.notificationMap.keys.first.id, "first_id", 1),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'should emit Error State when the request returns null',
      build: () {
        when(() => getNotificationConfigUsecase.call()).thenAnswer((_) async => null);
        return NotificationBloc();
      },
      act: (bloc) async {
        await bloc.getNotifications();
      },
      expect: () => [
        isA<NotificationLoadingState>(),
        isA<NotificationErrorState>(),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'should emit Error State fails when request fails',
      build: () {
        when(() => getNotificationConfigUsecase.call()).thenThrow(Exception());
        return NotificationBloc();
      },
      act: (bloc) async {
        await bloc.getNotifications();
      },
      expect: () => [
        isA<NotificationLoadingState>(),
        isA<NotificationErrorState>(),
      ],
    );
  });

  group("editNotification", () {
    blocTest<NotificationBloc, NotificationState>(
      'should emit Loaded State when the request is completed',
      build: () {
        when(() => changeNotificationConfigUsecase.call(any())).thenAnswer((_) async => true);
        return NotificationBloc();
      },
      act: (bloc) async {
        await bloc.editNotification(notificationMock);
      },
      expect: () => [
        isA<NotificationLoadedState>(),
        isA<NotificationLoadedState>().having((s) => s.notificationMap.keys.first.id, "first_id", 1),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'should emit Loaded State when the request returns false',
      build: () {
        when(() => changeNotificationConfigUsecase.call(any())).thenAnswer((_) async => false);
        return NotificationBloc();
      },
      act: (bloc) async {
        await bloc.editNotification(notificationMock);
      },
      expect: () => [
        isA<NotificationLoadedState>(),
        isA<NotificationLoadedState>().having((s) => s.notificationMap.keys.first.id, "first_id", 1),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'should emit Error State fails when request fails',
      build: () {
        when(() => changeNotificationConfigUsecase.call(any())).thenThrow(Exception());
        return NotificationBloc();
      },
      act: (bloc) async {
        await bloc.editNotification(notificationMock);
      },
      expect: () => [
        isA<NotificationLoadedState>(),
        isA<NotificationErrorState>(),
      ],
    );
  });
}
