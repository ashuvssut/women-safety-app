import 'package:flutter/material.dart';
import 'package:travelapp/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Travel App",
      home: HomeScreen(),
    );
  }
}
