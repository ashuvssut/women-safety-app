import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/services/notification_controller.dart';

class NotificationPerms {
  static Future<bool> check() async {
    return AwesomeNotifications().isNotificationAllowed();
  }

  static Future<bool> request() async {
    return AwesomeNotifications().requestPermissionToSendNotifications();
  }

  static Future<void> setListeners(BuildContext context) async {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (ReceivedAction receivedAction) {
        return NotificationController.onActionReceivedMethod(context, receivedAction);
      },
      onNotificationCreatedMethod: (ReceivedNotification receivedNotification) {
        return NotificationController.onNotificationCreatedMethod(context, receivedNotification);
      },
      onNotificationDisplayedMethod: (ReceivedNotification receivedNotification) {
        return NotificationController.onNotificationDisplayedMethod(context, receivedNotification);
      },
      onDismissActionReceivedMethod: (ReceivedAction receivedAction) {
        return NotificationController.onDismissActionReceivedMethod(context, receivedAction);
      },
    );
  }
}
