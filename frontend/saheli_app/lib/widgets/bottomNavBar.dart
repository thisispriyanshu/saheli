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

  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _selectedIndex != 2
          ? FloatingActionButton(
        backgroundColor: Colors.red,
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
          : null, // Render FAB only for the Search tab (index 1)




      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          // if (isLogin) HomePage() else LoginPage(),
          HomePage(),
          AddContactsPage(),
          ChatScreen(),
          SafeRoutes(),
          Profile(),
        ],
      ) ,
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        color: const Color.fromARGB(226, 243, 243, 243),
        controller: _pageController,
        flat: true,
        useActiveColorByDefault: false,
        items: const [
          RollingBottomBarItem(Icons.home,
              label: 'Home', activeColor: Colors.orangeAccent),
          RollingBottomBarItem(Icons.contacts,
              label: 'Contacts', activeColor: Colors.deepOrange),
          RollingBottomBarItem(Icons.bubble_chart_outlined,
              label: 'Chat', activeColor: Colors.blueAccent),
          RollingBottomBarItem(Icons.map,
              label: 'Routes', activeColor: Colors.blueAccent),
          RollingBottomBarItem(Icons.person,
              label: 'Profile', activeColor: Colors.green),
        ],
        enableIconRotation: true,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,

          );
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
