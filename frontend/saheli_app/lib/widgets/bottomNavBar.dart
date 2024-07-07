import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:Saheli/views/home_screen.dart';

import '../AudioRecorder/screens/home_screen/audioplayer.dart';
import '../AudioRecorder/screens/home_screen/home_screen.dart';
import '../api/safeways.dart';
import 'Chatbot/chatbot.dart';
import 'Contacts/new_contacts.dart';
import '../views/Profile.dart';
import 'SafeRoutes/BrakeDetection.dart';
import 'SafeRoutes/SafeRoutes.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  int _countdown = 60;
  Timer? _timer;
  bool _isBottomSheetVisible = false;
  late Function(Function()) sheetSetState;
  final List<Widget> navBarList = [
    HomePage(),
    const AddContactsPage(),
    const ChatScreen(),
    const SafeRoutes(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {

    // height
    double height = MediaQuery.of(context).size.height;
    // width
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: _selectedIndex != 2
          ? FloatingActionButton(
          heroTag: "btn2",
              backgroundColor: Colors.red,

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AudioPlayer(),
                  ),
                );
              },
              child: const Text('SOS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),

            )
          : null, // Render FAB only for the Search tab (index 1)
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Theme.of(context).bottomAppBarTheme.color,
      key: _scaffoldKey,
      // body: _pages[_selectedIndex],
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: navBarList),
      ),
      bottomNavigationBar: Material(
        elevation: 15,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.01),
          decoration: const BoxDecoration(
            // color: Theme.of(context).cardColor.withOpacity(0.5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: GNav(
                curve: Curves.easeOutExpo,
                haptic: true,
                tabBorderRadius: 20,
                //gap: 2,
                activeColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Theme.of(context).colorScheme.primary,
                // textStyle: Colors.white,
                tabs: [
                  GButton(
                    iconSize: 25,
                    icon: _selectedIndex == 0
                        ? Icons.home_filled
                        : LineAwesomeIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    iconSize: 25,
                    icon: _selectedIndex == 1 ?  Icons.contacts
                    : Icons.contacts_outlined,
                    text: 'Contacts',
                  ),
                  GButton(
                    iconSize: 25,
                    icon: _selectedIndex == 2
                        ? Icons.auto_awesome
                        : Icons.auto_awesome_outlined,
                    text: 'Sakha',
                  ),
                  GButton(
                    iconSize: 25,
                    icon: _selectedIndex == 3 ? Icons.map : Icons.map_outlined,
                    text: 'Route',
                  ),
                  GButton(
                    iconSize: 25,
                    icon: _selectedIndex == 4
                        ? CupertinoIcons.person_solid
                        : CupertinoIcons.person,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  alertTimer(){
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _countdown--);
      sheetSetState(() {
        final seconds = const Duration().inSeconds + _countdown;
        Duration() = Duration(seconds: seconds);
      });
      if(_countdown == 0){
        _timer!.cancel();
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AudioPlayer()),
        );
      }
      // if (_isBottomSheetVisible) {
      //   Navigator.of(context).pop();
      //   _isBottomSheetVisible = false;
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => AudioPlayer()),
      //   );
      // }
    });
  }

  void showBottomSheet() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            sheetSetState = setState;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Harsh Braking Activated!!!",
                      style: GoogleFonts.outfit(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      "Are you safe?",
                      style: GoogleFonts.outfit(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.tertiary,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            value: _countdown / 60),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _countdown.toString(),
                            style: GoogleFonts.outfit(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          backgroundColor:
                          Theme.of(context).colorScheme.tertiary),
                      onPressed: () {
                        _timer!.cancel();
                        Navigator.pop(context);
                        //_isBottomSheetVisible = false;
                      },
                      child: Text(
                        'Yes',
                        style: GoogleFonts.outfit(
                            color: Colors.black54, fontSize: 18),
                      )),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AudioPlayer()));
                      },
                      child: Text(
                        'No',
                        style: GoogleFonts.outfit(
                            color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            );
          });
        },
      );
    });
    // _isBottomSheetVisible = true;
  }

  @override
  void initState() {
    super.initState();
    showBottomSheet();
    sheetSetState = (fn) {
      setState(fn);
    };
    alertTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
