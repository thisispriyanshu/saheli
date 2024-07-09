import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:Saheli/widgets/Live_location/main.dart';
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
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        title: Text(
          "Contacts",
          style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 32),
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        child: FloatingActionButton.extended(
          heroTag: "btn1",
          onPressed: () {
            openSharePanel();
          },
          label: Text(
            'Send location to group',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w300,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          icon: const FaIcon(
            FontAwesomeIcons.whatsapp,
            color: Colors.green,
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'lib/assets/images/trustedContacts.jpg',
                          color: Colors.black.withOpacity(0.4),
                          colorBlendMode: BlendMode.multiply,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add Trusted Contacts',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Add only those contacts that you can trust and can help you in danger situation. Ex- Family members and close friends.',
                              style: GoogleFonts.outfit(
                                  fontSize: 16, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  bool result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ContactsPage(),
                                    ),
                                  );
                                  if (result == true) {
                                    showList();
                                  }
                                },
                                child: Text(
                                  'Add Contacts',
                                  style: GoogleFonts.outfit(
                                      fontSize: 16, color: Colors.white),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: contactList!.isEmpty
                      ? Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                            'Your added contacts will appear here...',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                      )
                      : ListView.builder(
                          // shrinkWrap: true,
                          itemCount: count,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              margin: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, top: 8.0, bottom: 8.0),
                                child: ListTile(
                                  title: Text(contactList![index].name),
                                  trailing: Container(
                                    width: 100,
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              await FlutterPhoneDirectCaller
                                                  .callNumber(
                                                      contactList![index]
                                                          .number);
                                            },
                                            icon: const Icon(
                                              Icons.call,
                                              color: Colors.pinkAccent,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              deleteContact(
                                                  contactList![index]);
                                            },
                                            icon: const Icon(
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

    String message =
        "Hi! I am going out at $formattedTime, here's my current location, https://www.google.com/maps/search/?api=1&query=28.59351217640707,77.24437040849519 \n-Sent from Saheli app";

    Share.share(message);
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
