import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:saheli_app/widgets/Contacts/new_contacts.dart';

import '../views/article_screen.dart';
import '../views/home_screen.dart';
import 'Profile.dart';
import 'SafeRoutes/SafeRoutes.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          // if (isLogin) HomePage() else LoginPage(),
          HomePage(),
          AddContactsPage(),
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
              label: 'Home', activeColor: Colors.redAccent),
          RollingBottomBarItem(Icons.grid_view_rounded,
              label: 'article', activeColor: Colors.amberAccent),
          RollingBottomBarItem(Icons.map,
              label: 'SafeRoute', activeColor: Colors.blueAccent),
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
        },
      ),
    );
  }
}
