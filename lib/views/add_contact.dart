import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:women_safety_app/helper_functions/database_helper.dart';
import 'package:women_safety_app/services/contacts.dart';
import 'package:women_safety_app/views/select_contact.dart';

class AddContacts extends StatefulWidget {
  @override
  _AddContactsState createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<TContact> contactList;
  int count = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //useEffect()
      updateListView();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (contactList == null) {
      contactList = [];
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
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButtonTheme(
              data: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                ),
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  navigateToSelectContact();
                },
                label: Text(
                  'Add a Trusted Contact',
                  style: TextStyle(fontSize: 25),
                ),
                icon: Icon(
                  Icons.contacts,
                  color: Colors.white,
                  size: 35,
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: getContactListView(),
              // padding: const EdgeInsets.all(20.0),
            ),
          ],
        ),
      ),
    );
  }

  ListView getContactListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.titleMedium;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(
              this.contactList[position].name,
              style: titleStyle,
            ),
            subtitle: Text(this.contactList[position].number),
            trailing: IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                tooltip: 'Delete Contact',
                onPressed: () {
                  _deleteContact(context, contactList[position]);
                }),
            onTap: () {
              // log("ListTile Tapped");
            },
          ),
        );
      },
    );
  }

  void navigateToSelectContact() async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SelectContact();
    }));

    if (result == true) {
      updateListView();
    }
  }

  void _deleteContact(BuildContext context, TContact contact) async {
    int result = await databaseHelper.deleteContact(contact.id);
    if (result != 0) {
      log('Contact Removed Successfully');
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<TContact>> contactListFuture = databaseHelper.getContactList();
      contactListFuture.then((contactList) {
        setState(() {
          this.contactList = contactList;
          this.count = contactList.length;
        });
      });
    });
  }
}
