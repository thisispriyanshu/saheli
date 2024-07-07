import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../db/databases.dart';
import '../../model/PhoneContact.dart';
import '../../common/utils/constants.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  DatabaseHelper _databaseHelper = DatabaseHelper();

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    askPermissions();
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  filterContact() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((element) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlattren = flattenPhoneNumber(searchTerm);
        String contactName = element.displayName ?? 'Untitled'.toLowerCase();
        bool nameMatch = contactName.contains(searchTerm);
        if (nameMatch == true) {
          return true;
        }
        if (searchTermFlattren.isEmpty) {
          return false;
        }
        var phone = element.phones!.firstWhere((p) {
          String phnFLattered = flattenPhoneNumber(p.value!);
          return phnFLattered.contains(searchTermFlattren);
        });
        return phone.value != null;
      });
    }
    setState(() {
      contactsFiltered = _contacts;
    });
  }

  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await getContactsPermissions();
    if (permissionStatus == PermissionStatus.granted) {
      getAllContacts();
      searchController.addListener(() {
        filterContact();
      });
    } else {
      handInvaliedPermissions(permissionStatus);
    }
  }

  handInvaliedPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      dialogueBox(context, "Access to the contacts denied by the user");
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      dialogueBox(context, "May contact does exist in this device");
    }
  }

  Future<PermissionStatus> getContactsPermissions() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  getAllContacts() async {
    List<Contact> _contacts =
        await ContactsService.getContacts(withThumbnails: false);
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearchIng = searchController.text.isNotEmpty;
    bool listItemExit = (contactsFiltered.isNotEmpty || contacts.isNotEmpty);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          "Add Emergency Contacts",
          style: GoogleFonts.outfit(fontWeight: FontWeight.w400, fontSize: 20),
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        automaticallyImplyLeading: false,
      ),
      body: contacts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary),
                      autofocus: true,
                      controller: searchController,
                      decoration: const InputDecoration(
                          hintText: "Search contact",
                          prefixIcon: Icon(Icons.search)),
                    ),
                  ),
                  listItemExit == true
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: isSearchIng == true
                                ? contactsFiltered.length
                                : contacts.length,
                            itemBuilder: (BuildContext context, int index) {
                              Contact contact = isSearchIng == true
                                  ? contactsFiltered[index]
                                  : contacts[index];
                              return ListTile(
                                title: Text(
                                  contact.displayName ?? 'Untitled',
                                  style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w500),
                                ),
                                leading: contact.avatar != null &&
                                        contact.avatar!.isNotEmpty
                                    ? CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        backgroundImage:
                                            MemoryImage(contact.avatar!),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        child: Text(
                                          contact.initials(),
                                          style: GoogleFonts.outfit(
                                              color: Colors.black87),
                                        ),
                                      ),
                                onTap: () {
                                  if (contact.phones!.isNotEmpty) {
                                    final String phoneNum =
                                        contact.phones!.elementAt(0).value!;
                                    final String name = contact.displayName!;
                                    _addContact(TContact(phoneNum, name));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Oops! phone number of this contact does exist");
                                  }
                                },
                              );
                            },
                          ),
                        )
                      : const Text("searching"),
                ],
              ),
            ),
    );
  }

  void _addContact(TContact newContact) async {
    int result = await _databaseHelper.insertContact(newContact);
    if (result != 0) {
      Fluttertoast.showToast(msg: "contact added successfully");
    } else {
      Fluttertoast.showToast(msg: "Failed to add contacts");
    }
    final data = {
      'name': newContact.name,
      'phone_number': newContact.number,
    };
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    User user = _auth.currentUser!;
    final userDoc = _firestore.collection('users').doc(user.uid);
    await userDoc.update({
      'emergency_contacts': FieldValue.arrayUnion([data])
    });
    Navigator.of(context).pop(true);
  }
}
