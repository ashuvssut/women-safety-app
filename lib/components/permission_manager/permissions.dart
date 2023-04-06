import 'package:flutter/material.dart';
import 'package:women_safety_app/components/permission_manager/permission_manager.dart';
import 'package:women_safety_app/main.dart';

export 'permissions/geolocation.dart';
export 'permissions/notification.dart';
export 'permissions/sms.dart';
export 'permissions/contacts.dart';
export 'package:permission_handler/permission_handler.dart';

class PermissionMethods {
  static Future<void> initiatePermissionManger() async {
    final context = MyApp.navigatorKey.currentState?.context;
    if (context == null) return;

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const PermissionManager(isCalledAsPopup: true);
      },
    );
  }
}
