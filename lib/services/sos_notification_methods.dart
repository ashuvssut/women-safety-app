import 'dart:developer';
import 'dart:math' hide log;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:women_safety_app/services/database_methods.dart';
import 'package:women_safety_app/services/shared_preferences.dart';
import 'package:women_safety_app/services/sos_message_methods.dart';

class SosNotificationMethods {
  static String channelKey = 'SOS_init';

  static Future<void> initializeSosChannel() async {
    await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/ic_stat_onesignal_default',
      [
        NotificationChannel(
          icon: 'resource://drawable/ic_stat_onesignal_default',
          channelKey: channelKey,
          channelName: 'SOS Initializer',
          channelDescription: 'Notification channel for SOS Triggering',
          defaultColor: Colors.deepPurple,
          ledColor: Colors.deepPurple,
          vibrationPattern: lowVibrationPattern,
          onlyAlertOnce: true,
          importance: NotificationImportance.Max,
        ),
      ],
      debug: true,
    );
  }

  static Future<bool> createSendSosNotification(int id) async {
    return await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: "Initiate SOS",
        payload: {'finished': 'true'},
        autoDismissible: false,
        notificationLayout: NotificationLayout.Default,
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
      ],
    );
  }

  static int maxStep = 10;
  static int simulatedStep = 1;
  static Future<bool> createSendingSosProgressNotification(int id) async {
    return await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: 'SOS is initiating in ${maxStep - simulatedStep} seconds',
        payload: {'finished': 'false'},
        notificationLayout: NotificationLayout.ProgressBar,
        progress: min((simulatedStep / maxStep * 100).round(), 100),
        autoDismissible: false,
        locked: true,
      ),
      actionButtons: [
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
    await removeNotification();
    for (simulatedStep = 1; simulatedStep <= maxStep + 1; simulatedStep++) {
      await Future.delayed(
        const Duration(seconds: 1),
        () async {
          log('simulatedStep is $simulatedStep');
          if (simulatedStep == maxStep + 1) {
            cancelProgressNotification();
            await createSendSosNotification(id);
            SosMethods.sendSos();
          } else if (simulatedStep > maxStep + 1) {
            cancelProgressNotification();
            await createSendSosNotification(id);
          } else {
            createSendingSosProgressNotification(id);
          }
        },
      );
    }
  }

  static void cancelProgressNotification() {
    simulatedStep = maxStep + 2; // hits loop break condition in showProgressNotification() method
  }

  static Future<void> removeNotification() async {
    await AwesomeNotifications().cancelNotificationsByChannelKey(channelKey);
    simulatedStep = 1;
  }

  static onSosNotificationActionReceived(ReceivedAction receivedAction) {
    if (receivedAction.buttonKeyPressed == 'START') {
      //PRESSED SEND SOS
      Fluttertoast.showToast(
        msg: 'SOS is initiating. You can cancel it from notification bar',
      );
      initiateSosProgressNotification(1337);
    } else if (receivedAction.buttonKeyPressed == 'STOP') {
      //PRESSED CANCEL
      cancelProgressNotification();
    }
  }

  static void manageSosNotificationVisibility() async {
    final databaseMethods = DatabaseMethods();
    int count = await databaseMethods.getCount();
    if (count != 0) {
      createSendSosNotification(1337);
    } else {
      removeNotification();
    }
  }
}
