import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:women_safety_app/views/articles.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("With You"),
      ),
      body: Row(
        children: [
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Articles()),
              );
            },
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black45,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              width: 100,
              height: 100,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      "assets/icons/law.svg",
                      height: size.height * 0.05,
                    ),
                  ),
                  Text(
                    "Laws Realted to Women",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
