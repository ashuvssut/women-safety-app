import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';

sendSOS(){
  log('SOS Triggered');

  Fluttertoast.showToast(msg: 'SOS Sent!');
}