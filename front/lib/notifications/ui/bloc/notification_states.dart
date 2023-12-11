part of 'notification_bloc.dart';

sealed class NotificationState {}

class NotificationLoadingState extends NotificationState {
  NotificationLoadingState();
}

class NotificationLoadedState extends NotificationState {
  final Map<NotificationEntity, bool> notificationMap;

  NotificationLoadedState(this.notificationMap);
}

class NotificationErrorState extends NotificationState {
  NotificationErrorState();
}
