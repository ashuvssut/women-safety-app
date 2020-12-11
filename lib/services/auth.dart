// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthMethods{
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // get current user
//   Future<User> getCurrentUser() async {
//     return _auth.currentUser;
//   }

//   // sign in with google
//   Future<User> signInWithGoogle(BuildContext context) async{
//     print("Trying to Login with Google");

//     final GoogleSignIn _googleSignIn = new GoogleSignIn();

//     try{
//       final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

//       final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         idToken: googleSignInAuthentication.idToken,
//         accessToken: googleSignInAuthentication.accessToken
//       );

//       UserCredential result = await _auth.signInWithCredential(credential);

//       User userDetails = result.user;

//       if(result == null){
//         print("Error:no user found");
//       } else {

//       }

//       return userDetails;
//     }catch(e){

//     }
//   }

// }