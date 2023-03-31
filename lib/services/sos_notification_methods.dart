import 'dart:developer';
import 'dart:math' hide log;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:women_safety_app/services/shared_preferences.dart';
import 'package:women_safety_app/services/sos_message_methods.dart';

class NotificationMethods {
  static int maxStep = 10;
  static int simulatedStep = 1;

  static Future<bool> createSendSosNotification(int id) async {
    return await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'progress_bar',
        title: 'Initiate SOS',
        payload: {'finished': 'true'},
        autoDismissible: false,
        notificationLayout: NotificationLayout.ProgressBar,
        progress: null,
        locked: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'START',
          label: 'Send SOS',
          autoDismissible: false,
          actionType: ActionType.Default,
          enabled: true,
        ),
        NotificationActionButton(
          key: 'STOP_DISABLED',
          label: 'Cancel SOS',
          autoDismissible: false,
          actionType: ActionType.Default,
          enabled: false,
        )
      ],
    );
  }

  static Future<bool> createProgressNotification(int id) async {
    return await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'progress_bar',
        title: 'SOS is initiating in ${maxStep - simulatedStep} seconds',
        payload: {'finished': 'false'},
        notificationLayout: NotificationLayout.ProgressBar,
        progress: min((simulatedStep / maxStep * 100).round(), 100),
        autoDismissible: false,
        locked: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'START_DISABLED',
          label: 'Sending SOS...',
          autoDismissible: false,
          actionType: ActionType.Default,
          enabled: false,
        ),
        NotificationActionButton(
          key: 'STOP',
          label: 'Cancel SOS',
          autoDismissible: false,
          actionType: ActionType.Default,
          enabled: true,
        )
      ],
    );
  }

  static Future<void> initiateSosProgressNotification(int id) async {
    int? sosDelayTime = await SharedPreferenceHelper.getSosDelayTime();
    if (sosDelayTime != null) {
      log('delay time is $sosDelayTime');
      maxStep = sosDelayTime;
    } else {
      maxStep = 10;
      await SharedPreferenceHelper.saveSosDelayTime(maxStep);
    }

    for (simulatedStep = 1; simulatedStep <= maxStep + 1; simulatedStep++) {
      await Future.delayed(
        const Duration(seconds: 1),
        () async {
          if (simulatedStep == maxStep + 1) {
            // CANCEL PROGRESS && SEND SOS
            createSendSosNotification(id);
            SosMethods.sendSos();
          } else if (simulatedStep > maxStep + 1) {
            // CANCEL PROGRESS
            createSendSosNotification(id);
          } else {
            createProgressNotification(id);
          }
        },
      );
    }
  }

  static void cancelProgressNotification() {
    simulatedStep = maxStep + 2; // hits loop break statement in showProgressNotification() method
  }

  static Future<void> removeNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  static Future<void> removeAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}
