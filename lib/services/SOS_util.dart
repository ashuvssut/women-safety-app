import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:telephony/telephony.dart';
import 'package:women_safety_app/helper_functions/database_helper.dart';
import 'package:women_safety_app/helper_functions/shared_preference.dart';
import 'package:women_safety_app/services/contacts.dart';

class SOSMethods {
  static sendSOS() async {
    log('SOS Triggered');

    PositionDetails positionDetials = await _determinePosition();

    if (positionDetials != null) {
      final latitude = positionDetials.position.latitude;
      final longitude = positionDetials.position.longitude;
      String address = positionDetials.address;

      String messageHead = await SharedPreferenceHelper.getMessageHead();
      String messageBody = "https://www.google.com/maps/search/?api=1&query=$latitude%2C$longitude. $address";

      final message = messageHead + messageBody;
      await _initiateSendSMS(message);

      // bool result = await _initiateSendSMS(message);
      // if (result) {
      //   Fluttertoast.showToast(msg: 'SOS Sent!');
      // } else {
      //   Fluttertoast.showToast(msg: 'Sending SOS SMS Failed!');
      // }
    }
  }

  static Future<bool> getSMSPermission() async {
    final Telephony telephony = Telephony.instance;

    bool serviceEnabled;

    serviceEnabled = await telephony.requestSmsPermissions;
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please allow SMS Permission');
      serviceEnabled = await telephony.requestSmsPermissions;
    }

    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'SMS Permission is not being granted. App will be unable to send SOS SMS to your added trusted contacts');
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> getLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Location permissions are permanently denied, App cannot request permissions.');
    }

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return false;
    } else {
      return true;
    }
  }

  static Future<PositionDetails> _determinePosition() async {
    // check if location service is enabled using getLocationPermission()
    bool locationPermission = await getLocationPermission();
    if (!locationPermission) {
      Fluttertoast.showToast(msg: 'Location Service is not enabled. SOS Failed. Please enable Location Service in your phone settings.');
      return null;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      Position currentPosition = position;
      String currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";

      PositionDetails positionDetails = PositionDetails(currentPosition, currentAddress);
      return positionDetails;
    } catch (e) {
      print(e);

      if (position.latitude != null) {
        // if only geocoding has failed
        Fluttertoast.showToast(msg: 'Oops! Apps could not fetch Address.');

        PositionDetails positionDetails = PositionDetails(position, "");
        return positionDetails;
      } else {
        Fluttertoast.showToast(msg: 'Sorry! Geolocation could not be fetched. SOS Failed.');
        //if both geolocator and geocoding failed
        return null;
      }
    }
  }

  static Future<bool> _initiateSendSMS(String message) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    List<TContact> contactList = await databaseHelper.getContactList();
    String recipients = "";
    int i = 1;
    for (TContact contact in contactList) {
      recipients += contact.number;
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

    bool serviceEnabled;

    serviceEnabled = await telephony.requestSmsPermissions;
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please allow SMS Permission');
      serviceEnabled = await telephony.requestSmsPermissions;
    }

    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'SMS Permission is not being granted. App will be unable to send SOS SMS to your added trusted contacts');
      return false;
    } else {
      // bool canSendSms = await telephony.isSmsCapable;
      // print(canSendSms);
      // SimState simState = await telephony.simState;
      // print(simState);

      final SmsSendStatusListener listener = (SendStatus status) {
        if (status == SendStatus.SENT || status == SendStatus.DELIVERED) {
          print(status);
          log('SmsSendStatusListener report: SMS was sent!');
          Fluttertoast.showToast(msg: 'SOS Sent!');
        } else {
          print(status);
          log('SmsSendStatusListener report: SMS was not sent!');
          Fluttertoast.showToast(msg: 'Sending SOS SMS Failed!');
        }
      };
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
  Position get position => _position;
  String get address => _address;

  @override
  String toString() {
    return 'PositionDetails: {position: $_position, address: $_address}';
  }

  //setters
  set positon(Position newPosition) => this._position = newPosition;
  set address(String newAddress) => this._address = newAddress;
}
