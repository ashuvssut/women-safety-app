import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class SMSPerms {
  static String permanentDeniedFeedback =
      'No SMS permissions. Unable to send SOS SMS to your trusted contacts';

  static Future<PermissionStatus> check() async {
    return await Permission.sms.status;
  }

  static Future<PermissionStatus> request() async {
    return await Permission.sms.request();
  }

  static Future<void> handlePermanentlyDenied(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SmsManualPermsGrantPopup();
      },
    );
  }

  // You can can also directly ask the permission about its status.
  // if (await Permission.sms.isRestricted) {
  // The OS restricts access, for example because of parental controls.
  // }
}

class SmsManualPermsGrantPopup extends StatelessWidget {
  const SmsManualPermsGrantPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Grant necessary permissions'),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      titlePadding: const EdgeInsets.all(30),
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            ListTile(
              leading: Icon(Icons.message),
              title: Text('SMS'),
              subtitle: Text('To send your SOS SMS messages.'),
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Go to settings'),
          onPressed: () {
            Navigator.of(context).pop();
            openAppSettings();
          },
        ),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(40.0),
        ),
      ),
    );
  }
}
