import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';

class SOSMethods {
  static sendSOS() {
    log('SOS Triggered');

    Fluttertoast.showToast(msg: 'SOS Sent!');
  }
}
