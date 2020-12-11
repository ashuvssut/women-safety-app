import 'package:flutter/material.dart';
import 'package:women_safety_app/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("With You SignIn"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            AuthMethods().signInWithGoogle(context);
          }, 
          child: Text("Sign In with Google")),
      ),
    );
  }
}
