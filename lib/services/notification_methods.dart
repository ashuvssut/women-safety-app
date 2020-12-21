import 'dart:math' hide log;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:women_safety_app/services/SOS_util.dart';

class NotificationMethods {
  static int maxStep = 10;
  static int simulatedStep;

  static Future<void> showProgressNotification(int id) async {
    for (simulatedStep = 1; simulatedStep <= maxStep + 1; simulatedStep++) {
      await Future.delayed(
        Duration(seconds: 1),
        () async {
          if (simulatedStep == maxStep + 1) {
            // CANCEL PROGRESS && SEND SOS
            await AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: id,
                channelKey: 'progress_bar',
                title: 'Initiate SOS',
                payload: {
                  'finished': 'true'
                },
                autoCancel: false,
                notificationLayout: NotificationLayout.ProgressBar,
                progress: null,
                locked: true,
              ),
              actionButtons: [
                NotificationActionButton(
                  key: 'START',
                  label: 'Send SOS',
                  autoCancel: false,
                  buttonType: ActionButtonType.Default,
                  enabled: true,
                ),
                NotificationActionButton(
                  key: 'STOP_DISABLED',
                  label: 'Cancel SOS',
                  autoCancel: false,
                  buttonType: ActionButtonType.Default,
                  enabled: false,
                )
              ],
            );
            SOSMethods.sendSOS();
          } else if (simulatedStep > maxStep + 1) {
            // CANCEL PROGRESS
            await AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: id,
                channelKey: 'progress_bar',
                title: 'Initiate SOS',
                payload: {
                  'finished': 'true'
                },
                autoCancel: false,
                notificationLayout: NotificationLayout.ProgressBar,
                progress: null,
                locked: true,
              ),
              actionButtons: [
                NotificationActionButton(
                  key: 'START',
                  label: 'Send SOS',
                  autoCancel: false,
                  buttonType: ActionButtonType.Default,
                  enabled: true,
                ),
                NotificationActionButton(
                  key: 'STOP_DISABLED',
                  label: 'Cancel SOS',
                  autoCancel: false,
                  buttonType: ActionButtonType.Default,
                  enabled: false,
                )
              ],
            );

          } else {
            await AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: id,
                channelKey: 'progress_bar',
                title: 'SOS is initiating in ${maxStep - simulatedStep} seconds',
                payload: {
                  'finished': 'false'
                },
                notificationLayout: NotificationLayout.ProgressBar,
                progress: min((simulatedStep / maxStep * 100).round(), 100),
                autoCancel: false,
                locked: true,
              ),
              actionButtons: [
                NotificationActionButton(
                  key: 'START_DISABLED',
                  label: 'Sending SOS...',
                  autoCancel: false,
                  buttonType: ActionButtonType.Default,
                  enabled: false,
                ),
                NotificationActionButton(
                  key: 'STOP',
                  label: 'Cancel SOS',
                  autoCancel: false,
                  buttonType: ActionButtonType.Default,
                  enabled: true,
                )
              ],
            );
          }
        },
      );
    }
  }

  static Future<void> createNullProgressNotification(int id) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'progress_bar',
        title: 'Initiate SOS',
        payload: {
          'finished': 'true'
        },
        autoCancel: false,
        notificationLayout: NotificationLayout.ProgressBar,
        progress: null,
        locked: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'START',
          label: 'Send SOS',
          autoCancel: false,
          buttonType: ActionButtonType.Default,
          enabled: true,
        ),
        NotificationActionButton(
          key: 'STOP_DISABLED',
          label: 'Cancel SOS',
          autoCancel: false,
          buttonType: ActionButtonType.Default,
          enabled: false,
        )
      ],
    );
  }

  static void cancelProgressNotification() {
    simulatedStep = maxStep + 2;
  }

  static Future<void> removeNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  static Future<void> removeAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}
