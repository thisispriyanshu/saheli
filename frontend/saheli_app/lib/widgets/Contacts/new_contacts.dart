import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:saheli_app/widgets/Live_location/main.dart';
import 'package:share/share.dart';
import 'package:sqflite/sqflite.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      appBar: AppBar(
        title: const Text("Contacts", style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "btn1",
      onPressed: ( ) {
        openSharePanel();
    },
        label: Text('Send location to group'),
        icon: FaIcon(FontAwesomeIcons.whatsapp),
        backgroundColor: Color.fromARGB(255, 37,211,102),
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

  void openSharePanel() {
    DateTime now = DateTime.now();
    String formattedTime = '${now.hour}:${now.minute}:${now.second}';

    String message = "Hi! I am going out at $formattedTime, here's my current location, https://www.google.com/maps/search/?api=1&query=28.59351217640707,77.24437040849519 \n-Sent from Saheli app";

    Share.share(message
    );
  }
  // Future<void> shareCurrentLocation() async {
  //
  //
  //     LocationData currentLocation = await location.getLocation();
  //     DateTime now = DateTime.now();
  //     String formattedTime = '${now.hour}:${now.minute}:${now.second}';
  //
  //     String message = "Hi! I am going out at $formattedTime, here's my current location, https://www.google.com/maps/search/?api=1&query=${currentLocation.latitude},${currentLocation.longitude}";
  //
  //      Share.share(message
  //     );
    // } catch (e) {
      // Handle location access or sharing errors
      // print("Error: $e");
    // }
  // }
}
