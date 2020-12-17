import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:women_safety_app/helper_functions/shared_preference.dart';
import 'package:women_safety_app/services/auth.dart';
import 'package:women_safety_app/views/articles.dart';
import 'package:women_safety_app/views/settings.dart';
import 'package:women_safety_app/views/signin.dart';
import 'package:women_safety_app/views/video_library.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userName, userEmail, imageURL;
  @override
  void initState() {
    SharedPreferenceHelper.getUserNameKey()
        .then((value) => setState(() => {userName = value}));
    SharedPreferenceHelper.getUserEmail()
        .then((value) => setState(() => {userEmail = value}));
    SharedPreferenceHelper.getUserProfilePicKey()
        .then((value) => setState(() => {imageURL = value}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "With You",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(userName == null ? "" : userName),
              accountEmail: new Text(userEmail == null ? "" : userEmail),
              currentAccountPicture: new CircleAvatar(
                  backgroundImage: new NetworkImage(imageURL == null
                      ? "assets/icons/account.svg"
                      : imageURL)),
            ),
            new ListTile(
              title: Text("Settings"),
              subtitle: Text("SOS delay, Edit SOS message..."),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
              trailing: FittedBox(
                child: Icon(Icons.settings, size: 35),
              ),
            ),
            new ListTile(
              title: Text("Logout"),
              tileColor: Colors.grey[300],
              onTap: () {
                AuthMethods().signOut();
                Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
              trailing: FittedBox(
                child: SvgPicture.asset(
                  "assets/icons/log-out.svg",
                  height: size.height * 0.04,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
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
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Articles()),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black26,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        height: 150,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                "assets/icons/law.svg",
                                height: size.height * 0.1,
                              ),
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
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VideoLib()),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black26,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        height: 150,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                "assets/icons/self.svg",
                                height: size.height * 0.1,
                              ),
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
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
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
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "Send Emergency",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 21,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                  Center(
                    child: ElevatedButton(
                      child: SvgPicture.asset(
                        "assets/icons/alert.svg",
                        height: size.height * 0.1,
                        color: Colors.white,
                      ),
                      onPressed: () => print("it's pressed"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        padding: EdgeInsets.all(30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 18.0, right: 60, left: 60),
                    child: ElevatedButton(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 35.0, top: 8, bottom: 8, right: 8),
                            child: SvgPicture.asset(
                              "assets/icons/add_alert.svg",
                              height: size.height * 0.05,
                              color: Colors.white,
                            ),
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
                      onPressed: () => print("it's pressed"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.white,
                        padding: EdgeInsets.all(4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
