import 'package:women_safety_app/services/shared_preferences.dart';

class SmsMethods {
  static const String messageHead = "I'm in trouble, plz help me. Reach this location:";
  static const int sosDelayTime = 10;
  static const int sosRepeatInterval = 10;

  // initializeAll method
  static Future<void> initializeAllSmsPrefs() async {
    await initializeMessageHead();
    await initializeSOSdelayTime();
    await initializeSOSrepeatInterval();
  }

  static Future<String> initializeMessageHead() async {
    return SharedPreferenceHelper.getMessageHead().then((value) async {
      String msg = value ?? messageHead;
      SharedPreferenceHelper.saveMessageHead(msg);
      return msg;
    });
  }

  static Future<int> initializeSOSdelayTime() async {
    return SharedPreferenceHelper.getSOSdelayTime().then((value) async {
      int delayTime = value ?? sosDelayTime;
      SharedPreferenceHelper.saveSOSdelayTime(delayTime);
      return delayTime;
    });
  }

  static Future<int> initializeSOSrepeatInterval() async {
    return SharedPreferenceHelper.getSOSrepeatInterval().then((value) async {
      int interval = value ?? sosRepeatInterval;
      SharedPreferenceHelper.saveSOSrepeatInterval(interval);
      return interval;
    });
  }
}
