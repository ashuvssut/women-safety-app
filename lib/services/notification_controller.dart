// import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/widgets.dart';

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point") // we need to use @pragma("vm:entry-point") in each static method to identify to the Flutter engine that the dart address will be called from native and should be preserved.
  static Future<void> onNotificationCreatedMethod(BuildContext context, ReceivedNotification receivedNotification) async {
    // log('created. finished: ' + receivedNotification.payload.values.toString());
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(BuildContext context, ReceivedNotification receivedNotification) async {
    // log('displayed: finished: ' + receivedNotification.payload.values.toString());
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(BuildContext context, ReceivedAction receivedAction) async {
    // log('actions. finished: ' + receivedNotification.payload.values.toString());
    // log('actions. finished: ' + receivedNotification.buttonKeyPressed.toString());
    // String dismissedSourceText = AwesomeAssertUtils.toSimpleEnumString(receivedAction.dismissedLifeCycle)
    // Fluttertoast.showToast(msg: 'Notification dismissed on $dismissedSourceText');
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(BuildContext context, ReceivedAction receivedAction) async {
    if (receivedAction.buttonKeyPressed == 'START') {
      //PRESSED SEND SOS
      // NotificationMethods.showProgressNotification(1337);
    } else if (receivedAction.buttonKeyPressed == 'STOP') {
      //PRESSED CANCEL
      // NotificationMethods.cancelProgressNotification();
    }

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page', (route) => (route.settings.name != '/notification-page') || route.isFirst, arguments: receivedAction);
  }
}
