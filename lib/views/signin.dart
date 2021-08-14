import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:women_safety_app/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text("Sign in"),
          ],
        ),
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: SvgPicture.asset(
                "assets/icons/happy.svg",
                height: size.height * 0.35,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50.0),
              width: 300,
              child: ButtonTheme(
                buttonColor: Colors.white60,
                child: RaisedButton(
                  onPressed: () {
                    AuthMethods().signInWithGoogle(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(38.0),
                  ),
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(top:7, right:17,bottom:7,left:7),
                      child: SvgPicture.asset(
                        "assets/icons/google.svg",
                        height: size.height * 0.05,
                      ),
                    ),
                    Text(
                      "Sign In with Google",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 21,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
