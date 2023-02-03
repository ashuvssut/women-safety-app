import 'dart:math' hide log;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:women_safety_app/helper_functions/shared_preference.dart';
import 'package:women_safety_app/services/SOS_util.dart';

class NotificationMethods {
  static int maxStep;
  static int simulatedStep;

  static Future<void> showProgressNotification(int id) async {
    int sosDelayTime = await SharedPreferenceHelper.getSOSdelayTime();
    if (sosDelayTime != null) {
      print('delay time is $sosDelayTime');
      maxStep = sosDelayTime;
    } else {
      maxStep = 10;
      await SharedPreferenceHelper.saveSOSdelayTime(maxStep);
    }

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
                  buttonType: ActionButtonType.Default,
                  enabled: true,
                ),
                NotificationActionButton(
                  key: 'STOP_DISABLED',
                  label: 'Cancel SOS',
                  autoDismissible: false,
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
                  buttonType: ActionButtonType.Default,
                  enabled: true,
                ),
                NotificationActionButton(
                  key: 'STOP_DISABLED',
                  label: 'Cancel SOS',
                  autoDismissible: false,
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
                autoDismissible: false,
                locked: true,
              ),
              actionButtons: [
                NotificationActionButton(
                  key: 'START_DISABLED',
                  label: 'Sending SOS...',
                  autoDismissible: false,
                  buttonType: ActionButtonType.Default,
                  enabled: false,
                ),
                NotificationActionButton(
                  key: 'STOP',
                  label: 'Cancel SOS',
                  autoDismissible: false,
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
          buttonType: ActionButtonType.Default,
          enabled: true,
        ),
        NotificationActionButton(
          key: 'STOP_DISABLED',
          label: 'Cancel SOS',
          autoDismissible: false,
          buttonType: ActionButtonType.Default,
          enabled: false,
        )
      ],
    );
  }

  static void cancelProgressNotification() {
    simulatedStep = maxStep + 2; //hits loop break statement in showProgressNotification()
  }

  static Future<void> removeNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  static Future<void> removeAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}
