import "package:flutter/material.dart";
import "package:women_safety_app/components/app_drawer.dart";
import 'package:women_safety_app/components/permission_manager/permission_manager.dart';
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

  @override
  void initState() {
    super.initState();
    // Update SOS Shared Prefs
    SmsMethods.initializeAllSmsPrefs();
  }

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
          BottomContent(key: UniqueKey()),
          PermissionManager(key: UniqueKey()),
        ],
      ),
    );
  }
}
