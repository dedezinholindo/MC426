import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc426_front/notifications/notifications.dart';
import 'package:mc426_front/notifications/ui/bloc/notification_bloc.dart';

class NotificationsPage extends StatefulWidget {
  static const String routeName = '/notifications';
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _bloc = NotificationBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _bloc.getNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      bloc: _bloc,
      builder: (context, state) {
        Widget? body = switch (state) {
          NotificationLoadingState() => const Center(child: CircularProgressIndicator()),
          NotificationLoadedState() => NotificationLoadedView(
              notificationMap: state.notificationMap,
              changeNotification: (changeNotification) async {
                try {
                  if (changeNotification.isActivated) {
                    await FirebaseMessaging.instance.unsubscribeFromTopic(changeNotification.topicName);
                  }
                } catch (e) {
                  log("Could not unsubscribeFromTopic on Firebase");
                }

                _bloc.editNotification(changeNotification);
              },
            ),
          NotificationErrorState() => const NotificationErrorView(),
        };

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text(
              "Notificações",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
          body: Scaffold(
            primary: false,
            body: body,
          ),
        );
      },
    );
  }
}
