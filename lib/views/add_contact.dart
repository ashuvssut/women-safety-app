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

  @override
  void initState() {
    super.initState();
  }

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
                  log('Insert Clicked.');
                  setState(() {
                    contactList.add(new Contacts('+918114727882', "ashuvssut"));
                  });
                },
                elevation: 10,
                highlightElevation: 15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
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
                color: Colors.green,
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                children: _getContactsListing(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getContactsListing() {
    List listings = new List<Widget>();
    for (int i = 0; i < contactList.length; i++) {
      listings.add(new ListTile(
        key:Key(contactList[i].id.toString()),
        title: new Text(contactList[i].name),
        subtitle: new Text(contactList[i].number),
        onTap: () {},
        trailing: IconButton(
          icon: Icon(Icons.delete_outline),
          color: Colors.red,
          tooltip: 'Delete Contact',
          onPressed: () {
            setState(() {
                databaseHelper.deleteContact(contactList[i].id);
                log(contactList[i].id.toString());
              }
            );
          },
        ),
        ),
      );
    }
    return listings;
  }
}
