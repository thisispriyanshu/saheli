import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saheli_app/services/localDb/localDb.dart';
import 'package:saheli_app/views/login.dart';
import 'package:saheli_app/widgets/bottomNavBar.dart';

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
    await LocalDb.getEmail().then((value) {
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
      home: isLogin ? BottomNavBar(): LoginPage(),
    );
  }
}
