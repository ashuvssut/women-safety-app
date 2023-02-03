import 'package:flutter/material.dart';

class VideoLib extends StatefulWidget {
  @override
  _VideoLibState createState() => _VideoLibState();
}

class _VideoLibState extends State<VideoLib> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Self Defence and Awareness",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Text(
          "This Screen is under development",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
