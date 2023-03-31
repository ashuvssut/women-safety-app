import 'package:flutter/material.dart';

class ConsentPopup extends StatelessWidget {
  const ConsentPopup({
    super.key,
    this.hasNotificationsPerms = false,
    this.hasSmsPerms = false,
    this.hasLocPerms = false,
    this.hasContactsPerms = false,
    required this.getPermission,
    required this.onDismiss,
  });

  final bool hasNotificationsPerms;
  final bool hasSmsPerms;
  final bool hasLocPerms;
  final bool hasContactsPerms;
  final Future<void> Function() getPermission;
  final bool Function() onDismiss;

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
                    subtitle: Text('To add your current location information in your SOS message.'),
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
          onPressed: () async {
            Navigator.of(context).pop();
            await getPermission();
            onDismiss();
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
