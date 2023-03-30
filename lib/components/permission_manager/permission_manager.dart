import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'permissions.dart';

class PermissionManager extends StatefulWidget {
  const PermissionManager({super.key});

  @override
  State<PermissionManager> createState() => _PermissionManagerState();
}

// TODO: Implement isRestricted for SMS, Location & Contacts
class _PermissionManagerState extends State<PermissionManager> {
  bool hasNotificationsPerms = false;
  bool hasSmsPerms = false;
  bool hasLocPerms = false;
  bool hasContactsPerms = false;

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

  void smsPermsHandler(PermissionStatus status) {
    setState(() => hasSmsPerms = status.isGranted);
    if (status.isGranted) {
      log('SMS permission granted');
    } else if (status.isDenied) {
      Future.delayed(Duration.zero, () => showPermsConsent());
      log('SMS permission denied');
    } else if (status.isPermanentlyDenied) {
      log('SMS permission permanently denied');
      Fluttertoast.showToast(msg: SMSPerms.permanentDeniedFeedback);
      SMSPerms.handlePermanentlyDenied(context);
    } // else if (status.isRestricted) {}
  }

  void locationPermsHandler(PermissionStatus status) {
    setState(() => hasLocPerms = status.isGranted);
    if (status.isGranted) {
      log('Location permission granted');
    } else if (status.isDenied) {
      Future.delayed(Duration.zero, () => showPermsConsent());
      log('Location permission denied');
    } else if (status.isPermanentlyDenied) {
      Fluttertoast.showToast(msg: GeolocationPerms.permanentDeniedFeedback);
      log('Location permission permanently denied');
      GeolocationPerms.handlePermanentlyDenied(context);
    } // else if (status.isRestricted) {}
  }

  void contactsPermsHandler(PermissionStatus status) {
    setState(() => hasContactsPerms = status.isGranted);
    if (status.isGranted) {
      log('Contacts permission granted');
    } else if (status.isDenied) {
      Future.delayed(Duration.zero, () => showPermsConsent());
      log('Contacts permission denied');
    } else if (status.isPermanentlyDenied) {
      Fluttertoast.showToast(msg: ContactsPerms.permanentDeniedFeedback);
      log('Contacts permission permanently denied');
      ContactsPerms.handlePermanentlyDenied(context);
    } // else if (status.isRestricted) {}
  }

  void getPermission() async {
    if (!hasContactsPerms) {
      await ContactsPerms.request() //
          .then((status) => contactsPermsHandler(status));
    }
    if (!hasNotificationsPerms) {
      await NotificationPerms.request() //
          .then((isAllowed) => notificationPermsHandler(isAllowed));
    }
    if (!hasLocPerms) {
      await GeolocationPerms.request() //
          .then((status) => locationPermsHandler(status));
    }
    if (!hasSmsPerms) {
      await SMSPerms.request() //
          .then((status) => smsPermsHandler(status));
    }
  }

  @override
  void initState() {
    super.initState();

    ContactsPerms.check().then((status) {
      contactsPermsHandler(status);
    });
    NotificationPerms.check().then((isAllowed) {
      notificationPermsHandler(isAllowed);
    });
    SMSPerms.check().then((status) {
      smsPermsHandler(status);
    });
    GeolocationPerms.check().then((status) {
      locationPermsHandler(status);
    });
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
