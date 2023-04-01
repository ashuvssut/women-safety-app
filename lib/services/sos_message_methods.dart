import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:telephony/telephony.dart';
import 'package:women_safety_app/components/permission_manager/permissions.dart';
import 'package:women_safety_app/services/database_methods.dart';
import 'package:women_safety_app/services/contacts.dart';
import 'package:women_safety_app/services/shared_preferences.dart';

class SosMethods {
  static const String messageHead = "I'm in trouble, plz help me. Reach this location:";
  static const int sosDelayTime = 10;
  static const int sosRepeatInterval = 10;

  // initializeAll method
  static Future<void> initializeAllSosPrefs() async {
    await initializeMessageHead();
    await initializeSosDelayTime();
    await initializeSosRepeatInterval();
  }

  static Future<String> initializeMessageHead() async {
    return SharedPreferenceHelper.getMessageHead().then((value) async {
      String msg = value ?? messageHead;
      SharedPreferenceHelper.saveMessageHead(msg);
      return msg;
    });
  }

  static Future<int> initializeSosDelayTime() async {
    return SharedPreferenceHelper.getSosDelayTime().then((value) async {
      int delayTime = value ?? sosDelayTime;
      SharedPreferenceHelper.saveSosDelayTime(delayTime);
      return delayTime;
    });
  }

  static Future<int> initializeSosRepeatInterval() async {
    return SharedPreferenceHelper.getSosRepeatInterval().then((value) async {
      int interval = value ?? sosRepeatInterval;
      SharedPreferenceHelper.saveSosRepeatInterval(interval);
      return interval;
    });
  }

  static sendSos() async {
    log('Sos Triggered');

    PositionDetails? positionDetials = await _determinePosition();

    if (positionDetials != null) {
      final latitude = positionDetials.getPosition.latitude;
      final longitude = positionDetials.getPosition.longitude;
      String address = positionDetials.getAddress;

      String messageBody =
          "https://www.google.com/maps/search/?api=1&query=$latitude%2C$longitude. $address";

      final message = messageHead + messageBody;

      bool result = await _initiateSendSos(message);
      if (result) {
        Fluttertoast.showToast(msg: 'SOS Sent!');
      } else {
        Fluttertoast.showToast(msg: 'Some Error Occured. Sending SOS SMS Failed!');
      }
    }
  }

  static Future<bool> checkLocationPermission() async {
    LocationPermission permission;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return false;
    } else {
      return true;
    }
  }

  static Future<PositionDetails?> _determinePosition() async {
    // check if location service is enabled using getLocationPermission()
    await PermissionMethods.initiatePermissionManger();
    bool locationPermission = await checkLocationPermission();
    if (!locationPermission) {
      Fluttertoast.showToast(msg: 'No Location data. SOS Failed.');
      return null;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      Position currentPosition = position;
      String currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";

      PositionDetails positionDetails = PositionDetails(currentPosition, currentAddress);
      return positionDetails;
    } catch (e) {
      log(e.toString());

      Fluttertoast.showToast(msg: 'Oops! Apps could not fetch Address.');

      PositionDetails positionDetails = PositionDetails(position, "");
      return positionDetails;
    }
  }

  static Future<bool> _initiateSendSos(String message) async {
    DatabaseMethods databaseMethods = DatabaseMethods();
    List<TContact> contactList = await databaseMethods.getContactList();
    String recipients = "";
    int i = 1;
    for (TContact contact in contactList) {
      recipients += contact.getNumber;
      if (i != contactList.length) {
        recipients += ";";
        i++;
      }
    }

    bool result = await sendSMS2Recipients(recipients, message);

    return result;
  }

  static Future<bool> sendSMS2Recipients(String recipients, String message) async {
    final Telephony telephony = Telephony.instance;

    bool serviceEnabled = await SMSPerms.check().isGranted;

    if (!serviceEnabled) {
      // TODO: graciously handle this
      Fluttertoast.showToast(msg: SMSPerms.permanentDeniedFeedback);
      return false;
    } else {
      // bool canSendSms = await telephony.isSmsCapable;
      // print(canSendSms);
      // SimState simState = await telephony.simState;
      // print(simState);

      listener(SendStatus status) {
        if (status == SendStatus.SENT || status == SendStatus.DELIVERED) {
          log(status.toString());
          log('SmsSendStatusListener report: SMS was sent!');
          Fluttertoast.showToast(msg: 'SOS Sent!');
        } else {
          log(status.toString());
          log('SmsSendStatusListener report: SMS was not sent!');
          Fluttertoast.showToast(msg: 'Sending SOS SMS Failed!');
        }
      }

      List<String> recipientList = recipients.split(';');

      for (String recipient in recipientList) {
        // This one supports all android devices..
        await telephony.sendSms(
          to: recipient,
          message: message,
          isMultipart: true,
          statusListener: listener,
        );
      }

      // log('$recipients : $message');
      // telephony.sendSms( // may not support in some devices..
      //   to: recipients,
      //   message: message,
      //   isMultipart: true,
      //   statusListener: listener,
      // );

      return true;
    }
  }
}

class PositionDetails {
  Position _position;
  String _address;

  PositionDetails(this._position, this._address);

  //getters
  Position get getPosition => _position;
  String get getAddress => _address;

  @override
  String toString() {
    return 'PositionDetails: {position: $_position, address: $_address}';
  }

  //setters
  set positon(Position newPosition) => _position = newPosition;
  set address(String newAddress) => _address = newAddress;
}
