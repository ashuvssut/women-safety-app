import 'package:flutter/material.dart';
// import 'package:women_safety_app/views/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:women_safety_app/views/signin.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'With You',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignIn(),
    );
  }
}