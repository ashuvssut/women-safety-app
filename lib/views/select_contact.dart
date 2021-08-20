import 'dart:developer';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:women_safety_app/helper_functions/database_helper.dart';
import 'package:women_safety_app/services/contacts.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key key}) : super(key: key);

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  Map<String, Color> contactsColorMap = new Map();
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getPermissions();
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
      searchController.addListener(() {
        filterContacts();
      });
    }
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  getAllContacts() async {
    List colors = [
      Colors.green,
      Colors.indigo,
      Colors.yellow,
      Colors.orange
    ];
    int colorIndex = 0;
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();
    _contacts.forEach((contact) {
      Color baseColor = colors[colorIndex];
      contactsColorMap[contact.displayName] = baseColor;
      colorIndex++;
      if (colorIndex == colors.length) {
        colorIndex = 0;
      }
    });
    if (!mounted) {
      return;
    } else {
      setState(() {
        contacts = _contacts;
      });
    }
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }

        var phone = contact.phones.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn.value);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () => null);

        return phone != null;
      });
    }
    setState(() {
      contactsFiltered = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    bool listItemsExist = (contactsFiltered.length > 0 || contacts.length > 0);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Select a Contact",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                autofocus: true,
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: new OutlineInputBorder(borderSide: new BorderSide(color: Theme.of(context).primaryColor)),
                  prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            listItemsExist == true
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: isSearching == true ? contactsFiltered.length : contacts.length,
                      itemBuilder: (context, index) {
                        Contact contact = isSearching == true ? contactsFiltered[index] : contacts[index];

                        var baseColor = contactsColorMap[contact.displayName] as dynamic;

                        Color color1 = baseColor[800];
                        Color color2 = baseColor[400];
                        return ListTile(
                          title: Text(contact.displayName),
                          subtitle: Text(contact.phones.length > 0 ? contact.phones.elementAt(0).value : ''),
                          leading: (contact.avatar != null && contact.avatar.length > 0)
                              ? CircleAvatar(backgroundImage: MemoryImage(contact.avatar))
                              : Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        color1,
                                        color2,
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    child: Text(
                                      contact.initials(),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                          onTap: () {
                            if (contact.phones.length > 0) {
                              final String phoneNum = contact.phones.elementAt(0).value;
                              final String name = contact.displayName;
                              _addContact(TContact(phoneNum, name));
                            } else {
                              Fluttertoast.showToast(msg: "Oops! Phone number of this contact does not exist!");
                            }
                          },
                        );
                      },
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      isSearching ? 'No search results to show' : 'No contacts found yet',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  )
          ],
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _addContact(TContact newContact) async {
    int result = await databaseHelper.insertContact(newContact);
    if (result != 0) {
      log('Contact added Successfully');
    } else {
      log('add Contact Failed');
      Fluttertoast.showToast(msg: "Failed to Add Contact");
    }
    moveToLastScreen();
  }
}
