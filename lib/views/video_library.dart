import 'package:flutter/material.dart';

class VideoLib extends StatefulWidget {
  const VideoLib({super.key});

  @override
  State<VideoLib> createState() => _VideoLibState();
}

class _VideoLibState extends State<VideoLib> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Self Defence and Awareness",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: const Text(
        "This Screen is under development",
        textAlign: TextAlign.center,
      ),
    );
  }
}
