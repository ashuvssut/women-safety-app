import "package:flutter/material.dart";
import "package:women_safety_app/components/app_drawer.dart";
// import "package:women_safety_app/services/notification_controller.dart";
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:giffy_dialog/giffy_dialog.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:women_safety_app/helper_functions/database_helper.dart';
// import 'package:women_safety_app/helper_functions/shared_preference.dart';
// import 'package:women_safety_app/services/SOS_util.dart';
// import 'package:women_safety_app/services/auth.dart';
// import 'package:women_safety_app/services/notification_methods.dart';
// import 'package:women_safety_app/services/notification_stream_listeners.dart';
// import 'package:women_safety_app/views/articles.dart';
// import 'package:women_safety_app/views/add_contact.dart';
// import 'package:women_safety_app/views/settings.dart';
// import 'package:women_safety_app/views/signin.dart';
// import 'package:women_safety_app/views/video_library.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
import "package:women_safety_app/services/sms_methods.dart";
import "package:women_safety_app/views/settings.dart";
import "top_banner.dart";
import "bottom_content.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // DatabaseHelper databaseHelper = DatabaseHelper();

  bool notificationsAllowed = false;

  void getPermission() async {
    // await Permission.contacts.request();
    // await SOSMethods.getLocationPermission();
    // await SOSMethods.getSMSPermission();
  }

  @override
  void initState() {
    super.initState();

    // Prepare elements for drawer widget

    // Ensure Notifications are Allowed

    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   notificationsAllowed = isAllowed;

    //   if (!isAllowed) {
    //     // requestUserPermission(isAllowed);
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //   } else {
    //     // log('Notifications are allowed');
    //   }
    // });

    // AwesomeNotifications().setListeners(
    //   onActionReceivedMethod: (ReceivedAction receivedAction) {
    //     return NotificationController.onActionReceivedMethod(context, receivedAction);
    //   },
    //   onNotificationCreatedMethod: (ReceivedNotification receivedNotification) {
    //     return NotificationController.onNotificationCreatedMethod(context, receivedNotification);
    //   },
    //   onNotificationDisplayedMethod: (ReceivedNotification receivedNotification) {
    //     return NotificationController.onNotificationDisplayedMethod(context, receivedNotification);
    //   },
    //   onDismissActionReceivedMethod: (ReceivedAction receivedAction) {
    //     return NotificationController.onDismissActionReceivedMethod(context, receivedAction);
    //   },
    // );
    // Update SOS Shared Prefs
    SmsMethods.initializeAllSmsPrefs();

    getPermission();
  }

  // void requestUserPermission(bool isAllowed) async {
  //   showDialog(
  //     context: context,
  //     builder: (_) => NetworkGiffyDialog(
  //       buttonOkText: const Text(
  //         'Allow',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       buttonCancelText: const Text(
  //         'Later',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       buttonCancelColor: Colors.grey,
  //       buttonOkColor: Colors.deepPurple,
  //       buttonRadius: 0.0,
  //       image: Image.asset("assets/images/animated-bell.gif", fit: BoxFit.cover),
  //       title: const Text(
  //         'Get Notified!',
  //         textAlign: TextAlign.center,
  //         style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
  //       ),
  //       description: const Text(
  //         'Allow Awesome Notifications to send you beautiful notifications!',
  //         textAlign: TextAlign.center,
  //       ),
  //       entryAnimation: EntryAnimation.DEFAULT,
  //       onCancelButtonPressed: () async {
  //         Navigator.of(context).pop();
  //         notificationsAllowed = await AwesomeNotifications().isNotificationAllowed();
  //         setState(
  //           () {
  //             notificationsAllowed = notificationsAllowed;
  //           },
  //         );
  //       },
  //       onOkButtonPressed: () async {
  //         Navigator.of(context).pop();
  //         await AwesomeNotifications().requestPermissionToSendNotifications();
  //         notificationsAllowed = await AwesomeNotifications().isNotificationAllowed();
  //         setState(
  //           () {
  //             notificationsAllowed = notificationsAllowed;
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "WithYou",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 70, 16, 24),
            child: TopBanner(key: UniqueKey()),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              title: const Text("Edit SOS Settings"),
              subtitle: const Text("SOS delay, SOS message"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              ),
              trailing: const FittedBox(
                child: Icon(Icons.settings, size: 25),
              ),
            ),
          ),
          BottomContent(key: UniqueKey())
        ],
      ),
    );
  }
}
