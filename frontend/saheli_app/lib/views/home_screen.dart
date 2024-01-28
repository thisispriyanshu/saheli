import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saheli_app/common/widgets/customBtn.dart';
import 'package:saheli_app/views/login.dart';
import 'package:saheli_app/widgets/custom_widgets/CustomCarousel.dart';
import 'package:saheli_app/widgets/custom_widgets/custom_appBar.dart';

import '../widgets/emergency.dart';

class HomePage extends StatefulWidget {
  int qIndex=2;


  @override
  State<StatefulWidget> createState()=> _HomePageState();




}

class _HomePageState extends State<HomePage> {
  int qIndex=2;
  getRandomQuote() {
    Random random = Random();
    setState(() {
       qIndex = random.nextInt(6);
    });

  }
  void initState(){
    getRandomQuote();
    super.initState();
  }
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 236, 208),
      body: SafeArea(
      child: Padding(padding: const EdgeInsets.all(8.0),
        child: Column(children: [
        Expanded(
        child: ListView(
        shrinkWrap: true,
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0,top: 8.0,bottom: 9.0,right: 8.0),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 57, 116), fontFamily: 'Montserrat'),

                ),
              ),
            ),

          SizedBox(
            height: 10,
            child: Container(
              color: Colors.grey.shade100,
            ),
          ),
          CustomAppBar(quoteIndex: qIndex,
          onTap: getRandomQuote(),),
           CustomCarouel(),
    SizedBox(height: 10),
            SizedBox(height: 10),
    SizedBox(
    height: 10,
    child: Container(
    color: Colors.grey.shade100,
    ),
    ),
    Expanded(
    child: ListView(
    shrinkWrap: true,
    children: [
    SizedBox(height: 10),
    Align(
    alignment: Alignment.center,
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
    "Incase of emergency dial me",
    style: TextStyle(
    fontSize: 20, fontWeight: FontWeight.bold),
    ),
    ),
    ),
    Emergency(),
    SizedBox(height: 10),
    Align(
    alignment: Alignment.center,
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
    "Explore your power",
    style: TextStyle(
    fontSize: 20, fontWeight: FontWeight.bold),
    ),
    ),
    ),
    SizedBox(height: 10),
        ],),

      ),

    ],),),],),),),);
  }
  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
