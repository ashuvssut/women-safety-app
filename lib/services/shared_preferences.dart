import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class SharedPreferenceHelper {
  //define keys
  static String userLoggedInKey = 'ISLOGGEDIN';
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userUIDKey = "USERUIDKEY";
  static String userProfilePicKey = "USERPROFILEPICKEY";

  static String sosDelayTime = 'SOSDELAYTIME';
  static String sosRepeatInterval = 'SOSREPEATINTERVAL';
  static String messageHead = "MESSAGEHEAD";

  //save data
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(userLoggedInKey, isUserLoggedIn);
  }

  //fetch data
  static Future<bool> getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userLoggedInKey) ?? false;
  }

  static Future<bool> saveUserNameKey(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userNameKey, userName);
  }

  static Future<String> getUserNameKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(userNameKey);
    if (value == null) throw Exception('UserName is null');
    return value;
  }

  static Future<bool> saveUserEmailKey(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userEmailKey, userEmail);
  }

  static Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey)!;
  }

  static Future<bool> saveUserUIDKey(String userUID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userUIDKey, userUID);
  }

  static Future<String> getUserUIDKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(userUIDKey);
    if (value == null) throw Exception('UserUID is null');
    return value;
  }

  static Future<bool> saveUserProfilePicKey(String profileURL) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userProfilePicKey, profileURL);
  }

  static Future<String> getUserProfilePicKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(userProfilePicKey);
    if (value == null) throw Exception('UserProfilePic is null');
    return value;
  }

  static Future<bool> saveSOSdelayTime(int newSOSdelayTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setInt(sosDelayTime, newSOSdelayTime);
    log(await getSOSdelayTime().then((value) => value.toString()));
    return result;
  }

  static Future<int> getSOSdelayTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(sosDelayTime);
    if (value == null) throw Exception('SOSdelayTime is null');
    return value;
  }

  static Future<bool> saveSOSrepeatInterval(int newSOSrepeatInterval) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setInt(sosRepeatInterval, newSOSrepeatInterval);
    log(await getSOSrepeatInterval().then((value) => value.toString()));
    return result;
  }

  static Future<int> getSOSrepeatInterval() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(sosRepeatInterval);
    if (value == null) throw Exception('SOSrepeatInterval is null');
    return value;
  }

  static Future<bool> saveMessageHead(String newMessageHead) async {
    // print(await getMessageHead());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setString(messageHead, newMessageHead);
    log(await getMessageHead().then((value) => value.toString()));
    return result;
  }

  static Future<String> getMessageHead() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(messageHead);
    if (value == null) throw Exception('MessageHead is null');
    return value;
  }

  //clear
  static clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
