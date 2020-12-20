import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:women_safety_app/utils/SOS_util.dart';

int maxStep = 10;
int simulatedStep;
Future<void> showProgressNotification(int id) async {
  for (simulatedStep = 1; simulatedStep <= maxStep + 1; simulatedStep++) {
    await Future.delayed(
      Duration(seconds: 1),
      () async {
        if (simulatedStep == maxStep + 1) {// CANCEL PROGRESS && SEND SOS
          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: id,
              channelKey: 'progress_bar',
              title: 'Initiate SOS',
              payload: {'finished': 'true'},
              notificationLayout: NotificationLayout.ProgressBar,
              progress: null,
              locked: true,
            ),
            actionButtons: [
              NotificationActionButton(
                key: 'START',
                label: 'Send SOS',
                autoCancel: false,
                buttonType: ActionButtonType.KeepOnTop,
                enabled: true,
              ),
              NotificationActionButton(
                key: 'STOP_DISABLED',
                label: 'Cancel SOS',
                autoCancel: true,
                buttonType: ActionButtonType.KeepOnTop,
                enabled: false,
              )
            ],
          );
        } else if (simulatedStep > maxStep + 1) {// CANCEL PROGRESS
          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: id,
              channelKey: 'progress_bar',
              title: 'Initiate SOS',
              payload: {'finished': 'true'},
              notificationLayout: NotificationLayout.ProgressBar,
              progress: null,
              locked: true,
            ),
            actionButtons: [
              NotificationActionButton(
                key: 'START',
                label: 'Send SOS',
                autoCancel: false,
                buttonType: ActionButtonType.KeepOnTop,
                enabled: true,
              ),
              NotificationActionButton(
                key: 'STOP_DISABLED',
                label: 'Cancel SOS',
                autoCancel: true,
                buttonType: ActionButtonType.KeepOnTop,
                enabled: false,
              )
            ],
          );

          sendSOS();
        } else {
          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: id,
              channelKey: 'progress_bar',
              title: 'SOS is initiating in ${maxStep - simulatedStep} seconds',
              payload: {'finished': 'false'},
              notificationLayout: NotificationLayout.ProgressBar,
              progress: min((simulatedStep / maxStep * 100).round(), 100),
              locked: true,
            ),
            actionButtons: [
              NotificationActionButton(
                key: 'START_DISABLED',
                label: 'Sending SOS...',
                autoCancel: false,
                buttonType: ActionButtonType.KeepOnTop,
                enabled: false,
              ),
              NotificationActionButton(
                key: 'STOP',
                label: 'Cancel SOS',
                autoCancel: true,
                buttonType: ActionButtonType.KeepOnTop,
                enabled: true,
              )
            ],
          );
        }
      },
    );
  }
}

void cancelProgressNotification(){
  simulatedStep = maxStep + 2;
}

Future<void> removeNotification(int id) async {
  await AwesomeNotifications().cancel(id);
}

Future<void> removeAllNotifications() async {
  await AwesomeNotifications().cancelAll();
}
