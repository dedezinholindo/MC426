import 'package:flutter/material.dart';
import 'package:mc426_front/notifications/notifications.dart';

class NotificationLoadedView extends StatelessWidget {
  final Map<NotificationEntity, bool> notificationMap;
  final ValueChanged<NotificationEntity> changeNotification;

  const NotificationLoadedView({required this.notificationMap, required this.changeNotification, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: notificationMap.length,
        itemBuilder: (context, index) {
          final notification = notificationMap.keys.toList()[index];
          final isLoading = notificationMap.values.toList()[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      notification.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                if (isLoading) ...[const CircularProgressIndicator()] else
                  Switch(
                    value: notification.isActivated,
                    onChanged: (_) => changeNotification(notification),
                    inactiveThumbColor: const Color(0xFF787878),
                    inactiveTrackColor: const Color(0xFF5F5F5F),
                    activeColor: const Color(0xFF4CE5B1),
                  ),
              ],
            ),
          );
        });
  }
}
