import "package:flutter/material.dart";
import "package:women_safety_app/components/app_drawer.dart";
import 'package:women_safety_app/components/permission_manager/permission_manager.dart';
import "package:women_safety_app/services/sos_methods.dart";
import "package:women_safety_app/views/settings.dart";
import "top_banner.dart";
import "bottom_content.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Update SOS Shared Prefs
    SosMethods.initializeAllSosPrefs();
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
