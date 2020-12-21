import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:women_safety_app/helper_functions/database_helper.dart';
import 'package:women_safety_app/services/contacts.dart';

class AddContacts extends StatefulWidget {
  @override
  _AddContactsState createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Contacts> contactList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (contactList == null) {
      contactList = List<Contacts>();
    }
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Trusted Contacts",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12, width: 0.5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonTheme(
              height: 70,
              minWidth: double.infinity,
              child: RaisedButton.icon(
                onPressed: () {
                  log('Button Clicked.');
                },
                elevation: 10,
                highlightElevation: 15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                label: Text(
                  'Add a Trusted Contact',
                  style: TextStyle(fontSize: 25),
                ),
                icon: Icon(
                  Icons.contacts,
                  color: Colors.white,
                  size: 35,
                ),
                textColor: Colors.white,
                splashColor: Colors.red,
                color: Colors.green,
              ),
            ),
            Expanded(
              child: ListView(
                // scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                // children: _getContactsListing(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
