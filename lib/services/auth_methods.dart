import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:women_safety_app/services/shared_preferences.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get current user
  Future<User?> getCurrentUser() async => _auth.currentUser;

  // sign in with google
  Future<User?> signInWithGoogle(BuildContext context) async {
    log("Trying to Login with Google");

    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) throw Exception("Sign in process was aborted.");

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential result = await _auth.signInWithCredential(credential);

      User? userDetails = result.user;

      if (userDetails == null) {
        log("No user found");
      } else {
        //save user info and then navigate to Home screen
        final email = userDetails.email,
            name = userDetails.displayName,
            photoURL = userDetails.photoURL;
        SharedPreferenceHelper.saveUserLoggedInStatus(true);
        SharedPreferenceHelper.saveUserUIDKey(userDetails.uid);
        if (email != null) SharedPreferenceHelper.saveUserEmailKey(email);
        if (name != null) SharedPreferenceHelper.saveUserNameKey(name);
        if (photoURL != null) SharedPreferenceHelper.saveUserProfilePicKey(photoURL);
      }

      return userDetails;
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(msg: "Network Error! Can't Sign you in.");
      return null;
    }
  }

  Future signOut() async {
    try {
      // remove shared Prefs
      SharedPreferenceHelper.clearData();
      return await _auth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }
}
