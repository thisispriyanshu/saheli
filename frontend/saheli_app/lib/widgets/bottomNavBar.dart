import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:saheli_app/AudioRecorder/screens/home_screen/audioplayer.dart';
import 'package:saheli_app/widgets/Contacts/new_contacts.dart';
import '../AudioRecorder/screens/home_screen/home_screen.dart';
import '../FakeCaller/utilities/icon_content.dart';
import '../views/article_screen.dart';
import '../views/home_screen.dart';
import 'Chatbot/chatbot.dart';
import 'Profile.dart';
import 'SafeRoutes/SafeRoutes.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final List<Widget> navBarList = [
    HomePage(),
    AddContactsPage(),
    ChatScreen(),
    SafeRoutes(),
    Profile(),
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
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AudioPlayer(),
                  ),
                );
              },
              child: Icon(Icons.crisis_alert_outlined),
            )
          : Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GeminiBot()),

            );
          },

          child:Icon( Icons.star),
          backgroundColor: Colors.pinkAccent,
        ),
      ), // Render FAB only for the Search tab (index 1)
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
                // rippleColor: Colors.grey[300],
                // hoverColor: Colors.grey[100],
                haptic: true,
                tabBorderRadius: 20,
                //gap: 2,
                activeColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Theme.of(context).colorScheme.tertiary,
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
                        ? Icons.chat
                        : Icons.chat_bubble_outline,
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
}
