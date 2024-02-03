import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:saheli_app/services/localDb/localDb.dart';
import 'package:saheli_app/views/article_screen.dart';
import 'package:saheli_app/views/home_screen.dart';
import 'package:saheli_app/views/login.dart';
import 'package:saheli_app/widgets/Chatbot/chatbot.dart';
import 'package:saheli_app/widgets/Contacts/contacts.dart';
import 'package:saheli_app/widgets/Contacts/new_contacts.dart';
import 'package:saheli_app/widgets/Profile.dart';
import 'package:saheli_app/widgets/SafeRoutes/SafeRoutes.dart';

import 'common/theme/theme.dart';
import 'firebase_options.dart';

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class _MyAppState extends State<MyApp> {
  final PageController _pageController = PageController(); // Moved it here

  bool isLogin = false;

  getLoggedinState() async {
    await LocalDb.getUserId().then((value) {
      print(value);
      setState(() {
        if (value.toString() != "null") {
          isLogin = true;
        }
      });
    });
  }

  @override
  void initState() {
    getLoggedinState();
    print(isLogin);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose of the controller here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Styles.themeData(context),
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            if (isLogin) HomePage() else LoginPage(),
            AddContactsPage(),
            HomeScreen(),
            Profile(),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: RollingBottomBar(

          color: const Color.fromARGB(226, 243, 243, 243),
          controller: _pageController,
          flat: true,
          useActiveColorByDefault: false,
          items: const [
            RollingBottomBarItem(Icons.home,
                label: 'Home', activeColor: Colors.redAccent),
            RollingBottomBarItem(Icons.contact_emergency,
                label: 'Contact', activeColor: Colors.green),
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
      ),
    );
  }
}
