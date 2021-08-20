import 'package:shared_preferences/shared_preferences.dart';

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
    return prefs.getBool(userLoggedInKey);
  }

  static Future<bool> saveUserNameKey(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userNameKey, userName);
  }

  static Future<String> getUserNameKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  static Future<bool> saveUserEmailKey(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userEmailKey, userEmail);
  }

  static Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  static Future<bool> saveUserUIDKey(String userUID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userUIDKey, userUID);
  }

  static Future<String> getUserUIDKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userUIDKey);
  }

  static Future<bool> saveUserProfilePicKey(String profileURL) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userProfilePicKey, profileURL);
  }

  static Future<String> getUserProfilePicKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfilePicKey);
  }

  static Future<bool> saveSOSdelayTime(int newSOSdelayTime) async {
    // print(await getSOSdelayTime());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setInt(sosDelayTime, newSOSdelayTime);
    print(await getSOSdelayTime());
    return result;
  }

  static Future<int> getSOSdelayTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(sosDelayTime);
  }

  static Future<bool> saveSOSrepeatInterval(int newSOSrepeatInterval) async {
    // print(await getSOSrepeatInterval());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setInt(sosRepeatInterval, newSOSrepeatInterval);
    print(await getSOSrepeatInterval());
    return result;
  }

  static Future<int> getSOSrepeatInterval() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(sosRepeatInterval);
  }

  static Future<bool> saveMessageHead(String newMessageHead) async {
    // print(await getMessageHead());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setString(messageHead, newMessageHead);
    print(await getMessageHead());
    return result;
  }

  static Future<String> getMessageHead() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(messageHead);
  }

  //clear
  static clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
