import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{
  //define keys
  static String userLoggedInKey = 'ISLOGGEDIN';
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userUIDKey = "USERUIDKEY";
  static String userProfilePicKey = "USERPROFILEPICKEY";

  //save data
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(userLoggedInKey, isUserLoggedIn);
  }
  //fetch data
  static Future<bool> getUserLoggedIn() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userLoggedInKey);
  }

  static Future<bool> saveUserNameKey(String userName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userNameKey, userName);
  }
  static Future<String> getUserNameKey() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  static Future<bool> saveUserEmailKey(String userEmail) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userEmailKey, userEmail);
  }
  static Future<String> getUserEmail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  static Future<bool> saveUserUIDKey(String userUID) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userUIDKey, userUID);
  }
  static Future<String> getUserUIDKey() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userUIDKey);
  }

  static Future<bool> saveUserProfilePicKey(String profileURL) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userProfilePicKey, profileURL);
  }
  static Future<String> getUserProfilePicKey() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfilePicKey);
  }


  //clear
  static clearData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

}