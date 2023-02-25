// consent popup
import 'package:flutter/material.dart';

class ConsentPopup extends StatelessWidget {
  const ConsentPopup({super.key});

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
            // tiles for location, sms, contacts permissions with icon and description on why we need it for the app
            ListTile(
              leading: Icon(Icons.message),
              title: Text('SMS'),
              subtitle: Text('To send your SOS SMS messages.'),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Location'),
              subtitle: Text('To add your current location information in your SOS.'),
            ),

            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Contacts'),
              subtitle: Text('To create your list of trusted contacts.'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Give Access'),
          onPressed: () {
            Navigator.of(context).pop();
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
