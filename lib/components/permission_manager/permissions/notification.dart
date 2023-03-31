import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationPerms {
  static Future<bool> check() async {
    return AwesomeNotifications().isNotificationAllowed();
  }

  static Future<bool> request() async {
    return AwesomeNotifications().requestPermissionToSendNotifications();
  }
}
