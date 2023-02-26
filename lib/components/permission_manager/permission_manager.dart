import 'dart:developer';
import 'package:flutter/material.dart';
import 'permissions.dart';

class PermissionManager extends StatefulWidget {
  const PermissionManager({super.key});

  @override
  State<PermissionManager> createState() => _PermissionManagerState();
}

class _PermissionManagerState extends State<PermissionManager> {
  bool hasNotificationsPerms = false;
  bool hasSmsPerms = false;
  bool hasLocPerms = false;
  bool hasContactsPerms = false;

  void notificationPermsHandler(bool isAllowed) {
    setState(() => hasNotificationsPerms = isAllowed);
    if (isAllowed) {
      log('Notification permission granted');
      NotificationPerms.setListeners(context);
    } else {
      Future.delayed(Duration.zero, () => showPermsConsent());
      log('Notification permission denied');
    }
  }

  void getPermission() async {
    // await Permission.contacts.request();
    if (!hasNotificationsPerms) {
      await NotificationPerms.request() //
          .then((isAllowed) => notificationPermsHandler(isAllowed));
    }

    if (!hasSmsPerms) {
      // await SOSMethods.getSMSPermission();
    }

    // await SOSMethods.getLocationPermission();
    // await SOSMethods.getSMSPermission();
  }

  Future<void> showPermsConsent() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ConsentPopup(
          hasNotificationsPerms: hasNotificationsPerms,
          hasSmsPerms: hasSmsPerms,
          hasLocPerms: hasLocPerms,
          hasContactsPerms: hasContactsPerms,
          getPermission: getPermission,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    NotificationPerms.check().then((isAllowed) {
      notificationPermsHandler(isAllowed);
    });

    // if (!hasNotificationsPerms || !hasSmsPerms || !hasLocPerms || !hasContactsPerms) {
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class ConsentPopup extends StatelessWidget {
  const ConsentPopup({
    super.key,
    this.hasNotificationsPerms = false,
    this.hasSmsPerms = false,
    this.hasLocPerms = false,
    this.hasContactsPerms = false,
    required this.getPermission,
  });

  final bool hasNotificationsPerms;
  final bool hasSmsPerms;
  final bool hasLocPerms;
  final bool hasContactsPerms;
  final void Function() getPermission;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Grant necessary permissions'),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      titlePadding: const EdgeInsets.all(30),
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            !hasSmsPerms
                ? const ListTile(
                    leading: Icon(Icons.message),
                    title: Text('SMS'),
                    subtitle: Text('To send your SOS SMS messages.'),
                  )
                : const SizedBox.shrink(),
            !hasLocPerms
                ? const ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Location'),
                    subtitle: Text('To add your current location information in your SOS.'),
                  )
                : const SizedBox.shrink(),
            !hasContactsPerms
                ? const ListTile(
                    leading: Icon(Icons.contacts),
                    title: Text('Contacts'),
                    subtitle: Text('To create your list of trusted contacts.'),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Give Access'),
          onPressed: () {
            Navigator.of(context).pop();
            getPermission();
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
