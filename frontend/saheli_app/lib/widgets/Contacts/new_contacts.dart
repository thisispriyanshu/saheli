import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saheli_app/widgets/Live_location/main.dart';
import 'package:sqflite/sqflite.dart';

import '../../db/databases.dart';
import '../../model/PhoneContact.dart';
import '../SafeRoutes/SafeHome.dart';
import 'contacts.dart';

class AddContactsPage extends StatefulWidget {
  const AddContactsPage({super.key});

  @override
  State<AddContactsPage> createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  DatabaseHelper databasehelper = DatabaseHelper();
  List<TContact>? contactList;
  int count = 0;

  void showList() {
    Future<Database> dbFuture = databasehelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<TContact>> contactListFuture =
      databasehelper.getContactList();
      contactListFuture.then((value) {
        setState(() {
          this.contactList = value;
          this.count = value.length;
        });
      });
    });
  }

  void deleteContact(TContact contact) async {
    int result = await databasehelper.deleteContact(contact.id);
    if (result != 0) {
      Fluttertoast.showToast(msg: "Emergency Contact Removed");
      showList();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (contactList == null) {
      contactList = [];
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContactsPage(),
            ),
          );
        },
        label: Text('Share Live Location'),
        icon: Icon(Icons.location_on),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Color.fromARGB(255, 255, 236, 208),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                PrimaryButton(
                    title: "Add Trusted Contacts",
                    onPressed: () async {
                      bool result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactsPage(),
                          ));
                      if (result == true) {
                        showList();
                      }
                    }),
                Expanded(
                  child: ListView.builder(
                    // shrinkWrap: true,
                    itemCount: count,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                          child: ListTile(
                            title: Text(contactList![index].name),
                            trailing: Container(
                              width: 100,

                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        await FlutterPhoneDirectCaller.callNumber(
                                            contactList![index].number);
                                      },

                                      icon: Icon(
                                        Icons.call,
                                        color: Colors.pinkAccent,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        deleteContact(contactList![index]);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.pinkAccent,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
