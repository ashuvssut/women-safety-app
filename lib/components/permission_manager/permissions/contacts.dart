import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class ContactsPerms {
  static String permanentDeniedFeedback = 'No Contact permissions. Unable to add trusted contacts.';

  static Future<PermissionStatus> check() async {
    return await Permission.contacts.status;
  }

  static Future<PermissionStatus> request() async {
    return await Permission.contacts.request();
  }

  static Future<void> handlePermanentlyDenied(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ContactsManualPermsGrantPopup();
      },
    );
  }

  // You can can also directly ask the permission about its status.
  // if (await Permission.contacts.isRestricted) {
  // The OS restricts access, for example because of parental controls.
  // }
}

class ContactsManualPermsGrantPopup extends StatelessWidget {
  const ContactsManualPermsGrantPopup({Key? key}) : super(key: key);

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
              leading: Icon(Icons.contacts),
              title: Text('Contacts'),
              subtitle: Text('To create your list of trusted contacts.'),
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
