import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:women_safety_app/components/permission_manager/consent_popup.dart';
import 'package:women_safety_app/services/notification_controller.dart';
import 'permissions.dart';

class PermissionManager extends StatefulWidget {
  const PermissionManager({super.key, this.isCalledAsPopup = false});
  final bool isCalledAsPopup;

  @override
  State<PermissionManager> createState() => _PermissionManagerState();
}

// TODO: Implement isRestricted for SMS, Location & Contacts
class _PermissionManagerState extends State<PermissionManager> {
  bool hasNotificationsPerms = false;
  bool hasSmsPerms = false;
  bool hasLocPerms = false;
  bool hasContactsPerms = false;
  bool isConsentPopupOpen = false;

  Future<void> showPermsConsent() async {
    if (isConsentPopupOpen) return;
    isConsentPopupOpen = true;
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
          onDismiss: () => isConsentPopupOpen = false,
        );
      },
    );
  }

  void notificationPermsHandler(bool isAllowed) {
    setState(() => hasNotificationsPerms = isAllowed);
    if (isAllowed) {
      log('Notification permission granted');
      NotificationController.setListeners(context);
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

  Future<void> getPermission() async {
    if (!hasContactsPerms && mounted) {
      await ContactsPerms.request() //
          .then((status) => contactsPermsHandler(status));
    }
    if (!hasNotificationsPerms && mounted) {
      await NotificationPerms.request() //
          .then((isAllowed) => notificationPermsHandler(isAllowed));
    }
    if (!hasLocPerms && mounted) {
      await GeolocationPerms.request() //
          .then((status) => locationPermsHandler(status));
    }
    if (!hasSmsPerms && mounted) {
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
    if (widget.isCalledAsPopup) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
