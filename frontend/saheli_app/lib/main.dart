import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:saheli_app/common/theme/theme.dart';
import 'package:saheli_app/firebase_options.dart';
import 'package:saheli_app/services/localDb/localDb.dart';
import 'package:saheli_app/views/home.dart';
import 'package:saheli_app/views/login.dart';
import 'package:saheli_app/views/signup.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Styles.themeData(BuildContext),
      home: isLogin ? HomePage() : LoginPage(),
    );
  }
}