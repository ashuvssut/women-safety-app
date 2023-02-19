import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:women_safety_app/services/shared_preferences.dart';
import 'package:women_safety_app/views/settings.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String userName = "", userEmail = "", imageURL = "";

  @override
  void initState() {
    super.initState();
    SharedPreferenceHelper.getUserNameKey().then((value) => setState(() => userName = value ?? ""));
    SharedPreferenceHelper.getUserEmail().then((value) => setState(() => userEmail = value ?? ""));
    SharedPreferenceHelper.getUserProfilePicKey()
        .then((value) => setState(() => imageURL = value ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: Text(userEmail),
            currentAccountPicture: imageURL != ""
                ? const Icon(Icons.account_circle_rounded, size: 55)
                : CircleAvatar(backgroundImage: NetworkImage(imageURL)),
          ),
          ListTile(
            title: const Text("Settings"),
            subtitle: const Text("SOS delay, Edit SOS message"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Settings()),
            ),
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
            trailing: SvgPicture.asset("assets/icons/log-out.svg", height: 25),
          ),
        ],
      ),
    );
  }
}
