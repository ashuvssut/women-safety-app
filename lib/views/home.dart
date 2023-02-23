// import 'dart:developer';

import "package:flutter/material.dart";
import "package:women_safety_app/services/notification_controller.dart";
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
import 'package:awesome_notifications/awesome_notifications.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // DatabaseHelper databaseHelper = DatabaseHelper();
  // String userName, userEmail, imageURL;
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
    // SharedPreferenceHelper.getUserNameKey().then((value) => setState(() => {
    //       userName = value
    //     }));
    // SharedPreferenceHelper.getUserEmail().then((value) => setState(() => {
    //       userEmail = value
    //     }));
    // SharedPreferenceHelper.getUserProfilePicKey().then((value) => setState(() => {
    //       imageURL = value
    //     }));

    // Ensure Notifications are Allowed

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      notificationsAllowed = isAllowed;

      if (!isAllowed) {
        // requestUserPermission(isAllowed);
        AwesomeNotifications().requestPermissionToSendNotifications();
      } else {
        // log('Notifications are allowed');
      }
    });

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (ReceivedAction receivedAction) {
        return NotificationController.onActionReceivedMethod(context, receivedAction);
      },
      onNotificationCreatedMethod: (ReceivedNotification receivedNotification) {
        return NotificationController.onNotificationCreatedMethod(context, receivedNotification);
      },
      onNotificationDisplayedMethod: (ReceivedNotification receivedNotification) {
        return NotificationController.onNotificationDisplayedMethod(context, receivedNotification);
      },
      onDismissActionReceivedMethod: (ReceivedAction receivedAction) {
        return NotificationController.onDismissActionReceivedMethod(context, receivedAction);
      },
    );

    // Update SOS Shared Prefs
    // SharedPreferenceHelper.getMessageHead().then((value) async {
    //   if (value != null) {
    //     print('MessageHead is $value');
    //   } else {
    //     print('MessageHead is $value');
    //     value = "I'm in trouble, plz help me. Reach this location:";
    //     SharedPreferenceHelper.saveMessageHead(value);
    //   }
    // });

    // SharedPreferenceHelper.getSOSdelayTime().then((value) async {
    //   if (value != null) {
    //     print('SOSdelayTime is $value');
    //   } else {
    //     print('SOSdelayTime is $value');
    //     value = 10;
    //     SharedPreferenceHelper.saveSOSdelayTime(value);
    //   }
    // });

    // SharedPreferenceHelper.getSOSrepeatInterval().then((value) async {
    //   if (value != null) {
    //     print('SOS repeat interval is $value');
    //   } else {
    //     print('SOS repeat interval is $value');
    //     value = 120;
    //     SharedPreferenceHelper.saveSOSrepeatInterval(value);
    //   }
    // });

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
    // Size size = MediaQuery.of(context).size;
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
      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            // UserAccountsDrawerHeader(
            //   accountName: Text(userName == null ? "" : userName),
            //   accountEmail: Text(userEmail == null ? "" : userEmail),
            //   currentAccountPicture: imageURL == null ? const Icon(Icons.account_circle_rounded, size: 55) : CircleAvatar(backgroundImage: NetworkImage(imageURL)),
            // ),
            ListTile(
              title: const Text("Settings"),
              subtitle: const Text("SOS delay, Edit SOS message..."),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SettingsPage()),
                // );
              },
              trailing: const FittedBox(
                child: Icon(Icons.settings, size: 25),
              ),
            ),
            ListTile(
              title: const Text("Logout"),
              tileColor: Colors.grey[300],
              onTap: () async {
                // NotificationMethods.removeAllNotifications();
                // await AuthMethods().signOut();
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => SignIn()),
                // );
              },
              // trailing: SvgPicture.asset(
              //   "assets/icons/log-out.svg",
              //   height: 25,
              // ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            color: Colors.transparent,
            child: Center(
              child: Wrap(
                spacing: 20, // to apply margin in the main axis of the wrap
                runSpacing: 20, // to apply margin in the cross axis of the wrap
                children: [
                  ButtonTheme(
                    buttonColor: Colors.white,
                    height: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Articles()),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.black26,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        margin: const EdgeInsetsDirectional.symmetric(vertical: 20),
                        // height: 150,
                        child: Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              // child: SvgPicture.asset(
                              //   "assets/icons/law.svg",
                              //   height: size.height * 0.1,
                              // ),
                            ),
                            Text(
                              "Women Safety Laws",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    buttonColor: Colors.white,
                    height: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => VideoLib()),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.black26,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        margin: const EdgeInsetsDirectional.symmetric(vertical: 20),
                        child: Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(5),
                              // child: SvgPicture.asset(
                              //   "assets/icons/self.svg",
                              //   height: size.height * 0.1,
                              // ),
                            ),
                            Text(
                              "Self Defence and Awareness",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 36, 16, 5),
                  child: Column(
                    children: const [
                      Text(
                        "Send Emergency",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 21,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0),
                        child: Text(
                          "SOS",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 28,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Center(
                //   child: ElevatedButton(
                //     child: SvgPicture.asset(
                //       "assets/icons/alert.svg",
                //       height: size.height * 0.1,
                //       color: Colors.white,
                //     ),
                //     onPressed: () {
                //       _triggerSendSOS();
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: const Color.fromARGB(255, 255, 110, 99),
                //       foregroundColor: Colors.white,
                //       padding: const EdgeInsets.all(30),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(45.0),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, right: 60, left: 60),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => AddContacts()),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 35.0, top: 8, bottom: 8, right: 8),
                          // child: SvgPicture.asset(
                          //   "assets/icons/add_alert.svg",
                          //   height: size.height * 0.03,
                          //   color: Colors.white,
                          // ),
                        ),
                        Text(
                          "Add Contacts",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 21,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  // void _triggerSendSOS() async {
  //   int count = await databaseHelper.getCount();

  //   if (count == 0) {
  //     Fluttertoast.showToast(msg: 'Please Add Trusted contacts to send SOS.');
  //   } else {
  //     Fluttertoast.showToast(msg: 'Sending SOS...');
  //     NotificationMethods.showProgressNotification(1337);
  //   }
  // }
}
