import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/auth.dart';
import 'views/home/home.dart';
import 'views/signin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    'resource://drawable/ic_stat_onesignal_default',
    [
      NotificationChannel(
        icon: 'resource://drawable/ic_stat_onesignal_default',
        channelKey: 'SOS_init',
        channelName: 'SOS Initializer',
        channelDescription: 'Notification channel for SOS Triggering',
        defaultColor: Colors.deepPurple,
        ledColor: Colors.deepPurple,
        vibrationPattern: lowVibrationPattern,
        onlyAlertOnce: true,
        importance: NotificationImportance.Max,
      ),
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const String appName = 'WithYou - Women Safety App';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget> getDefaultRoute() async {
    final user = await AuthMethods().getCurrentUser();
    if (user != null) return const Home();
    return const SignIn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // The navigator key is necessary to allow to navigate through static methods
      navigatorKey: MyApp.navigatorKey,

      title: MyApp.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: getDefaultRoute(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
