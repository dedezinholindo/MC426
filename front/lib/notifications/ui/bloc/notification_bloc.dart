import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/notifications/domain/domain.dart';

part 'notification_states.dart';

class NotificationBloc extends Cubit<NotificationState> {
  NotificationBloc() : super(NotificationLoadingState());

  final getNotificationUsecase = GetIt.instance.get<GetNotificationConfigUsecase>();
  final changeNotificationUsecase = GetIt.instance.get<ChangeNotificationConfigUsecase>();

  Map<NotificationEntity, bool> _notificationMap = {};

  Future<void> getNotifications() async {
    emit(NotificationLoadingState());
    try {
      final result = await getNotificationUsecase.call();

      if (result == null) return emit(NotificationErrorState());

      for (var e in result) {
        _notificationMap[e] = false;
      }

      emit(NotificationLoadedState(_notificationMap));
    } catch (e) {
      emit(NotificationErrorState());
    }
  }

  Future<void> editNotification(NotificationEntity notification) async {
    try {
      _notificationMap[notification] = true;
      emit(NotificationLoadedState(_notificationMap));

      final result = await changeNotificationUsecase.call(notification);

      if (!result) {
        _notificationMap[notification] = false;
        return emit(NotificationLoadedState(_notificationMap));
      }

      _notificationMap = Map.fromEntries(_notificationMap.entries.map(
          (entry) => entry.key == notification ? MapEntry(notification.copyWith(isActivated: !notification.isActivated), false) : entry));

      emit(NotificationLoadedState(_notificationMap));
    } catch (e) {
      emit(NotificationErrorState());
    }
  }
}
