import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/services/sos_notification_methods.dart';

class NotificationController {
  static ReceivedAction? initialAction;
  static Future<void> initializeLocalNotifications() async {
    // initialize all the notification channels here
    SosNotificationMethods.initializeSosChannel();

    // Get initial notification action is optional
    initialAction =
        await AwesomeNotifications().getInitialNotificationAction(removeFromActionEvents: false);
  }

  static Future<void> setListeners(BuildContext context) async {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENERS
  ///  *********************************************
  ///  we need to use @pragma("vm:entry-point") in each static method to identify to the Flutter engine that the dart address will be called from native and should be preserved.

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    if (receivedAction.channelKey == SosNotificationMethods.channelKey) {
      SosNotificationMethods.onSosNotificationActionReceived(receivedAction);
    }

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page', (route) => (route.settings.name != '/notification-page') || route.isFirst, arguments: receivedAction);
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    // log('created. finished: ' + receivedNotification.payload.values.toString());
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // log('displayed: finished: ' + receivedNotification.payload.values.toString());
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    // log('actions. finished: ' + receivedNotification.payload.values.toString());
    // log('actions. finished: ' + receivedNotification.buttonKeyPressed.toString());
    // String dismissedSourceText = AwesomeAssertUtils.toSimpleEnumString(receivedAction.dismissedLifeCycle)
    // Fluttertoast.showToast(msg: 'Notification dismissed on $dismissedSourceText');
  }
}
