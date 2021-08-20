import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:women_safety_app/helper_functions/database_helper.dart';
import 'package:women_safety_app/services/contacts.dart';

class SOSMethods {
  static String messageHead = '''This is an automated Distress Call. The Sender is in a trouble.
  I am in trouble, please help meby reaching the below location.
  ''';
  static String messageBody = '';

  static sendSOS() async {
    log('SOS Triggered');

    PositionDetails positionDetials = await _determinePosition();

    if (positionDetials != null) {
      final latitude = positionDetials.position.latitude;
      final longitude = positionDetials.position.longitude;
      String address = positionDetials.address;
      messageBody = '''https://www.google.com/maps/search/?api=1&query=$latitude%2C$longitude
      
      Address: $address
      
      - Location and address will be updated again after 5 minutes.''';

      final message = messageHead + messageBody;
      bool result = await _initiateSendSMS(message);
      if (result) {
        Fluttertoast.showToast(msg: 'SOS Sent!');
      } else {
        Fluttertoast.showToast(msg: 'Sending SOS SMS Failed!');
      }
    }
  }

  static Future<PositionDetails> _determinePosition() async {
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

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      Position currentPosition = position;
      String currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";

      Object positionDetails = PositionDetails(currentPosition, currentAddress);
      return positionDetails;
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: 'Error occured while fetching location!');
      return null;
    }
  }

  static _initiateSendSMS(String message) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    List<TContact> contactList = await databaseHelper.getContactList();
    List<String> recipients = [];
    for (TContact contact in contactList) {
      recipients.add(contact.number);
    }

    return true;
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
