import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class GeolocationPerms {
  static String permanentDeniedFeedback =
      'No location permission. Unable to add location info in your SOS message';

  static Future<PermissionStatus> check() async {
    return await Permission.location.status;
  }

  static Future<PermissionStatus> request() async {
    return await Permission.location.request();
  }

  static Future<void> handlePermanentlyDenied(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const GeoLocManualPermsGrantPopup();
      },
    );
  }

  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // You can can also directly ask the permission about its status.
  // if (await Permission.location.isRestricted) {
  // The OS restricts access, for example because of parental controls.
  // }
}

class GeoLocManualPermsGrantPopup extends StatelessWidget {
  const GeoLocManualPermsGrantPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Grant necessary permissions'),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      titlePadding: const EdgeInsets.all(30),
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Location'),
              subtitle: Text('To add your current location information in your SOS.'),
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Go to settings'),
          onPressed: () {
            Navigator.of(context).pop();
            openAppSettings();
          },
        ),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(40.0),
        ),
      ),
    );
  }
}
